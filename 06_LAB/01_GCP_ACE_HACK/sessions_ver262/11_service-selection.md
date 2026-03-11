```markdown
# GCP Service Selection（ACE 2026）

ACE試験の核心は

適切なGCPサービスの選択

である。

試験では

要件 → キーワード → サービス

で判断する。

---

# Service Selection構造

Compute
Storage
Database
Analytics
Networking
Security
Operations

---

# Compute

| 用途 | サービス |
|-----|-----|
VM | Compute Engine
コンテナ | Cloud Run / GKE
HTTPサーバレス | Cloud Run
イベント処理 | Cloud Functions
バッチ | Compute Engine / Batch

ACE判断

VM必要  
→ Compute Engine

Docker container  
→ Cloud Run

大規模Kubernetes  
→ GKE

---

# Storage

| 用途 | サービス |
|-----|-----|
オブジェクト | Cloud Storage
共有ファイル | Filestore
ブロック | Persistent Disk
アーカイブ | Archive Storage

ACE判断

画像保存  
→ Cloud Storage

VMディスク  
→ Persistent Disk

共有NFS  
→ Filestore

---

# Database

| 用途 | サービス |
|-----|-----|
MySQL / PostgreSQL | Cloud SQL
グローバルRDB | Cloud Spanner
大規模NoSQL | Bigtable
モバイルDB | Firestore
分析 | BigQuery

ACE判断

PostgreSQL  
→ Cloud SQL

グローバルDB  
→ Spanner

モバイルアプリ  
→ Firestore

分析  
→ BigQuery

---

# Analytics / Messaging

| 用途 | サービス |
|-----|-----|
データ分析 | BigQuery
ログ分析 | BigQuery
ストリーミング | Pub/Sub
ETL | Dataflow

ACE判断

ログ分析  
→ BigQuery

イベント処理  
→ Pub/Sub

データ処理  
→ Dataflow

---

# Networking

| 用途 | サービス |
|-----|-----|
仮想ネットワーク | VPC
ロードバランス | Cloud Load Balancing
Private接続 | Private Service Connect
VPN | Cloud VPN
専用線 | Interconnect

ACE判断

オンプレ接続  
→ Cloud VPN

Google API private access  
→ Private Google Access

内部サービス公開  
→ Private Service Connect

---

# Security

| 用途 | サービス |
|-----|-----|
アクセス制御 | IAM
アプリ認証 | Service Account
秘密管理 | Secret Manager
鍵管理 | Cloud KMS
データ境界 | VPC Service Controls

ACE判断

API認証  
→ Service Account

パスワード保存  
→ Secret Manager

暗号鍵  
→ KMS

---

# Serverless

| 用途 | サービス |
|-----|-----|
HTTP API | Cloud Run
イベント処理 | Cloud Functions
オーケストレーション | Workflows
メッセージ処理 | Pub/Sub

ACE判断

HTTP container  
→ Cloud Run

イベント処理  
→ Cloud Functions

複数サービス連携  
→ Workflows

---

# Operations

| 用途 | サービス |
|-----|-----|
ログ | Cloud Logging
監視 | Cloud Monitoring
アラート | Alert Policy
ログ分析 | BigQuery

ACE判断

CPU監視  
→ Monitoring

ログ検索  
→ Logging

ログ分析  
→ BigQuery Export

---

# Cost Management

| 用途 | サービス |
|-----|-----|
費用見積 | Pricing Calculator
予算通知 | Budget Alerts
コスト分析 | Billing Export

ACE判断

コスト可視化  
→ Billing Export

予算通知  
→ Budget Alerts

---

# Service Selection Flow

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

---

# ACE重要マッピング

VM → Compute Engine

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

---

# ACEトラップ

## Trap1

PostgreSQL

Spanner → ❌  
Cloud SQL → ✅

---

## Trap2

ログ分析

Cloud Logging → ❌  
BigQuery → ✅

---

## Trap3

API container

Compute Engine → ❌  
Cloud Run → ✅

---

## Trap4

パスワード保存

Env variable → ❌  
Secret Manager → ✅

---

# 試験攻略

ACE問題は

要件  
↓  
ワークロード分類  
↓  
サービス選択

で解く。

例

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

---

# 2026 ACE頻出サービス

Compute Engine  
Cloud Run  
Cloud Storage  
Cloud SQL  
BigQuery  
Pub/Sub  
Secret Manager  
IAM  
Cloud Monitoring  

---

# まとめ

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

