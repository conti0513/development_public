# GCP Service Selection（ACE 2026）

---

# 1. Service Selection 概要

## 1.1 ACE試験の核心

ACE試験では **適切なGCPサービスを選択する能力**が問われる。

問題の基本構造は以下。

```
要件
↓
キーワード
↓
GCPサービス
```

つまり

```
Workload → Service
```

の対応関係を理解することが重要。

---

## 1.2 サービス分類

GCPサービスは大きく以下のカテゴリに分かれる。

```
Compute
Storage
Database
Analytics
Networking
Security
Operations
Cost Management
```

---

# 2. Compute サービス

## 2.1 Compute概要

Computeは **アプリケーションを実行するための計算リソース**。

---

## 2.2 主なComputeサービス

| 用途        | サービス                   |
| --------- | ---------------------- |
| VM        | Compute Engine         |
| コンテナ      | Cloud Run / GKE        |
| HTTPサーバレス | Cloud Run              |
| イベント処理    | Cloud Functions        |
| バッチ処理     | Compute Engine / Batch |

---

## 2.3 ACE判断

```
VM必要
→ Compute Engine

Docker container
→ Cloud Run

大規模Kubernetes
→ GKE
```

---

# 3. Storage サービス

## 3.1 Storage概要

Storageは **データ保存のためのサービス群**。

---

## 3.2 主なStorageサービス

| 用途        | サービス            |
| --------- | --------------- |
| オブジェクト保存  | Cloud Storage   |
| 共有ファイル    | Filestore       |
| ブロックストレージ | Persistent Disk |
| 長期保存      | Archive Storage |

---

## 3.3 ACE判断

```
画像保存
→ Cloud Storage

VMディスク
→ Persistent Disk

共有NFS
→ Filestore
```

---

# 4. Database サービス

## 4.1 Database概要

Databaseサービスは **データ管理・トランザクション処理**を行う。

---

## 4.2 主なDatabaseサービス

| 用途                 | サービス          |
| ------------------ | ------------- |
| MySQL / PostgreSQL | Cloud SQL     |
| グローバルRDB           | Cloud Spanner |
| 大規模NoSQL           | Bigtable      |
| モバイルDB             | Firestore     |
| 分析DB               | BigQuery      |

---

## 4.3 ACE判断

```
PostgreSQL
→ Cloud SQL

グローバルDB
→ Spanner

モバイルアプリ
→ Firestore

分析
→ BigQuery
```

---

# 5. Analytics / Messaging

## 5.1 Analytics概要

Analyticsは **データ分析・イベント処理**のためのサービス群。

---

## 5.2 主なサービス

| 用途      | サービス     |
| ------- | -------- |
| データ分析   | BigQuery |
| ログ分析    | BigQuery |
| ストリーミング | Pub/Sub  |
| ETL     | Dataflow |

---

## 5.3 ACE判断

```
ログ分析
→ BigQuery

イベント処理
→ Pub/Sub

データ処理
→ Dataflow
```

---

# 6. Networking

## 6.1 Networking概要

Networkingは **ネットワーク接続と通信制御**を提供する。

---

## 6.2 主なサービス

| 用途        | サービス                    |
| --------- | ----------------------- |
| 仮想ネットワーク  | VPC                     |
| ロードバランシング | Cloud Load Balancing    |
| Private接続 | Private Service Connect |
| VPN接続     | Cloud VPN               |
| 専用線       | Interconnect            |

---

## 6.3 ACE判断

```
オンプレ接続
→ Cloud VPN

Google API private access
→ Private Google Access

内部サービス公開
→ Private Service Connect
```

---

# 7. Security

## 7.1 Security概要

Securityサービスは **アクセス管理・データ保護**を提供する。

---

## 7.2 主なサービス

| 用途     | サービス                 |
| ------ | -------------------- |
| アクセス制御 | IAM                  |
| アプリ認証  | Service Account      |
| 秘密管理   | Secret Manager       |
| 鍵管理    | Cloud KMS            |
| データ境界  | VPC Service Controls |

---

## 7.3 ACE判断

```
API認証
→ Service Account

パスワード保存
→ Secret Manager

暗号鍵
→ Cloud KMS
```

---

# 8. Serverless

## 8.1 Serverless概要

Serverlessは **インフラ管理なしで実行できるサービス群**。

---

## 8.2 主なServerlessサービス

| 用途       | サービス            |
| -------- | --------------- |
| HTTP API | Cloud Run       |
| イベント処理   | Cloud Functions |
| ワークフロー   | Workflows       |
| メッセージ処理  | Pub/Sub         |

