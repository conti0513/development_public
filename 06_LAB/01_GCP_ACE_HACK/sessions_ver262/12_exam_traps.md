```markdown
# ACE Exam Traps（2026）

ACEは

```

知識
ではなく
サービス選択トラップ

```

が中心。

---

# Compute traps

### Trap 1

```

VMコスト削減

```

delete VM → ❌  
stop VM → ✅

理由  
deleteはデータ消える

---

### Trap 2

```

Docker API

```

Compute Engine → ❌  
Cloud Run → ✅

---

### Trap 3

```

Auto scaling container

```

VM → ❌  
Cloud Run / GKE → ✅

---

### Trap 4

```

短時間バッチ

```

Standard VM → ❌  
Spot VM → ✅

---

# Storage traps

### Trap 5

```

画像保存

```

Persistent Disk → ❌  
Cloud Storage → ✅

---

### Trap 6

```

長期保存

```

Standard → ❌  
Archive → ✅

---

### Trap 7

```

共有ファイル

```

Cloud Storage → ❌  
Filestore → ✅

---

# Database traps

### Trap 8

```

PostgreSQL移行

```

Spanner → ❌  
Cloud SQL → ✅

---

### Trap 9

```

巨大RDB

```

Cloud SQL → ❌  
Spanner → ✅

---

### Trap 10

```

モバイルアプリDB

```

Bigtable → ❌  
Firestore → ✅

---

### Trap 11

```

分析DB

```

Cloud SQL → ❌  
BigQuery → ✅

---

# Analytics traps

### Trap 12

```

ログ分析

```

Cloud Logging → ❌  
BigQuery → ✅

---

### Trap 13

```

メッセージング

```

Cloud Tasks → ❌  
Pub/Sub → ✅

---

### Trap 14

```

ETL

```

Compute → ❌  
Dataflow → ✅

---

# Networking traps

### Trap 15

```

オンプレ接続

```

Public IP → ❌  
Cloud VPN → ✅

---

### Trap 16

```

Private Google API

```

External IP → ❌  
Private Google Access → ✅

---

### Trap 17

```

グローバルLB

```

VM LB → ❌  
Cloud Load Balancer → ✅

---

# Security traps

### Trap 18

```

アプリ認証

```

User account → ❌  
Service Account → ✅

---

### Trap 19

```

パスワード保存

```

Env variable → ❌  
Secret Manager → ✅

---

### Trap 20

```

最小権限

```

Owner → ❌  
Predefined role → ✅

---

### Trap 21

```

鍵管理

```

Manual key → ❌  
Cloud KMS → ✅

---

### Trap 22

```

データ持ち出し防止

```

Firewall → ❌  
VPC Service Controls → ✅

---

# Monitoring traps

### Trap 23

```

CPU監視

```

Logging → ❌  
Monitoring → ✅

---

### Trap 24

```

ログ検索

```

Monitoring → ❌  
Logging → ✅

---

### Trap 25

```

ログ分析

```

Logging → ❌  
BigQuery Export → ✅

---

# Cost traps

### Trap 26

```

費用見積

```

Spreadsheet → ❌  
Pricing Calculator → ✅

---

### Trap 27

```

予算通知

```

Monitoring → ❌  
Budget Alerts → ✅

---

### Trap 28

```

コスト分析

```

Billing console → ❌  
Billing Export → ✅

---

### Trap 29

```

長期割引

```

SUD → ❌  
CUD → ✅

---

### Trap 30

```

自動割引

```

CUD → ❌  
SUD → ✅

---

# 試験攻略

ACE問題は

```

要件
↓
キーワード
↓
GCPサービス

```

で解く。

例

```

Docker → Cloud Run
PostgreSQL → Cloud SQL
Analytics → BigQuery
Secrets → Secret Manager

```

---

# ACE頻出サービス

```

Cloud Run
Compute Engine
Cloud Storage
Cloud SQL
BigQuery
Pub/Sub
Secret Manager
IAM
Monitoring

```

---

# 最重要トラップ

```

PostgreSQL → Cloud SQL
ログ分析 → BigQuery
Container API → Cloud Run
Secrets → Secret Manager

```

---

# まとめ

ACEは

```

GCPっぽいサービス

```

を選ぶ試験。

```

VM → Compute
Container → Cloud Run
DB → Cloud SQL
Analytics → BigQuery
Secrets → Secret Manager

```
```

---

# 正直な評価

あなたのこの教材

```
sessions_ver262
```

かなり良いです。

構造

```
01-08 基礎
09 cost
10 security
11 service selection
12 traps
13-15 exam
```

これは **かなり完成度高いACE教材構造**です。

---

