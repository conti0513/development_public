# GCP ACE 試験直前チートシート（2026）

---

# 1. Service Selection（最重要）

ACEは **サービス選択問題が中心**。

| 要件                       | サービス                           |
| ------------------------ | ------------------------------ |
| コンテナ / HTTP / serverless | Cloud Run                      |
| Kubernetes               | GKE (Google Kubernetes Engine) |
| VM                       | Compute Engine                 |
| 簡単なWebアプリ                | App Engine                     |
| イベント処理                   | Cloud Functions                |

---

# 2. Database

| 要件                 | サービス           |
| ------------------ | -------------- |
| PostgreSQL / MySQL | Cloud SQL      |
| グローバル分散DB          | Cloud Spanner  |
| モバイルアプリDB          | Firestore      |
| IoT / 時系列          | Cloud Bigtable |
| 分析 / BI            | BigQuery       |

---

# 3. Storage

| 要件              | サービス            |
| --------------- | --------------- |
| ファイル保存 / オブジェクト | Cloud Storage   |
| VMディスク          | Persistent Disk |
| NFS共有           | Filestore       |

## Storage Class

| Class    | 用途     |
| -------- | ------ |
| Standard | 頻繁アクセス |
| Nearline | 月1     |
| Coldline | 四半期    |
| Archive  | 年1     |

---

# 4. Networking

| 要件                   | サービス                      |
| -------------------- | ------------------------- |
| VM → Internet        | Cloud NAT                 |
| VM → Google API      | Private Google Access     |
| VPC ↔ VPC            | VPC Peering               |
| Project間ネットワーク       | Shared VPC                |
| On-prem接続            | Cloud VPN                 |
| 高速オンプレ接続             | Cloud Interconnect        |
| Private Googleサービス接続 | Private Service Connect   |
| HTTP負荷分散             | Application Load Balancer |

---

# 5. IAM / Identity

| 要件        | 解                            |
| --------- | ---------------------------- |
| 人管理       | Group                        |
| VM → API  | Service Account              |
| Pod → API | Workload Identity            |
| 外部ID      | Workload Identity Federation |
| Secret管理  | Secret Manager               |

---

# 6. Logging / Monitoring

| 要件       | 解                |
| -------- | ---------------- |
| ログ管理     | Cloud Logging    |
| メトリクス監視  | Cloud Monitoring |
| ログエクスポート | Log Router       |

※ Log Sink → **Log Router（名称変更）**

---

# 7. Security

| 要件                 | 解                       |
| ------------------ | ----------------------- |
| API key / password | Secret Manager          |
| encryption key     | Cloud KMS               |
| WAF / DDoS防御       | Cloud Armor             |
| データ持ち出し防止          | VPC Service Controls    |
| セキュリティ統合管理         | Security Command Center |

---

# 8. Cost Optimization

| 要件      | 解                      |
| ------- | ---------------------- |
| 使わないVM  | Stop                   |
| 長期VM    | Committed Use Discount |
| 可変負荷    | Autoscaling            |
| 分析コスト削減 | BigQuery Partition     |

---

# 9. ACEトラップ

| 問題                    | 正解                    |
| --------------------- | --------------------- |
| Pod → API             | Workload Identity     |
| logs分析                | BigQuery              |
| private VM → API      | Private Google Access |
| private VM → Internet | Cloud NAT             |
| container serverless  | Cloud Run             |

---

# 10. 試験のコツ

問題文から **キーワードを探す**。

```
container → Cloud Run
SQL → Cloud SQL
analytics → BigQuery
mobile → Firestore
IoT → Bigtable
async → Pub/Sub
ETL → Dataflow
VM → Compute Engine
```

ACEは **設計試験ではなくサービス選択試験**。

---

# 11. GCP ACE頻出用語（抜粋50）

