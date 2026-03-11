# GCP ACE Practice Exam（1–50）

ACE試験対策問題集

構成

* Part1 問題
* Part2 回答解説

---

# Part 1 問題

---

## Section 1 Compute / Serverless

### Question 1

あなたは **DockerコンテナのHTTP API** をデプロイしたい。

要件

* コンテナ
* HTTPアクセス
* 自動スケール
* インフラ管理不要

最適なサービスはどれか？

A. Compute Engine
B. GKE
C. Cloud Run
D. App Engine Standard

---

### Question 2

あなたの会社は **オンプレミスの PostgreSQL** をGCPへ移行する。

要件

* PostgreSQL互換
* マネージド
* 運用負荷最小

最適なサービスはどれか？

A. Bigtable
B. Firestore
C. Cloud SQL
D. Cloud Spanner

---

### Question 3

あなたは **ログデータをSQLで分析したい**。

要件

* ペタバイト規模
* SQL
* サーバレス

最適なサービスはどれか？

A. Cloud Logging
B. BigQuery
C. Cloud SQL
D. Firestore

---

### Question 4

Compute Engine VMのCPUを監視したい。

条件

* CPU80%超で通知

最適なサービスはどれか？

A. Cloud Logging
B. Cloud Monitoring
C. Cloud Trace
D. BigQuery

---

### Question 5

アプリケーションの **APIキーを安全に保存**したい。

要件

* セキュア保存
* IAM制御
* アプリ取得

最適なサービスはどれか？

A. Environment Variables
B. Cloud Storage
C. Secret Manager
D. Firestore

---

## Section 2 Networking

### Question 6

VMが **Google APIへprivate通信**したい。

外部IPなし。

最適な構成はどれか？

A. Cloud NAT
B. Private Google Access
C. Cloud VPN
D. VPC Peering

---

### Question 7

オンプレミスとGCPを接続する。

要件

* 簡単セットアップ

最適なサービスは？

A. Cloud Interconnect
B. Cloud VPN
C. VPC Peering
D. Private Service Connect

---

### Question 8

VMディスク保存。

最適なサービスは？

A. Cloud Storage
B. Persistent Disk
C. Filestore
D. Archive

---

### Question 9

画像ファイル保存システム。

最適なサービスは？

A. Persistent Disk
B. Filestore
C. Cloud Storage
D. Firestore

---

### Question 10

長期保存データ。

ほぼアクセスなし。

最適なStorageクラスは？

A. Standard
B. Nearline
C. Coldline
D. Archive

---

## Section 3 Identity / Security

### Question 11

GKE Pod が **Google APIへアクセス**する。

最適な認証方法は？

A. User account
B. Service account key
C. Workload Identity
D. Secret Manager

---

### Question 12

非同期メッセージングシステム。

最適なサービスは？

A. Cloud Tasks
B. Pub/Sub
C. Dataflow
D. BigQuery

---

### Question 13

ETLパイプライン。

最適なサービスは？

A. Compute Engine
B. Dataflow
C. BigQuery
D. Firestore

---

### Question 14

VMコスト削減。

夜間不要。

最適な方法は？

A. Delete VM
B. Stop VM
C. Resize VM
D. Snapshot

---

### Question 15

ログの **長期分析**。

最適な方法は？

A. Cloud Logging
B. Cloud Monitoring
C. BigQuery Export
D. Cloud Trace

---

## Section 4 Databases

### Question 16

DBパスワード管理。

最適なサービスは？

A. Environment Variables
B. Cloud Storage
C. Secret Manager
D. Firestore

---

### Question 17

最小権限を実装する。

最適な方法は？

A. Owner role
B. Editor role
C. Predefined role
D. Basic role

---

### Question 18

データ持ち出し防止。

最適なサービスは？

A. Firewall
B. IAM
C. VPC Service Controls
D. Secret Manager

---

### Question 19

グローバルロードバランサー。

最適なサービスは？

A. Compute Engine LB
B. Cloud Load Balancing
C. GKE LB
D. Cloud Armor

---

### Question 20

VMが **インターネットへアクセス**。

外部IPなし。

最適な構成は？

A. Cloud NAT
B. Private Google Access
C. Cloud VPN
D. Interconnect

---

