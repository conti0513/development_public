# ACE Exam Traps（2026）

---

# 1. ACE試験の特徴

## 1.1 ACEは知識試験ではない

ACE試験は単なる知識問題ではなく、**適切なGCPサービスを選択できるか**が問われる。

試験の基本構造

```text
要件
↓
キーワード
↓
GCPサービス選択
```

つまり

```text
Workload → Service
```

の対応を理解することが重要。

---

# 2. Compute Traps

## 2.1 Trap 1 — VMコスト削減

要件

```
VMコスト削減
```

誤り

```
delete VM
```

正解

```
stop VM
```

理由

deleteすると **ディスクなどのデータが消える可能性がある**。

---

## 2.2 Trap 2 — Docker API

要件

```
Docker container API
```

誤り

```
Compute Engine
```

正解

```
Cloud Run
```

理由

Cloud Runは **コンテナをサーバレスで実行できる**。

---

## 2.3 Trap 3 — Auto Scaling Container

要件

```
コンテナの自動スケーリング
```

誤り

```
VM
```

正解

```
Cloud Run
GKE
```

---

## 2.4 Trap 4 — 短時間バッチ

要件

```
短時間バッチ
```

誤り

```
Standard VM
```

正解

```
Spot VM
```

理由

Spot VMは **低コストの短時間実行向けVM**。

---

# 3. Storage Traps

## 3.1 Trap 5 — 画像保存

要件

```
画像保存
```

誤り

```
Persistent Disk
```

正解

```
Cloud Storage
```

---

## 3.2 Trap 6 — 長期保存

要件

```
長期保存
```

誤り

```
Standard Storage
```

正解

```
Archive Storage
```

---

## 3.3 Trap 7 — 共有ファイル

要件

```
共有ファイル
```

誤り

```
Cloud Storage
```

正解

```
Filestore
```

理由

Filestoreは **NFS共有ストレージ**。

---

# 4. Database Traps

## 4.1 Trap 8 — PostgreSQL移行

要件

```
PostgreSQL移行
```

誤り

```
Spanner
```

正解

```
Cloud SQL
```

---

## 4.2 Trap 9 — 巨大RDB

要件

```
巨大RDB
```

誤り

```
Cloud SQL
```

正解

```
Cloud Spanner
```

---

## 4.3 Trap 10 — モバイルアプリDB

要件

```
モバイルアプリDB
```

誤り

```
Bigtable
```

正解

```
Firestore
```

---

## 4.4 Trap 11 — 分析DB

要件

```
分析DB
```

誤り

```
Cloud SQL
```

正解

```
BigQuery
```

---

# 5. Analytics Traps

## 5.1 Trap 12 — ログ分析

要件

```
ログ分析
```

誤り

```
Cloud Logging
```

正解

```
BigQuery
```

---

## 5.2 Trap 13 — メッセージング

要件

```
イベントメッセージング
```

誤り

```
Cloud Tasks
```

正解

```
Pub/Sub
```

---

## 5.3 Trap 14 — ETL

要件

```
ETL処理
```

誤り

```
Compute Engine
```

正解

```
Dataflow
```

---

# 6. Networking Traps

## 6.1 Trap 15 — オンプレ接続

要件

```
オンプレ接続
```

誤り

```
Public IP
```

正解

```
Cloud VPN
```

---

## 6.2 Trap 16 — Private Google API

要件

```
Private Google API access
```

誤り

```
External IP
```

正解

```
Private Google Access
```

---

## 6.3 Trap 17 — グローバルLB

要件

```
グローバルロードバランシング
```

誤り

```
VM Load Balancer
```

正解

```
Cloud Load Balancing
```

---

# 7. Security Traps

## 7.1 Trap 18 — アプリ認証

要件

```
アプリ認証
```

誤り

```
User account
```

正解

```
Service Account
```

---

## 7.2 Trap 19 — パスワード保存

要件

```
パスワード保存
```

誤り

```
Environment variable
```

正解

```
Secret Manager
```

---

## 7.3 Trap 20 — 最小権限

要件

```
Least privilege
```

誤り

```
Owner
```

