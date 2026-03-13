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



# 11. GCP ACE頻出用語（実践版）

| No | 用語                           | フルスペル                            | 定義              | 用途 / 説明            |
| -- | ---------------------------- | -------------------------------- | --------------- | ------------------ |
| 1  | Cloud Run                    | Cloud Run                        | コンテナサーバレス実行     | HTTPコンテナ実行         |
| 2  | GKE                          | Google Kubernetes Engine         | マネージドKubernetes | コンテナクラスタ           |
| 3  | App Engine                   | Google App Engine                | PaaSアプリ基盤       | Webアプリ             |
| 4  | Cloud Functions              | Cloud Functions                  | イベント駆動関数        | 軽量サーバレス            |
| 5  | Managed Instance Group       | Managed Instance Group (MIG)     | VM自動管理          | AutoScaling        |
| 6  | Autoscaler                   | Autoscaler                       | 自動スケール          | VM / Podスケール       |
| 7  | Cloud Storage                | Cloud Storage                    | オブジェクトストレージ     | ファイル保存             |
| 8  | Persistent Disk              | Persistent Disk                  | VMブロックストレージ     | Compute Engine     |
| 9  | Filestore                    | Cloud Filestore                  | NFSファイル共有       | VM共有ストレージ          |
| 10 | Storage Class                | Storage Class                    | Storage階層       | Standard / Archive |
| 11 | Cloud SQL                    | Cloud SQL                        | マネージドRDB        | MySQL / PostgreSQL |
| 12 | Cloud Spanner                | Cloud Spanner                    | 分散RDB           | グローバルDB            |
| 13 | Firestore                    | Cloud Firestore                  | Document型NoSQL  | モバイルDB             |
| 14 | Bigtable                     | Cloud Bigtable                   | Wide Column DB  | IoT / 時系列          |
| 15 | BigQuery                     | BigQuery                         | Data Warehouse  | 分析                 |
| 16 | Partitioned Table            | BigQuery Partition               | テーブル分割          | コスト削減              |
| 17 | Pub/Sub                      | Publish / Subscribe              | メッセージング         | 非同期                |
| 18 | Dataflow                     | Cloud Dataflow                   | ETL / Stream処理  | データパイプライン          |
| 19 | Dataproc                     | Cloud Dataproc                   | Hadoop / Spark  | 分散処理               |
| 20 | VPC                          | Virtual Private Cloud            | 仮想ネットワーク        | GCPネットワーク          |
| 21 | Subnet                       | Subnetwork                       | IP範囲            | VPC内部              |
| 22 | Firewall Rule                | VPC Firewall Rule                | 通信制御            | ingress / egress   |
| 23 | Network Tag                  | Network Tag                      | VM識別タグ          | Firewall適用         |
| 24 | Cloud NAT                    | Network Address Translation      | Private VM外部通信  | Internet接続         |
| 25 | Private Google Access        | Private Google Access            | Google API接続    | Private VM         |
| 26 | VPC Peering                  | VPC Network Peering              | VPC接続           | VPC間通信             |
| 27 | Shared VPC                   | Shared Virtual Private Cloud     | VPC共有           | 複数Project          |
| 28 | Cloud VPN                    | Cloud Virtual Private Network    | VPN接続           | On-prem接続          |
| 29 | HA VPN                       | High Availability VPN            | 冗長VPN           | 高可用                |
| 30 | Cloud Interconnect           | Dedicated / Partner Interconnect | 専用線             | 高速オンプレ接続           |
| 31 | Private Service Connect      | Private Service Connect          | Private API接続   | Googleサービス         |
| 32 | Application Load Balancer    | HTTP(S) Load Balancer            | L7負荷分散          | Web                |
| 33 | Network Load Balancer        | TCP / UDP Load Balancer          | L4負荷分散          | TCP                |
| 34 | Cloud Logging                | Cloud Logging                    | ログ収集            | アプリログ              |
| 35 | Log Router                   | Log Router                       | ログ転送            | BigQuery等          |
| 36 | Cloud Monitoring             | Cloud Monitoring                 | メトリクス監視         | CPU / Memory       |
| 37 | Alert Policy                 | Monitoring Alert Policy          | アラート            | 通知                 |
| 38 | Uptime Check                 | Uptime Check                     | 外形監視            | HTTP監視             |
| 39 | Cloud Armor                  | Cloud Armor                      | WAF             | DDoS防御             |
| 40 | VPC Service Controls         | VPC Service Controls             | データ境界           | exfiltration防止     |
| 41 | Security Command Center      | Security Command Center          | セキュリティ統合        | 脆弱性                |
| 42 | Secret Manager               | Secret Manager                   | 機密管理            | APIキー              |
| 43 | Cloud KMS                    | Cloud Key Management Service     | 鍵管理             | 暗号化                |
| 44 | CMEK                         | Customer Managed Encryption Keys | 顧客鍵             | KMS使用              |
| 45 | Workload Identity            | Workload Identity for GKE        | Pod認証           | APIアクセス            |
| 46 | Workload Identity Federation | Workload Identity Federation     | 外部ID連携          | GitHub / AWS       |
| 47 | Identity-Aware Proxy         | Identity-Aware Proxy             | IAMアクセス制御       | 公開IP不要SSH          |
| 48 | Binary Authorization         | Binary Authorization             | コンテナ署名          | GKEセキュリティ          |
| 49 | Artifact Registry            | Artifact Registry                | コンテナ保存          | Docker             |
| 50 | Cloud Scheduler              | Cloud Scheduler                  | Cron実行          | 定期ジョブ              |

---

# ACE重要トリガー

| キーワード                | 正解        |
| -------------------- | --------- |
| container serverless | Cloud Run |
| SQL                  | Cloud SQL |
| analytics            | BigQuery  |
| mobile               | Firestore |
| IoT                  | Bigtable  |
| async                | Pub/Sub   |
| ETL                  | Dataflow  |
| VM autoscale         | MIG       |

---

# 超短縮（ACE）

```
container → Cloud Run
SQL → Cloud SQL
analytics → BigQuery
mobile → Firestore
IoT → Bigtable
async → Pub/Sub
ETL → Dataflow
```

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
