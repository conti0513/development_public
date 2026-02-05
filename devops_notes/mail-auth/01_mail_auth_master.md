# BIMI導入およびSPF境界値検証  
## QA・デプロイ計画書（mail-auth）

---

## 1. 目的

本ドキュメントは、ビジネスサイドからの  
**BIMI（Brand Indicators for Message Identification）導入要望** に対し、

既存のメール基盤  
（ロストテクノロジー化した構成・外部PF依存を含む）への影響を最小限に抑えつつ、  
**RFC 7208（SPF 10-Lookup 制限）を遵守した安全なデプロイ**を実現するための、

- 試験計画（QA）
- 本番反映手順
- ロールバック方針
- 運用上の注意点

を整理することを目的とする。

※ BIMI自体は SPF Lookup 数を増加させないが、  
DMARC enforcement（`p=quarantine / reject`）を前提とするため、  
**既存SPFレコードの境界値検証を必須要件**とする。

---

## 2. 全体アーキテクチャ（論理構成）

BIMI表示に至るまでの認証フローと、  
検証対象となるポイントを整理する。

```mermaid
graph TD
    subgraph "External DNS"
        SPF[SPF Record<br/>10 Lookups Limit]
        DMARC[DMARC Record<br/>p=quarantine / reject]
        BIMI[BIMI Record<br/>default._bimi]
    end

    subgraph "Mail Platform (STG / PROD)"
        Sender[Mail Delivery Platform]
    end

    subgraph "Receiver (Gmail / Apple Mail / M365 等)"
        Auth{Authentication}
        Logo[BIMI Logo Display]
    end

    Sender -->|Mail with DKIM| Auth
    Auth -->|Check| SPF
    Auth -->|Check| DMARC
    Auth -->|Check| BIMI

    SPF -->|PermError| Reject[Reject / Spam]
    DMARC -->|Compliant| Logo
````

---

## 3. テスト計画（QA Matrix）

### 3.1 ステージング環境（STG）

**目的：**
論理的正当性と、既存メール基盤との **非干渉性** を証明する。

| フェーズ | テスト項目      | 観点                 | 合格基準                | ロールバック          |
| ---- | ---------- | ------------------ | ------------------- | --------------- |
| 単体   | SPF再帰カウント  | RFC 7208準拠         | Lookup数 ≤ 10        | レコード差し戻し        |
| 単体   | BIMI SVG検証 | Tiny PS規格          | ValidatorでAll Green | SVG差し替え         |
| 結合   | 認証試験       | SPF / DKIM / DMARC | 全て `pass`           | DMARCを `p=none` |
| 反映   | ロゴ表示       | 視覚確認               | 主要メーラーで表示           | BIMIレコード削除      |

---

### 3.2 本番環境（PROD）

**目的：**
既存配信を止めず、ビジネス価値（ロゴ表示）を段階的に解放する。

| フェーズ | テスト項目 | 観点        | 合格基準      | ロールバック    |
| ---- | ----- | --------- | --------- | --------- |
| 単体   | IaC反映 | 差分管理      | DNS追加のみ   | state復元   |
| 結合   | 限定配信  | 境界値検証     | 社内限定で表示   | TTL短縮後に削除 |
| 反映   | 全体公開  | DMARCレポート | 拒否率が上昇しない | 即時レコード撤回  |

---

## 4. 重点検証項目（エンジニア視点）

### 4.1 SPF 10-Lookup 境界値テスト（RFC 7208）

**「たまたま届く状態」を許容しない。**

#### 単体試験

* `spf_counter.sh` による再帰数の自動計測
* [ ] 現行Lookup数の把握
* [ ] BIMI導入前後での差分確認

#### ネガティブ試験

* Lookup数 = 11 のSPFを一時的に作成
* 受信側で `PermError` が発生することを確認

---

### 4.2 ロールバック・プロトコル

**戻せない変更はしない。**

1. **TTL短縮**
   変更24時間前に TTL を 60〜300秒へ変更
2. **State保護**
   Terraform実行前に state バックアップを確認
3. **報告ライン確立**
   社内関係者（例：ゾス）へ
   「即時ロールバック可能」であることを完了条件とする

---

## 5. 運用保守

* **DMARC監視**
  週次でRUAレポートを確認し、BIMI非表示送信元を検知
* **SVG資産管理**
  ロゴ更新時は必ず Tiny PS 変換・検証を実施

---

## 6. 補足：SPFは「誰が」「どこまで」DNSを見るのか

### 実践：Google Cloud DNS（送信側） → M365（受信側・審判）

SPF Lookup は **送信側ではなく、受信側が審判として実行する**。

```text
[ 送信側：あなたのインフラ ]                    [ 受信側：相手(M365)のインフラ ]
(Google Cloud DNS で管理)                      (Exchange Online 審判)
+------------------------+                    +----------------------------+
|  Cloud DNS (権威)      |                    |  M365 受信ゲートウェイ       |
+-----------+------------+                    +------------+---------------+
            ^                                              |
            | (1) メール受信                               |
            |                                              |
            | (2) SPF Lookup #1                            |
            +<---------------------------------------------+
            | example.com の SPF を取得                   | [累計: 1]
            |                                              |
            | (3) include 再帰                            |
            +<---------------------------------------------+
            | Google / 外部PF DNS                          | [累計: 2…]
```

---

### 実務的なポイント

* **審判は常に受信側（M365 / Gmail）**
* Cloud DNS は「最初に見られる看板」にすぎない
* include 先 DNS の

  * 応答遅延
  * 障害
  * 再帰深度
    がそのまま **不達リスク** になる

---

## 7. DNS名前解決の旅（Fromドメイン分離の本質）

### 🔍 `news@mag.test.com` の SPF 判定フロー

```text
[ 受信側サーバー（審判）]
      |
      | 1. .com の番人に聞く
      +--> [.com 共通DNS]
      |    「test.com は Route53」
      |
      | 2. 親ドメインに聞く
      +--> [Route53 (test.com)]
      |    「mag.test.com の看板はこれ」
      |
      | 3. 子ドメインのSPFを見る
      +--> [mag.test.com TXT]
           "v=spf1 include:aaa.com ~all"
           ★ ここで10回制限カウント開始
```

---

### 💡 なぜこれで「OK」になるのか

| 観点       | 親ドメイン (`test.com`) | サブドメイン (`mag.test.com`) |
| -------- | ------------------ | ----------------------- |
| 審判が見るSPF | 親のSPFのみ            | **子のSPFのみ**             |
| Lookup対象 | 全部合算               | **メルマガ分だけ**             |
| リスク      | 高                  | **制御可能**                |

---

## 8. サブドメインの作成場所（FIX）

**サブドメインは「親ドメインを管理しているDNS」で作成する。**

* Route53 で `test.com` を管理している場合
  → **同一 Hosted Zone に `mag.test.com` の TXT/SPF を追加**
* Cloud DNS / 他DNS でも原則は同じ
  → **委任は不要。SPFはTXTレコード1本で完結**

※ 親ドメインの SPF に
`include:mag.test.com` を書く必要は **ない**
（Fromドメインが異なるため、審判は参照しない）

---

## 9. 設計者としてのまとめ

* SPFは **DNS設計の問題**
* 判定は **常に受信側**
* サブドメイン分離は
  **10-Lookup制限をリセットする唯一の安全策**

この構造を理解していれば、

> 「M365側のSPF判定では、
> 外部PFのDNSレスポンス遅延や再帰回数がリスクになります」

という **一段上の設計指摘** が可能になる。

---
