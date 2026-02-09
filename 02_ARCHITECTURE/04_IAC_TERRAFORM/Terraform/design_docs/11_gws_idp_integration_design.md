# GWS・IdP統合検証環境の構築

## SAML 認証・DNS（SPF / DMARC）デバッグ最終版

---

## 1. 目的（Why）

本ドキュメントは、
**Google Workspace（GWS）におけるドメイン移行・SSO統合時の不確実性を、
実装とログによって“技術的に潰す”ための検証環境**を記録したものである。

単なる設定確認ではなく、以下を目的とする。

> **SSO認証とメール配送の失敗を
> 「再現でき」「検知でき」「説明できる」状態を作ること**

---

## 2. 検証方針（設計思想）

本検証は、以下の思想に基づいて設計されている。

* **ブラックボックスを作らない**
* **UIではなく、プロトコルとログで判断する**
* **失敗を“仕様通りに失敗させる”ことで理解度を上げる**

そのため、
SSOは **SAML Response**、
メールは **DNS（SPF / DMARC）** を直接観測対象とする。

---

## 3. 全体アーキテクチャ

### 3.1 構成概要

1. **Cloud Run（自作ACS / フラップゲート）**

   * SAML Response を受信
   * Base64 デコード
   * XML 内のドメイン情報を検査・ログ出力

2. **Cloud DNS**

   * SPF / DMARC レコードを Terraform 管理
   * 正常系／異常系を即時に切り替え可能

---

### 3.2 論理構成図

```text
[ User Browser ]
      |
      | (SAML Auth Request)
      v
[ Google Workspace (IdP) ]
      |
      | (SAML Response / POST)
      v
[ Cloud Run : Flap Gate (ACS) ]
      |
      | Decode / Inspect NameID
      v
[ Cloud Logging ]
      |
      +--> old-domain → WARN
      +--> new-domain → OK
```

---

## 4. 実装内容

### 4.1 フラップゲート（SAML解析）

**役割**
SAML認証の「関所（Gate）」として振る舞い、
旧ドメイン・新ドメインを即座に判定する。

**処理内容**

1. `POST /saml/acs` で `SAMLResponse` を受信
2. Base64（＋必要に応じて zlib）でデコード
3. XML文字列をスキャン
4. `@old-domain.com` / `@new-domain.com` を判定
5. 結果を Cloud Logging に出力

> ※ DOMパースを行わず、**テキストスキャン方式**を採用
> → SAML仕様差分に強く、検証用途として保守性が高い

---

### 4.2 インフラ（Terraform）

Terraform で以下を定義。

* **Cloud Run**

  * `allow_unauthenticated = true`
  * 検証用途のため認証を排除
* **Cloud DNS Managed Zone**
* **DNS Records**

  * SPF（TXT）
  * DMARC（TXT）

すべて **IaC 管理** とし、
「設定がどうなっているか」をコードで説明可能な状態を維持する。

---

## 5. 検証シナリオ

### 5.1 SSO検証（SAML）

| ケース   | 入力                | 判定   | ログ         |
| ----- | ----------------- | ---- | ---------- |
| 旧ドメイン | `@old-domain.com` | ❌ NG | WARN（移行漏れ） |
| 新ドメイン | `@new-domain.com` | ✅ OK | INFO       |

**成果**

* 「ログイン失敗」ではなく
  **「どのユーザーが、なぜ失敗したか」** を即時に特定可能

---

### 5.2 DNS検証（SPF / DMARC）

* `dig` による即時確認
* TTLの挙動確認
* SPF失敗パターンを意図的に作成し、
  メールヘッダ・配送結果の差分を観測

---

## 6. 得られた知見（重要）

### 6.1 SSOは“魔法”ではない

* SSOの正体は **XML + 鍵情報**
* デコードすれば **人間が読める世界**になる
* 判定ロジックは **管理者側で自由に作れる**

---

### 6.2 移行トラブルは「検知できない」ことが問題

* 従来：

  * ユーザー申告ベース
  * 原因特定が遅れる
* 本手法：

  * ログで即時検知
  * 問い合わせ前に把握可能

---

### 6.3 Terraform × 検証は武器になる

* 「設定したはず」ではなく
  **「このコードです」** と言える
* 商談・設計レビューで
  **技術的主導権を握れる**

---

## 7. 運用上の示唆（商談で使えるポイント）

* ドメイン移行時は

  * **SSO**
  * **メール**
    を別物として扱うべき
* どちらも

  * UI確認では不十分
  * プロトコルとログが正解

---

## 8. 撤収（クリーンアップ）

検証完了後は即時削除。

```bash
terraform destroy \
  -var="project_id=terraform-sandbox-lab" \
  -auto-approve
```

---

## 9. 結論

本検証により、

* SSO認証
* DNS（SPF / DMARC）
* ドメイン移行時の失敗パターン

を **実装とログで完全に可視化** できた。