## Section 5 Storage

### Question 21

モバイルアプリDB。

最適なサービスは？

A. Bigtable
B. Firestore
C. Cloud SQL
D. Spanner

---

### Question 22

グローバル分散RDB。

最適なサービスは？

A. Cloud SQL
B. Firestore
C. Cloud Spanner
D. Bigtable

---

### Question 23

VMメトリクス確認。

最適なサービスは？

A. Cloud Logging
B. Cloud Monitoring
C. Cloud Trace
D. BigQuery

---

### Question 24

メッセージキュー。

最適なサービスは？

A. Pub/Sub
B. Cloud Tasks
C. Dataflow
D. BigQuery

---

### Question 25

Kubernetesクラスタ。

最適なサービスは？

A. Cloud Run
B. GKE
C. Compute Engine
D. App Engine

---

## Section 6 Storage / File

### Question 26

NFS共有。

最適なサービスは？

A. Filestore
B. Cloud Storage
C. Persistent Disk
D. Archive

---

### Question 27

暗号鍵管理。

最適なサービスは？

A. Secret Manager
B. Cloud KMS
C. IAM
D. Logging

---

### Question 28

クラウドコスト見積。

最適なツールは？

A. Spreadsheet
B. Pricing Calculator
C. Billing Export
D. Monitoring

---

### Question 29

コスト分析。

最適な方法は？

A. Billing console
B. Billing Export
C. Monitoring
D. Logging

---

### Question 30

予算通知。

最適な機能は？

A. Monitoring alert
B. Budget Alerts
C. Logging
D. Billing console

---

## Section 7 Advanced

### Question 31

イベント駆動コード。

最適なサービスは？

A. Cloud Run
B. Cloud Functions
C. Compute Engine
D. GKE

---

### Question 32

VM SSH接続。

必要な設定は？

A. NAT
B. Firewall
C. IAM
D. VPN

---

### Question 33

HTTPコンテナAPI。

最適なサービスは？

A. GKE
B. Compute Engine
C. Cloud Run
D. Functions

---

### Question 34

VMログ確認。

最適なサービスは？

A. Monitoring
B. Logging
C. Trace
D. BigQuery

---

### Question 35

VMメトリクス。

最適なサービスは？

A. Logging
B. Monitoring
C. Trace
D. BigQuery

---

## Section 8 Cost Optimization

### Question 36

長期VM利用。

最適な割引は？

A. Spot VM
B. SUD
C. CUD
D. Archive

---

### Question 37

自動割引。

最適な割引は？

A. Spot
B. SUD
C. CUD
D. Budget

---

### Question 38

VM → Google API private通信。

最適な機能は？

A. NAT
B. Private Google Access
C. VPN
D. Interconnect

---

### Question 39

オンプレ専用線接続。

最適なサービスは？

A. VPN
B. Interconnect
C. Peering
D. NAT

---

### Question 40

イベント処理。

最適なサービスは？

A. Run
B. Functions
C. Compute
D. GKE

---

## Section 9 Logging / Monitoring

### Question 41

ログ長期保存。

最適なサービスは？

A. Logging bucket
B. Monitoring
C. BigQuery
D. Trace

---

### Question 42

IAM構造。

正しい順序は？

A. User → Resource → Role
B. Member → Role → Resource
C. Role → Member → Resource
D. Resource → Member → Role

---

### Question 43

GKE IAM認証。

最適な方法は？

A. Service Account key
B. Workload Identity
C. User account
D. Secret Manager

---

### Question 44

ストリームデータ処理。

最適なサービスは？

A. Dataflow
B. BigQuery
C. Pub/Sub
D. Firestore

---

### Question 45

Cloud Storage 年数回アクセス。

最適なクラスは？

A. Standard
B. Nearline
C. Coldline
D. Archive

---

## Section 10 Service Selection

### Question 46

IAM最小権限。

最適なロールは？

A. Owner
B. Editor
C. Predefined role
D. Basic role

---

### Question 47

Computeログ。

最適なサービスは？

A. Monitoring
B. Logging
C. Trace
D. Debugger

---

### Question 48

HTTP serverless container。

最適なサービスは？

A. Functions
B. Cloud Run
C. Compute Engine
D. GKE

---

### Question 49

