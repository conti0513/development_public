# 📚 GCP ACE試験：重要英単語 完全版 v2.1

---

# 🔥 Part 1：ACE重要英単語（急所統合版）

---

## 🔹 1. コンプライアンス・統制・階層系

| Word                      | Meaning  | 試験文脈          |
| ------------------------- | -------- | ------------- |
| Adhere to                 | ～を遵守する   | Google推奨構成に従う |
| Compliant / Compliance    | 法令遵守     | 監査要件を満たす      |
| Enforce                   | 強制する     | 組織ポリシー適用      |
| Constraint                | 制約       | Org Policyで禁止 |
| Audit / Auditor           | 監査 / 監査人 | ログ閲覧用一時権限     |
| Grant                     | 付与する     | IAMロール付与      |
| Granular                  | 粒度が細かい   | Custom Role作成 |
| **Inherit / Inheritance** | 継承する     | ポリシーは上位から継承   |
| Impersonate               | なりすます    | SAキー不要の安全な実行  |

---

## 🔹 2. コスト・課金系

| Word          | Meaning | 試験文脈         |
| ------------- | ------- | ------------ |
| Incur         | 費用が発生する | Egress料金など   |
| Substantial   | 大幅な     | コスト削減        |
| Overhead      | 運用負荷    | 管理手間削減       |
| Consolidate   | 統合する    | 請求アカウント統合    |
| Retrieve      | 取り出す    | Nearline取得課金 |
| QuotaExceeded | 割当超過    | 制限エラー        |

---

## 🔹 3. インフラ・構成・設計思想系

| Word                   | Meaning | 試験文脈          |
| ---------------------- | ------- | ------------- |
| Provision              | 配備する    | VM作成          |
| Execute                | 実行する    | gcloud実行      |
| Prerequisite           | 前提条件    | API有効化必要      |
| Ephemeral              | 一時的     | 一時IP          |
| Preempt                | 中断される   | Spot VM       |
| Interruption           | 中断      | Preemptible停止 |
| Isolated               | 分離      | VPC分離         |
| Egress / Ingress       | 出 / 入   | FW方向          |
| Decouple               | 疎結合にする  | Pub/Sub使用     |
| Stateless              | 状態を持たない | Cloud Run前提   |
| Idempotent             | べき等     | リトライ設計        |
| **Synchronize (Sync)** | 同期する    | GCDS / データ同期  |
| **Monotonically**      | 単調に増加   | Spanner主キー毒   |

---

## 🔹 4. 可用性・運用系

| Word               | Meaning | 試験文脈                |
| ------------------ | ------- | ------------------- |
| Retain / Retention | 保持期間    | ログ保存日数              |
| Durable            | 耐久性     | GCS durability      |
| Consistent         | 一貫性     | Spanner強み           |
| High Availability  | 高可用性    | マルチゾーン              |
| Unresponsive       | 応答なし    | Autohealing         |
| Disruption         | 停止      | minimal disruption  |
| Mitigate           | 軽減する    | リスク対策               |
| Exhaustion         | 枯渇      | IP不足                |
| Expire             | 期限切れ    | SAキー失効              |
| Unoccupied         | 待機中     | Idle VM             |
| Accidental         | 誤操作     | accidental deletion |
| Proprietary        | 独自      | 自社開発SW              |

---

# 🧠 Part 2：分野別論点マップ（ACE完成版）

---

# ① 環境設定（Setting up Environment）

## 🔹 リソース階層

```
Organization
   ↓
Folder
   ↓
Project
   ↓
Resources
```

重要：

* IAM / Policy は **Inherit（継承）**
* 請求単位は Project
* Folderは論理分離単位

---

## 🔹 IAM原則

* Googleグループへ付与
* Least Privilege
* Basic roles回避
* Custom Role活用
* Impersonation推奨（鍵DL禁止）

---

## 🔹 Billing