---

## 8.3 ACE判断

```
HTTP container
→ Cloud Run

イベント処理
→ Cloud Functions

複数サービス連携
→ Workflows
```

---

# 9. Operations

## 9.1 Operations概要

Operationsは **運用監視とログ管理**を行う。

---

## 9.2 主なサービス

| 用途   | サービス             |
| ---- | ---------------- |
| ログ管理 | Cloud Logging    |
| 監視   | Cloud Monitoring |
| アラート | Alert Policy     |
| ログ分析 | BigQuery         |

---

## 9.3 ACE判断

```
CPU監視
→ Cloud Monitoring

ログ検索
→ Cloud Logging

ログ分析
→ BigQuery Export
```

---

# 10. Cost Management

## 10.1 Cost概要

Cost Managementは **クラウド利用コストの管理機能**。

---

## 10.2 主なサービス

| 用途    | サービス               |
| ----- | ------------------ |
| 費用見積  | Pricing Calculator |
| 予算通知  | Budget Alerts      |
| コスト分析 | Billing Export     |

---

## 10.3 ACE判断

```
コスト可視化
→ Billing Export

予算通知
→ Budget Alerts
```

---

# 11. Service Selection Flow

サービス選択の基本フロー

```
問題
↓
ワークロード分類

Compute
Storage
Database
Analytics
Networking
Security

↓
サービス選択
```

---

# 12. ACE重要マッピング

```
VM
→ Compute Engine

Container API
→ Cloud Run

Kubernetes
→ GKE

Object Storage
→ Cloud Storage

RDB
→ Cloud SQL

Global DB
→ Spanner

NoSQL
→ Firestore

Analytics
→ BigQuery

Messaging
→ Pub/Sub

Secrets
→ Secret Manager
```

---

# 13. ACEトラップ

## Trap1

```
PostgreSQL
```

Spanner → ❌
Cloud SQL → ✅

---

## Trap2

```
ログ分析
```

Cloud Logging → ❌
BigQuery → ✅

---

## Trap3

```
API container
```

Compute Engine → ❌
Cloud Run → ✅

---

## Trap4

```
パスワード保存
```

Env variable → ❌
Secret Manager → ✅

---

# 14. 試験攻略

ACE問題は以下の思考で解く。

```
要件
↓
ワークロード分類
↓
サービス選択
```

例

```
Docker
→ Cloud Run

PostgreSQL
→ Cloud SQL

Analytics
→ BigQuery

Messaging
→ Pub/Sub

Secrets
→ Secret Manager
```

---

# 15. 2026 ACE頻出サービス

ACE試験で頻出のサービス。

```
Compute Engine
Cloud Run
Cloud Storage
Cloud SQL
BigQuery
Pub/Sub
Secret Manager
IAM
Cloud Monitoring
```

---

# 16. まとめ

```
Compute
→ Compute Engine

Container
→ Cloud Run

Storage
→ Cloud Storage

Database
→ Cloud SQL

Analytics
→ BigQuery

Messaging
→ Pub/Sub

Security
→ IAM / Secret Manager
```

---

# 17. GCP Service Selection 用語集（ACE 2026）

| 用語                 | 定義               | 用途                  |
| ------------------ | ---------------- | ------------------- |
| Compute Engine     | GCPの仮想マシンサービス    | VM実行                |
| Cloud Run          | サーバレスコンテナ実行環境    | HTTP API / マイクロサービス |
| GKE                | Kubernetes管理サービス | コンテナオーケストレーション      |
| Cloud Storage      | オブジェクトストレージ      | 画像・ファイル保存           |
| Persistent Disk    | VM用ブロックストレージ     | VMディスク              |
| Cloud SQL          | マネージドRDB         | MySQL / PostgreSQL  |
| Cloud Spanner      | 分散リレーショナルDB      | グローバルシステム           |
| Firestore          | Document型NoSQL   | モバイルアプリ             |
| BigQuery           | データウェアハウス        | 分析                  |
| Pub/Sub            | メッセージングサービス      | イベント処理              |
| Dataflow           | ストリーム / バッチデータ処理 | ETL                 |
| IAM                | アクセス管理サービス       | 権限管理                |
| Service Account    | アプリケーション用ID      | API認証               |
| Secret Manager     | 機密情報管理           | パスワード保存             |
| Cloud Monitoring   | メトリクス監視          | CPU / Latency監視     |
| Cloud Logging      | ログ管理             | ログ検索                |
| Pricing Calculator | GCP費用見積ツール       | コスト試算               |
| Billing Export     | 課金データ分析機能        | コスト可視化              |

---