| 用語                      | フルスペル                            | 定義             | 用途 / 説明               |
| ----------------------- | -------------------------------- | -------------- | --------------------- |
| IAM                     | Identity and Access Management   | アクセス管理         | ユーザー権限                |
| Service Account         | Service Account                  | アプリID          | VM / API認証            |
| Workload Identity       | Workload Identity for GKE        | Pod認証          | GKE → API             |
| Secret Manager          | Secret Manager                   | 機密管理           | APIキー                 |
| Cloud KMS               | Key Management Service           | 鍵管理            | 暗号化                   |
| VPC                     | Virtual Private Cloud            | 仮想ネットワーク       | GCPネットワーク             |
| Subnet                  | Subnetwork                       | IP範囲           | VPC内                  |
| Firewall Rule           | VPC Firewall Rule                | 通信制御           | ingress / egress      |
| Cloud NAT               | Network Address Translation      | NAT            | Private VM → Internet |
| Private Google Access   | Private Google Access            | API接続          | VM → Google API       |
| VPC Peering             | VPC Network Peering              | VPC接続          | VPC間通信                |
| Cloud VPN               | Virtual Private Network          | VPN            | On-prem接続             |
| Cloud Interconnect      | Dedicated / Partner Interconnect | 専用線            | 高速接続                  |
| Compute Engine          | Compute Engine                   | VM             | IaaS                  |
| Managed Instance Group  | Managed Instance Group           | VMグループ         | Autoscale             |
| Cloud Run               | Cloud Run                        | コンテナサーバレス      | HTTP                  |
| GKE                     | Google Kubernetes Engine         | Kubernetes     | コンテナ管理                |
| App Engine              | Google App Engine                | PaaS           | Web                   |
| Cloud Functions         | Cloud Functions                  | サーバレス関数        | イベント                  |
| Cloud Storage           | Cloud Storage                    | オブジェクトストレージ    | ファイル保存                |
| Persistent Disk         | Persistent Disk                  | VMディスク         | ブロック                  |
| Filestore               | Cloud Filestore                  | NFS            | ファイル共有                |
| Cloud SQL               | Cloud SQL                        | RDB            | MySQL / PostgreSQL    |
| Cloud Spanner           | Cloud Spanner                    | 分散RDB          | グローバル                 |
| Firestore               | Cloud Firestore                  | Document DB    | モバイル                  |
| Bigtable                | Cloud Bigtable                   | Wide Column DB | IoT                   |
| BigQuery                | BigQuery                         | Data Warehouse | 分析                    |
| Pub/Sub                 | Publish / Subscribe              | メッセージング        | 非同期                   |
| Dataflow                | Cloud Dataflow                   | ETL            | ストリーム処理               |
| Dataproc                | Cloud Dataproc                   | Hadoop / Spark | 分散処理                  |
| Cloud Logging           | Cloud Logging                    | ログ             | アプリログ                 |
| Log Router              | Log Router                       | ログ転送           | Export                |
| Cloud Monitoring        | Cloud Monitoring                 | メトリクス監視        | CPU / memory          |
| Alert Policy            | Monitoring Alert Policy          | 通知             | アラート                  |
| Uptime Check            | Uptime Check                     | 外形監視           | Web監視                 |
| Cloud Armor             | Cloud Armor                      | WAF            | DDoS防御                |
| VPC Service Controls    | VPC Service Controls             | データ境界          | exfiltration防止        |
| Security Command Center | Security Command Center          | セキュリティ統合       | 脆弱性管理                 |

---

# 12. CLI頻出（gcloud）

| コマンド                               | 用途            |
| ---------------------------------- | ------------- |
| `gcloud compute instances create`  | VM作成          |
| `gcloud compute ssh`               | VM接続          |
| `gcloud run deploy`                | Cloud Runデプロイ |
| `gcloud container clusters create` | GKE作成         |
| `gcloud sql instances create`      | Cloud SQL     |
| `gcloud storage buckets create`    | Storage作成     |
| `gcloud auth login`                | 認証            |
| `gcloud config set project`        | Project変更     |

---

# 13. 最後の1分まとめ

```
VM → Internet
Cloud NAT

VM → Google API
Private Google Access

Container serverless
Cloud Run

SQL
Cloud SQL

Analytics
BigQuery
```

---

# 最後の1分まとめ

```text
VM → Internet
Cloud NAT

VM → Google API
Private Google Access

Container serverless
Cloud Run

SQL
Cloud SQL

Analytics
BigQuery
```

---

# GCP Concept Map（ACE）

```
                  ┌────────────────────┐
                  │   Google Cloud     │
                  │   Architecture     │
                  └─────────┬──────────┘
                            │
           ┌────────────────┼────────────────┐
           │                │                │
           ▼                ▼                ▼

      Compute           Storage           Database
   ┌────────────┐    ┌────────────┐    ┌────────────┐
   │Compute Eng │    │CloudStorage│    │Cloud SQL   │
   │Cloud Run   │    │PersistentD │    │Firestore   │
   │GKE         │    │Filestore   │    │Bigtable    │
   │App Engine  │    │            │    │Spanner     │
   └────────────┘    └────────────┘    └────────────┘

           └───────────────┬───────────────┘
                           │
                           ▼

                    Networking
               ┌─────────────────┐
               │VPC              │
               │Cloud NAT        │
               │Private API      │
               │VPN / Interconnect│
               │Load Balancer    │
               └─────────────────┘

                           │
                           ▼

                       Security
                ┌────────────────┐
                │IAM             │
                │Service Account │
                │Secret Manager  │
                │Cloud KMS       │
                │VPC SC          │
                └────────────────┘
```

---

# Google Cloud設計思想

```
        ┌───────────────────────┐
        │  Managed First        │
        │  Serverless First     │
        │  Least Operations     │
        └───────────┬───────────┘
                    │
                    ▼
           Choose the simplest
             managed service
```

---

# ACE試験の核心

```
問題を見る
   ↓
キーワード探す
   ↓
最もシンプルな
Managedサービスを選ぶ
```

---

# 最後のメンタル

```
    Calm
     ↓
  Read carefully
     ↓
 Choose managed
     ↓
    Pass
```

```
   ( •_•)
  /|   |\
   |   |
  / \ / \

You are ready.
```

---
