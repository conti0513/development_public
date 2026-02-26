# 📚 GCP ACE試験：重要英単語 30選（整理版）

## 🔹 1. コンプライアンス・統制系

| Word                   | Meaning  | 試験文脈          |
| ---------------------- | -------- | ------------- |
| Adhere to              | ～を遵守する   | Google推奨構成に従う |
| Compliant / Compliance | 法令遵守     | 監査要件を満たす      |
| Enforce                | 強制する     | 組織ポリシー適用      |
| Constraint             | 制約       | Org Policyで禁止 |
| Audit / Auditor        | 監査 / 監査人 | ログ閲覧用一時権限     |
| Grant                  | 付与する     | IAMロール付与      |
| Granular               | 粒度が細かい   | 細かいIAM設定      |

---

## 🔹 2. コスト・課金系

| Word        | Meaning | 試験文脈         |
| ----------- | ------- | ------------ |
| Incur       | 費用が発生する | Egress料金など   |
| Substantial | 大幅な     | コスト削減        |
| Overhead    | 運用負荷    | 管理手間削減       |
| Consolidate | 統合する    | 請求アカウント統合    |
| Retrieve    | 取り出す    | Nearline取得課金 |

---

## 🔹 3. インフラ・構成系

| Word             | Meaning | 試験文脈     |
| ---------------- | ------- | -------- |
| Provision        | 配備する    | VM作成     |
| Execute          | 実行する    | gcloud実行 |
| Prerequisite     | 前提条件    | API有効化必要 |
| Ephemeral        | 一時的     | 一時IP     |
| Preempt          | 中断される   | Spot VM  |
| Isolated         | 分離      | VPC分離    |
| Egress / Ingress | 出 / 入   | FW方向     |

---

## 🔹 4. 可用性・運用系

| Word               | Meaning | 試験文脈                |
| ------------------ | ------- | ------------------- |
| Retain / Retention | 保持期間    | ログ保存日数              |
| Durable            | 耐久性     | GCS durability      |
| Consistent         | 一貫性     | Spanner強み           |
| Unresponsive       | 応答なし    | Autohealing         |
| Disruption         | 停止      | minimal disruption  |
| Mitigate           | 軽減する    | リスク対策               |
| Exhaustion         | 枯渇      | IP不足                |
| Expire             | 期限切れ    | SAキー失効              |
| Unoccupied         | 待機中     | Idle VM             |
| Accidental         | 誤操作     | accidental deletion |
| Proprietary        | 独自      | 自社開発SW              |

---

# 🧠 GCP ACE 分野別論点マップ（整理版）

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

* ポリシーは上位から継承
* 請求単位はProject

---

## 🔹 IAM原則

* Googleグループにロール付与
* Least Privilege
* Basic rolesは避ける
* Predefined / Custom role優先

---

## 🔹 プロジェクト属性

| 項目             | 変更可否 |
| -------------- | ---- |
| Project Name   | 変更可能 |
| Project ID     | 不変   |
| Project Number | 不変   |

---

## 🔹 Billing

* 1プロジェクト = 1請求アカウント
* Billing Export → BigQuery

---

# ② 計画と構成（Planning & Configuring）

## 🔹 Compute選択ロジック

| 要件                   | 正解             |
| -------------------- | -------------- |
| OS依存                 | Compute Engine |
| コンテナ / Scale to Zero | Cloud Run      |
| K8s管理任せたい            | GKE Autopilot  |

---

## 🔹 DB選択ロジック

| 要件         | 正解        |
| ---------- | --------- |
| 分析SQL      | BigQuery  |
| 強一貫性グローバル  | Spanner   |
| IoT高スループット | Bigtable  |
| モバイル向け     | Firestore |

---

# ③ デプロイと実装

## 🔹 VPC

* Custom mode VPC
* expand-ip-range コマンド

---

## 🔹 IaC

```
terraform init
terraform plan
terraform apply
```

---

## 🔹 Migration

* Marketplaceで迅速展開
* Database Migration Serviceも出題対象

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
* Cloud Logging
* Cloud Monitoring

---

# ⑤ セキュリティ

## 🔹 Service Account

* アプリ間認証用
* ユーザーアカウント使用禁止

---

## 🔹 Identity Federation

* GCDS → AD同期
* Workload Identity Federation

---

## 🔹 DB接続

* Cloud SQL Auth Proxy

---

# 🧠 試験で問われる本質

ACEは：

> 「最小の管理負荷で、最もGoogleらしい構成を選べるか」

---