* 1プロジェクト = 1請求アカウント
* Billing Export → BigQuery
* Budget + Alert設定

---

# ② 計画と構成（Planning & Configuring）

## 🔹 Compute選択ロジック

| 要件                   | 正解             |
| -------------------- | -------------- |
| OS依存                 | Compute Engine |
| コンテナ / Scale to Zero | Cloud Run      |
| K8s管理任せたい            | GKE Autopilot  |
| 疎結合イベント              | Pub/Sub        |

---

## 🔹 DB選択ロジック

| 要件         | 正解        |
| ---------- | --------- |
| 分析SQL      | BigQuery  |
| 強一貫性グローバル  | Spanner   |
| IoT高スループット | Bigtable  |
| モバイル向け     | Firestore |

---

## 🔹 Spanner地雷（Hotspot問題）

### ❌ NG例（Monotonically increasing key）

```
order_id = 1
order_id = 2
order_id = 3
```

→ Monotonically increasing key
→ 書き込みが常に「最後尾」に集中
→ 同一ノードにトラフィック偏り
→ Hotspot発生
→ 書き込み性能劣化

---

### 💡 なぜ起きる？

Spannerは：

* 主キーの「キー範囲」でデータを分散
* レンジベースシャーディング

つまり：

```
1〜1000 → Node A
1001〜2000 → Node B
```

のように管理。

単調増加キーだと：

→ すべて最新ノードに集中
→ 分散されない

---

### ✅ 解決策（ACE正解パターン）

✔ UUIDを使う
✔ ハッシュ化キーを使う
✔ ランダム性を持たせる
✔ 先頭にシャーディングキーを付与

例：

```
a3f92-1001
f81d2-1002
```

---

### 🎯 試験での出題パターン

問題文に出るワード：

* "monotonically increasing"
* "high write throughput"
* "hotspot"
* "performance degradation"

この4つが出たら：

→ 主キー設計を疑う
→ UUIDが薬

---

### 🧠 追加インデックス

Spannerで問われるのは：

1. 強一貫性
2. グローバル分散
3. 水平スケール
4. 主キー設計

特に④がACE罠ポイント。

---

### ⚠ ひっかけ

「Auto-scalingを有効にする」

→ それでは解決しない
→ キー設計が根本原因

---

### 🔥 超圧縮覚え方

Spanner =
🌍 グローバルRDB
🔒 強一貫性
📈 水平スケール
☠ Monotonicallyは毒
---

## 🔹 設計キーワード

* Stateless設計
* Idempotent設計
* Decouple設計
* HA設計

---

# ③ デプロイと実装

## 🔹 VPC

* Custom mode VPC
* expand-ip-range
* Private Google Access
* Cloud NAT

---

## 🔹 IaC

```
terraform init
terraform plan
terraform apply
```

---

## 🔹 Migration

* Marketplace
* Database Migration Service
* Storage Transfer Service

---

# ④ 正常運用

## 🔹 Backup

* Snapshot Schedule
* GCS Lifecycle

例：

```
Age > 30 days → Nearline
Age > 365 days → Archive
```

---

## 🔹 Monitoring

* Alerting Policy
* Uptime Check
* Log-based Metrics
* Error Reporting
* Cloud Monitoring

---

# ⑤ セキュリティ

## 🔹 Service Account

* アプリ間認証用
* SAキーは原則NG
* Impersonation優先

---

## 🔹 Identity

* GCDS（Synchronize）
* Workload Identity Federation
* IAP

---

## 🔹 DB接続

* Cloud SQL Auth Proxy
* Private IP接続

---

# 🧠 ACE試験の本質（固定）

> 最小の運用負荷で、最もGoogleらしい構成を選べるか

さらに：

> 毒（アンチパターン）を避け、薬（マネージド）を選べるか

---

# 🎯 これで語彙は完成レベル

* IAM階層OK
* Spanner罠OK
* AD連携OK
* Sync問題OK
* コスト罠OK

---