大規模分析。

最適なサービスは？

A. Firestore
B. BigQuery
C. Cloud SQL
D. Bigtable

---

### Question 50

Secrets保存。

最適なサービスは？

A. Environment Variables
B. Secret Manager
C. Firestore
D. Cloud Storage

---

# Part 2 回答・解説

### Question 1

Answer: C
Cloud Run はコンテナベースのHTTPサービスをサーバレスで実行でき、自動スケールとインフラ管理不要を満たす。

### Question 2

Answer: C
PostgreSQL互換のフルマネージドRDBは Cloud SQL。

### Question 3

Answer: B
BigQuery はPBスケールのSQL分析を行うサーバレスDWH。

### Question 4

Answer: B
CPUなどメトリクス監視は Cloud Monitoring。

### Question 5

Answer: C
APIキーなどの機密情報管理は Secret Manager。

### Question 6

Answer: B
外部IPなしで Google API にアクセスする場合は Private Google Access。

### Question 7

Answer: B
簡単にオンプレ接続するなら Cloud VPN。

### Question 8

Answer: B
VMディスクは Persistent Disk。

### Question 9

Answer: C
画像などオブジェクト保存は Cloud Storage。

### Question 10

Answer: D
ほぼアクセスしない長期保存は Archive。

### Question 11

Answer: C
GKE Pod と IAM を安全に接続するのは Workload Identity。

### Question 12

Answer: B
非同期メッセージングは Pub/Sub。

### Question 13

Answer: B
ETLやストリーム処理は Dataflow。

### Question 14

Answer: B
VM停止で課金を抑えられる。

### Question 15

Answer: C
ログを分析する場合は BigQuery Export。

### Question 16

Answer: C
DBパスワード管理は Secret Manager。

### Question 17

Answer: C
最小権限は Predefined Role を使う。

### Question 18

Answer: C
データ持ち出し防止は VPC Service Controls。

### Question 19

Answer: B
グローバルロードバランサーは Cloud Load Balancing。

### Question 20

Answer: A
外部IPなしでインターネットアクセスする場合は Cloud NAT。

### Question 21

Answer: B
モバイルアプリDBは Firestore。

### Question 22

Answer: C
グローバル分散RDBは Cloud Spanner。

### Question 23

Answer: B
VMメトリクスは Cloud Monitoring。

### Question 24

Answer: A
メッセージキューは Pub/Sub。

### Question 25

Answer: B
Kubernetesは GKE。

### Question 26

Answer: A
NFS共有は Filestore。

### Question 27

Answer: B
暗号鍵管理は Cloud KMS。

### Question 28

Answer: B
コスト見積は Pricing Calculator。

### Question 29

Answer: B
詳細なコスト分析は Billing Export。

### Question 30

Answer: B
予算通知は Budget Alerts。

### Question 31

Answer: B
イベント駆動コードは Cloud Functions。

### Question 32

Answer: B
SSH接続には Firewall で TCP22 を許可。

### Question 33

Answer: C
HTTPコンテナAPIは Cloud Run。

### Question 34

Answer: B
ログ確認は Cloud Logging。

### Question 35

Answer: B
メトリクス確認は Cloud Monitoring。

### Question 36

Answer: C
長期利用は Committed Use Discount。

### Question 37

Answer: B
自動割引は Sustained Use Discount。

### Question 38

Answer: B
VM→Google API private通信は Private Google Access。

### Question 39

Answer: B
専用線接続は Cloud Interconnect。

### Question 40

Answer: B
イベント処理は Cloud Functions。

### Question 41

Answer: A
ログ長期保存は Logging bucket。

### Question 42

Answer: B
IAM構造は Member → Role → Resource。

### Question 43

Answer: B
GKE IAM認証は Workload Identity。

### Question 44

Answer: A
ストリーム処理は Dataflow。

### Question 45

Answer: C
年数回アクセスは Coldline。

### Question 46

Answer: C
最小権限は Predefined Role。

### Question 47

Answer: B
Computeログは Cloud Logging。

### Question 48

Answer: B
HTTP serverless container は Cloud Run。

### Question 49

Answer: B
大規模分析は BigQuery。

### Question 50

Answer: B
Secrets保存は Secret Manager。

---
