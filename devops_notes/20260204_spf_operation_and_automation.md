# SPFの運用と自動化  
## メールフロー視点での設計（Pass / Softfail / Fail）

---

## 1. SPF運用の技術論点（チェックリスト）

- **DNS Lookup 制限（10回ルール）**
  - `include` / `a` / `mx` などの参照は **合計10回まで**
  - 超過すると **Permerror** となり、不達の直接原因になる

- **集約の原則**
  - 1ドメイン＝1 SPFレコード
  - 追加時は新規作成せず、既存レコードの  
    **`~all` / `-all` の直前に追記**

- **メールフロー上の判定**
  - **Pass**  
    - 送信元IPがSPFに含まれている
    - 正常受信
  - **Softfail（`~all`）**  
    - 未登録IPだが受信は許可
    - 迷惑メールフォルダ行きのリスク
  - **Fail（`-all`）**  
    - 未登録IPは受信拒否
    - 厳格だが誤設定時の影響が大きい

- **構文ルール**
  - `v=spf1` で開始
  - 255文字制限
  - 長文化する場合は **二重引用符で分割管理**

---

## 2. SPF自動検証アーキテクチャ（TO-BE）

手動チェックから  
**「継続的バリデーション」** への進化を可視化する。

```mermaid
graph TD
  %% ===== DNS / Monitoring =====
  subgraph DNSMON["DNS / 運用監視"]
    DNS["Route 53 / DNS"]
    Check["Lambda / CI<br/>自動SPFバリデータ"]
  end

  %% ===== Automation Flow =====
  subgraph AUTO["自動テストフロー"]
    Trigger["設定変更 / 定期実行"] --> Parse["構文・重複チェック"]
    Parse --> Count["Lookup回数 <= 10 ?"]
    Count --> Mail["実送テスト API"]
  end

  %% ===== Mail Flow =====
  subgraph FLOW["メール判定フロー"]
    Sender["送信元IP"] --> DNS
    DNS --> Result{"SPF判定"}
    Result -->|登録済| Pass["Pass<br/>正常受信"]
    Result -->|未登録/超過| Risk["Softfail / Permerror<br/>不達リスク"]
  end

  Check -.-> DNS
  Check --- Trigger
````

---

## 3. 自動化案のコンパクトまとめ

### 3.1 静的解析（CI）

* GitHub Actions 等で以下を自動検証

  * SPF構文の正当性
  * DNS Lookup 回数の算出
* 制限超過・構文エラー時は **ビルドエラーで即検知**

### 3.2 動的監視（Lambda）

* `dig` / `nslookup` を定期実行
* 現在のDNSレコードと
  **期待値（Golden Record）** を比較
* 差分が出た場合はアラート通知

### 3.3 実疎通テスト

* Mail-tester 等のAPIを利用
* 実際にメールを送信し、

  * SPFが **Pass** になるか
  * 想定外の判定が出ていないか
    を定期的に自動検証

---

## 提言：ビジネスサイドへの伝え方

> 単にドメインを追加するだけでなく、
> メールフロー上の判定（Pass / Softfail / Fail）を制御し、
> **「届かないリスク」を自動で検知する仕組み**を導入しています。
>
> SPFの10回制限という技術的な壁を
> コードで常時監視することで、
> 将来の拡張によるメール不達事故を未然に防ぎます。


---