正解

```
Predefined roles
```

---

## 7.4 Trap 21 — 鍵管理

要件

```
暗号鍵管理
```

誤り

```
Manual key
```

正解

```
Cloud KMS
```

---

## 7.5 Trap 22 — データ持ち出し防止

要件

```
データ持ち出し防止
```

誤り

```
Firewall
```

正解

```
VPC Service Controls
```

---

# 8. Monitoring Traps

## 8.1 Trap 23 — CPU監視

要件

```
CPU監視
```

誤り

```
Cloud Logging
```

正解

```
Cloud Monitoring
```

---

## 8.2 Trap 24 — ログ検索

要件

```
ログ検索
```

誤り

```
Cloud Monitoring
```

正解

```
Cloud Logging
```

---

## 8.3 Trap 25 — ログ分析

要件

```
ログ分析
```

誤り

```
Cloud Logging
```

正解

```
BigQuery Export
```

---

# 9. Cost Traps

## 9.1 Trap 26 — 費用見積

要件

```
費用見積
```

誤り

```
Spreadsheet
```

正解

```
Pricing Calculator
```

---

## 9.2 Trap 27 — 予算通知

要件

```
予算通知
```

誤り

```
Cloud Monitoring
```

正解

```
Budget Alerts
```

---

## 9.3 Trap 28 — コスト分析

要件

```
コスト分析
```

誤り

```
Billing console
```

正解

```
Billing Export
```

---

## 9.4 Trap 29 — 長期割引

要件

```
長期利用割引
```

誤り

```
Sustained Use Discount
```

正解

```
Committed Use Discount
```

---

## 9.5 Trap 30 — 自動割引

要件

```
自動割引
```

誤り

```
Committed Use Discount
```

正解

```
Sustained Use Discount
```

---

# 10. 試験攻略

ACE問題は以下の思考で解く。

```text
要件
↓
キーワード
↓
GCPサービス
```

例

```text
Docker → Cloud Run
PostgreSQL → Cloud SQL
Analytics → BigQuery
Secrets → Secret Manager
```

---

# 11. ACE頻出サービス

ACE試験で特に頻出のサービス。

```text
Cloud Run
Compute Engine
Cloud Storage
Cloud SQL
BigQuery
Pub/Sub
Secret Manager
IAM
Cloud Monitoring
```

---

# 12. 最重要トラップ

```text
PostgreSQL → Cloud SQL
ログ分析 → BigQuery
Container API → Cloud Run
Secrets → Secret Manager
```

---

# 13. まとめ

ACE試験は **GCPらしいサービスを選ぶ試験**。

```text
VM → Compute Engine
Container → Cloud Run
DB → Cloud SQL
Analytics → BigQuery
Secrets → Secret Manager
```

---

# GCP ACE Exam Trap 用語集（2026）

| 用語                 | 定義              | 用途                 |
| ------------------ | --------------- | ------------------ |
| Compute Engine     | GCPの仮想マシンサービス   | VM実行               |
| Cloud Run          | サーバレスコンテナ実行サービス | API / マイクロサービス     |
| Cloud Storage      | オブジェクトストレージ     | ファイル保存             |
| Persistent Disk    | VM用ブロックストレージ    | VMディスク             |
| Filestore          | NFS共有ファイルストレージ  | 共有ファイル             |
| Cloud SQL          | マネージドRDB        | MySQL / PostgreSQL |
| Cloud Spanner      | 分散リレーショナルDB     | グローバルDB            |
| Firestore          | Document型NoSQL  | モバイルアプリ            |
| BigQuery           | データウェアハウス       | 分析                 |
| Pub/Sub            | メッセージングサービス     | イベント処理             |
| Dataflow           | データ処理サービス       | ETL                |
| Secret Manager     | 機密情報管理          | パスワード / APIキー      |
| Cloud Monitoring   | メトリクス監視         | CPU / Latency      |
| Cloud Logging      | ログ管理            | ログ検索               |
| Pricing Calculator | 費用見積ツール         | コスト試算              |
| Billing Export     | 課金データ分析機能       | コスト分析              |

---
