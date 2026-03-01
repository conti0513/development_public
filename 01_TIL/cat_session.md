# ⚡️ Exam 1: ハックリスト (Q1-Q50)

### 🌐 ネットワーク・接続 (Q1-Q10)

**Q1：オンプレからGCSアクセス（ネット禁止）**

* **キーワード：** `on-premises`, `prohibit public IP`, `restrict internet access`.
* **正解：** **restricted.googleapis.com** へのCNAME設定と199.36.153.4/30の広報。
* **ハック：** Googleサービス（GCS等）にネットを通らず秘密裏に繋ぐための専用窓口。

**Q2：VMへのSSH（個別追跡・効率管理）**

* **キーワード：** `administrative access`, `tracked to individual`, `manage efficiently`.
* **正解：** **OS Login** (`compute.osAdminLogin`) ロールの付与。
* **ハック：** 共有キーは「誰がやったか」不明なのでNG。GoogleアカウントとSSHを紐付けるのが正攻法。

**Q3：個人カード払いのプロジェクトを統合**

* **キーワード：** `personal credit cards`, `consolidating`, `single billing account`.
* **正解：** **New Billing Account** を作成し、全プロジェクトに紐付ける。
* **ハック：** 支払い元を一本化するには「新しい請求先」が必要。Resource Managerでの移動は組織図の整理。

**Q4：CPU不要 / 32GBメモリ / コスト最小**

* **キーワード：** `almost no CPU`, `30 GB in-memory cache`, `lowest costs`.
* **正解：** **Custom Machine Type**（CPU最小、メモリ32GB指定）。
* **ハック：** `n1-standard` 等のプリセットはCPUも増えて高くなる。メモリだけ欲しいなら「カスタム」一択。

**Q5：非アクティブなK8s設定を確認**

* **キーワード：** `Kubernetes cluster configuration`, `inactive environments`, `minimal steps`.
* **正解：** **`kubectl config use-context`** ➔ **`kubectl config view`**。
* **ハック：** 複数のK8s環境がある場合、まず「操作対象（Context）」を切り替えないと中身は見えない。

**Q6：大至急（明日まで）に請求を統合**

* **キーワード：** `consolidate costs`, `single invoice`, `as of tomorrow`.
* **正解：** **Link projects** to the new billing account.
* **ハック：** 組織(Org)移行は数日かかる。プロジェクトを「請求先だけ変える」のは数秒。

**Q7：画像が置かれたら自動処理（最速）**

* **キーワード：** `upload images`, `convert images`, `most efficient/cost-effective`.
* **正解：** **GCS ➔ Cloud Functions** 連携。
* **ハック：** ファイルアップを検知してプログラムを動かす「イベント駆動」の王道。

**Q8：他PJTのIAMロールをそのまま使いたい**

* **キーワード：** `same IAM roles`, `production project`, `fewest possible steps`.
* **正解：** **`gcloud iam roles copy`** コマンド。
* **ハック：** 手動作成は非効率。コマンド一発で「クローン」するのが最短。

**Q9：サブネットの最大IPレンジ**

* **キーワード：** `largest possible IP address range`, `future scaling`.
* **正解：** **10.0.0.0/8**。
* **ハック：** プライベートIPの規格（RFC 1918）で最も広いのが `/8`（約1600万アドレス）。

**Q10：DMからK8s操作（DaemonSet等）**

* **キーワード：** `Deployment Manager`, `DaemonSet`, `simplest way`.
* **正解：** **Type Provider** を使ってK8s APIをDMに追加。
* **ハック：** DM（インフラ管理）で「K8sの中身（アプリ）」まで管理したい時の拡張プラグイン。

---

### 💻 サーバーレス・Compute (Q11-Q20)

**Q11：コンテナ / ユーザー極少 / コスト最小**

* **キーワード：** `container image`, `very few daily users`, `cost-efficient`.
* **正解：** **Cloud Run**。
* **ハック：** リクエストがない時は「0円」になる。Scale-to-zeroが低トラフィックに最強。

**Q12：ログをSQLで詳細分析したい**

* **キーワード：** `collect logs`, `further analysis`, `cost efficiency`.
* **正解：** **BigQuery への Sink**（エクスポート）。
* **ハック：** 「分析(Analysis)」「SQL」が出たら、ログの送り先は BigQuery。

**Q13：ログを3年間保管（激安）**

* **キーワード：** `store log files for 3 years`, `cost-effective`.
* **正解：** **Coldline Storage** への Sink。
* **ハック：** 「3年」などの長期保管で、分析もしないなら GCS の安いクラス（Coldline）が最適。

**Q14：災害復旧（DR）用バックアップ**

* **キーワード：** `disaster recovery`, `long-term backup retention`, `best practices`.
* **正解：** **Coldline Storage**。
* **ハック：** 災害（めったに起きない）＝ アクセス頻度が極めて低い ➔ Coldline。

**Q15：Pub/Sub ➔ Cloud Run 連携**

* **キーワード：** `Cloud Run`, `processes messages from Cloud Pub/Sub`, `best practices`.
* **正解：** **Push Subscription** + **Invoker** ロール。
* **ハック：** Runは受動的。Pub/Subから「投げてもらう(Push)」のが定石。

**Q16：指定された内部IP（10.194...）を固定**

* **キーワード：** `specific IP 10.194.3.41`, `proprietary software hard-coded`.
* **正解：** **Static Internal IP** を予約。
* **ハック：** アプリがIP指定なら、予約して固定するしかない。

**Q17：特定アプリ（Apache等）の「下り通信費」のみ監視**

* **キーワード：** `egress network costs for the Apache server`, `not for entire project`.
* **正解：** **Billing Export + BigQuery**。
* **ハック：** 予算アラートは「PJT単位」。特定リソースだけの細かな費用は BigQuery で分析が必要。

**Q18：VMが死んだら自動再生成（Autohealing）**

* **キーワード：** `unresponsive`, `automatically re-created`, `minimum number of steps`.
* **正解：** **Managed Instance Group (MIG)** + **Autohealing Health Check**。
* **ハック：** 作り直すのは MIG の仕事。LBはトラフィックを止めるだけ。

**Q19：GKEインフラを自動拡張**

* **キーワード：** `GKE cluster`, `scale automatically`, `minimize manual configuration`.
* **正解：** **Node Pool の Autoscaling 有効化**（Cluster Autoscaler）。
* **ハック：** Podを増やすのがHPA。インフラ（Node/VM）自体を増やすのが CA。

**Q20：CLIでVM作成の前提条件**

* **キーワード：** `Compute Engine instance using the CLI`, `prerequisite`.
* **正解：** **`compute.googleapis.com` API の有効化**。
* **ハック：** GCPはAPIを「有効化」しないと何も始まらない。

---

### 📦 Storage & Database (Q21-Q30)

**Q21：App Engineで「予備」を常に待機**

* **キーワード：** `App Engine`, `4 unoccupied instances ready`, `sudden increases`.
* **正解：** **Automatic Scaling** + **`min_idle_instances`**。
* **ハック：** スパイクに備えて「暇な(Idle)」インスタンスをキープ。

**Q22：30日経った画像を安く（消さない）**

* **キーワード：** `older than 30 days`, `minimize costs`, `automatically managing`.
* **正解：** **Lifecycle Management** で **Archive Storage** へ移動。
* **ハック：** 「削除」ではなく「安く維持」なら Archive。

**Q23：DBのポイントインタイムリカバリ(PITR)**

* **キーワード：** `Cloud SQL (MySQL)`, `point-in-time recovery`, `accidental deletions`.
* **正解：** **Binary Logging** の有効化。
* **ハック：** 過去の特定の瞬間に戻すための必須設定。

**Q24：Cassandra を最速導入**

* **キーワード：** `Cassandra`, `isolated development environment`, `migration quickly`.
* **正解：** **Cloud Marketplace** でプリセット画像を使用。
* **ハック：** 自分で入れるのは手間。ポチるのが最速。

**Q25：他チームと独立した環境で作りたい**

* **キーワード：** `organized independently`, `separate resources`.
* **正解：** **新しい Project を作成**。
* **ハック：** GCPの「独立」の最小単位はプロジェクト。IAMで分けるのは不十分。

**Q26：CPU 90%超えで通知**

* **キーワード：** `CPU usage exceeds 90%`, `notified`.
* **正解：** **Monitoring Alerting Policy**。
* **ハック：** 独自スクリプトは運用負荷が高いので不正解。

**Q27：監視チームにDBの中身は見せない**

* **キーワード：** `monitor environment`, `not be able to access any review details`.
* **正解：** **`roles/monitoring.viewer`** の付与。
* **ハック：** 中身を見る権限（Reader）を避け、インフラを見るロールを与える。

**Q28：Spannerの自動拡張（CPUベース）**

* **キーワード：** `Spanner nodes automatically scales`, `CPU exceeds threshold`.
* **正解：** **Monitoring Alert ➔ Webhook ➔ Cloud Function** でリサイズ。
* **ハック：** Spannerにネイティブな自動スケールはないため、FunctionsでAPIを叩く。

**Q29：Googleアカウントの競合**

* **キーワード：** `personal Google accounts overlap`, `avoid conflicts`.
* **正解：** **転送（Transfer）** を招待。
* **ハック：** 削除しろと言うのはマナー違反。会社管理下に移ってもらうのが正解。

**Q30：他PJTのBQデータを「読みたい」**

* **キーワード：** `BigQuery dataset in a separate project`, `read data`.
* **正解：** **`roles/bigquery.dataViewer`**。
* **ハック：** **Job User** ロールは「クエリを実行する権利」だけでデータは読めない。

---

### 🛠 運用・管理 (Q31-Q40)

**Q31：オンプレアプリのAPI認証**

* **キーワード：** `on-premises application`, `authenticate and connect to GCP APIs`.
* **正解：** **Service Account Key (JSON)** を作成。
* **ハック：** 外の世界から入るための物理的な「鍵」を持っていく。

**Q32：Serverless移行（Dashboard/API/Batch）**

* **キーワード：** `minimize operational expenses`, `serverless architecture`.
* **正解：** **App Engine** (Dashboard) / **Cloud Run** (API) / **Cloud Tasks** (Batch)。
* **ハック：** VM(GCE)でバッチをやると立ち上げっぱなしで金がかかる。

**Q33：GKE管理最小＋ネット遮断**

* **キーワード：** `GKE cluster`, `not accessible from public internet`, `minimize overhead`.
* **正解：** **Private Autopilot Cluster**。
* **ハック：** 管理最小＝Autopilot、遮断＝Private。最強防御形態。

**Q34：Spannerクエリ性能を最短改善**

* **キーワード：** `shortest possible time`, `enhance performance`.
* **正解：** **CPU 65%アラート ➔ Node追加**。
* **ハック：** クエリ修正は時間がかかる。サーバー増強（金の力）が最短。

**Q35：月額費用の見積もり**

* **キーワード：** `estimate the monthly cost`, `accurate estimate`.
* **正解：** **Pricing Calculator**。
* **ハック：** 1週間動かして予想するのは金と時間の無駄。

**Q36：5年保存 / 5世代管理 / 1年で安く**

* **キーワード：** `retained for 5 years`, `up to five versions`, `older than one year... tier`.
* **正解：** **Versioning** (世代) ＋ **Lifecycle** (移行)。
* **ハック：** GCSの標準機能の組み合わせが最も運用負荷が低い。

**Q37：既存SubnetのIPアドレス枯渇**

* **キーワード：** `IP address exhaustion`, `minimizing complexity`.
* **正解：** **`expand-ip-range`** コマンド。
* **ハック：** VPC作り直しは大変。今のサブネットを広げるのが最短。

**Q38：CLIのデフォルトGKE設定**

* **キーワード：** `CLI to target this GKE cluster by default`.
* **正解：** **`gcloud config set container/cluster`**。
* **ハック：** `gcloud config set` は「今後ずっとこの設定でいく」宣言。

**Q39：SSD読込性能の限界（最大スループット）**

* **キーワード：** `disk read throttling`, `maximum amount of throughput`.
* **正解：** **Local SSD**。
* **ハック：** ネットワーク経由(Persistent)より物理直結(Local)が最強。

**Q40：リソース不明なWorkloadのコスト提案**

* **キーワード：** `uncertain about resource needs`, `cost-effective suggestions`.
* **正解：** **VPA (Vertical Pod Autoscaler)** 推薦モード。
* **ハック：** 提案(Suggestions)と言われたら VPA の出番。

---

### 🛡 セキュリティ・負荷分散 (Q41-Q50)

**Q41：特定のVMだけGCSにアクセス**

* **キーワード：** `new instance can access`, `without allowing other virtual machines`.
* **正解：** **専用 Service Account** を作成。
* **ハック：** デフォルトSAを使うと全VMに権限が漏れる。

**Q42：インフラ構成の総コスト見積もり**

* **キーワード：** `estimate total cost`, `three-tier social media`.
* **正解：** **Pricing Calculator** で全リソースを入力。
* **ハック：** オンプレと同スペックの構成を計算機に入れる。

**Q43：地域限定 / 頻繁アクセス / 低コスト**

* **キーワード：** `processed regularly`, `Boston`, `minimal storage costs`.
* **正解：** **Regional + Standard**。
* **ハック：** 毎日触るなら Nearline は手数料で高くなる。

**Q44：数%のユーザーにだけ新版をテスト**

* **キーワード：** `test new features with a small portion of live traffic`.
* **正解：** **App Engine Traffic Splitting**。
* **ハック：** 新版に数%だけ割り振る専用機能。

**Q45：Bigtableの全操作を監査**

* **キーワード：** `log all read and write`, `PII`, `send to SIEM`.
* **正解：** **Audit Logs (Data Read/Write)** 有効化 ➔ Pub/Sub 経由で飛ばす。
* **ハック：** 個人情報(PII)の操作ログは標準ではなく「監査ログ」をONにする。

**Q46：PostgreSQLを「最小変更」で移行**

* **キーワード：** `runs on PostgreSQL`, `minimal changes to codebase`.
* **正解：** **Cloud SQL (PostgreSQL)**。
* **ハック：** 同じエンジンならコード修正がほぼ不要。

**Q47：別の環境（dev等）のNode状態を確認**

* **キーワード：** `view the nodes from prod`, `verify for dev`.
* **正解：** **`gcloud get-credentials`**。
* **ハック：** まず資格情報を切り替えないと kubectl は動かない。

**Q48：SAキー寿命制限（24時間）**

* **キーワード：** `keys valid for only one day`, `centralized project`.
* **正解：** **Organization Policy** で制限。
* **ハック：** 個別設定ではなく組織全体でルールとして縛る。

**Q49：CI/CDパイプラインの安全な権限**

* **キーワード：** `CI/CD pipeline`, `correct permissions`, `best practices`.
* **正解：** **複数 SA + Secret Manager**。
* **ハック：** 1つのSAに盛らず、タスクごとに最小権限のSAを作る。

**Q50：SSL/TCP 443（non-HTTP）＋全世界**

* **キーワード：** `SSL-encrypted TCP`, `port 443`, `various regions`.
* **正解：** **SSL Proxy Load Balancer**。
* **ハック：** 443ポートだが「HTTP/S」ではない「TCP」ならこれ。

---# ⚡ Exam 2: ハックリスト v2（Q1–Q50）

---

# 🌐 管理・デプロイ (Q1–Q10)

### Q1：Jenkinsを最小の手間で構築

* **キーワード：** Jenkins, minimal effort
* **正解：** GCP Marketplace
* **ハック：** 有名ソフト＋最速構築＝Marketplace

---

### Q2：Deployment Managerでダウンタイムなし更新

* **キーワード：** no downtime, update configuration
* **正解：** `gcloud deployment-manager deployments update`
* **ハック：** 既存変更は update。createは新規。

---

### Q3：VMでCPUベース自動スケール

* **キーワード：** must use virtual machines, scale based on CPU
* **正解：** Managed Instance Group + Autoscaling
* **ハック：** VM指定＝GKEは毒。MIG一択。

---

### Q4：VMにカスタムSAを紐付け

* **キーワード：** custom service account
* **正解：** VM作成時に指定
* **ハック：** SA鍵DLは毒。

---

### Q5：SQL Server VMへ最速接続

* **キーワード：** SQL Server, simplest connection
* **正解：** RDP（Port 3389）
* **ハック：** Windows＝RDP。

---

### Q6：別PJTのArtifact RegistryからPull

* **キーワード：** separate project, pull images
* **正解：** GKEノードSAに Artifact Registry Reader
* **ハック：** 触る側のSAに権限。

---

### Q7：Windows VMのログイン情報取得

* **正解：** `gcloud compute reset-windows-password`
* **ハック：** Googleログインではない。

---

### Q8：構成ファイルでVM自動作成

* **正解：** Deployment Manager（※ACE想定）
* **ハック：** IaC＝構成ファイル。

---

### Q9：App Engine 1%リリース

* **正解：** Traffic Splitting
* **ハック：** 別アプリ作らない。

---

### Q10：GCS 90日/365日自動処理

* **正解：** Lifecycle Management
* **ハック：** 自動化が薬。

---

# 💻 運用・トラブル (Q11–Q20)

### Q11：Dockerfile→GKE

* **正解：** Image作成→Artifact Registry→Deployment
* **ハック：** Deploymentが器。

---

### Q12：有効API一覧

* **正解：** `gcloud services list --enabled`

---

### Q13：6ヶ月費用分析

* **正解：** Billing Export → BigQuery
* **ハック：** SQL分析＝BigQuery。

---

### Q14：GKEをHTTPS公開

* **正解：** Ingress（Cloud Load Balancer）
* **ハック：** HTTPS＝L7。

---

### Q15：監査人に閲覧のみ

* **正解：** Project Viewer
* **ハック：** Predefined role最小。

---

### Q16：既存VM複製

* **正解：** Custom Image
* **ハック：** Snapshotはバックアップ。

---

### Q17：VM内ログをCloud Loggingへ

* **正解：** Logging Agent

---

### Q18：別PJT GCSへ自動書込

* **正解：** VMのSAに Storage Object Creator
* **ハック：** バケット側で権限付与。

---

### Q19：別VPC通信

* **正解：** Shared VPC
* **ハック：** 作り直しは毒。

---

### Q20：GKE高IOPS＋バックアップ

* **正解：** Local SSD + Persistent Disk + Snapshot

---

# 📦 ネットワーク・スケール (Q21–Q30)

### Q21：PodがPENDING

* **正解：** `kubectl describe pod`
* **ハック：** ログはまだ出ない。

---

### Q22：特定VMへSSH（最小管理）

* **正解：** OS Login
* **ハック：** 鍵配布は毒。

---

### Q23：PJT→VMまで

* **正解：** PJT→API有効→VM

---

### Q24：40時間バッチ・安く

* **正解：** 標準VM（終了後削除）
* **ハック：** Spotは24h制限で毒。

---

### Q25：大量時系列データ

* **正解：** Bigtable
* **ハック：** IoT＝Bigtable。

---

### Q26：BQコスト見積

* **正解：** `--dry-run`
* **ハック：** 読み取りバイトで課金。

---

### Q27：Docker→GKE最小

* **正解：** Artifact Registry→Deployment

---

### Q28：IAMまとめて管理

* **正解：** Folder
* **ハック：** Folderは継承（Inherit）。

---

### Q29：外部IPなしSSH

* **正解：** IAP TCP Forwarding

---

### Q30：複数PJT監視

* **正解：** Monitoring Workspace

---

# 💻 DB・負荷分散 (Q31–Q40)

### Q31：CPU混在最適化

* **正解：** ノードプール分離

---

### Q32：VPN冗長化

* **正解：** Custom VPC + Cloud Router + Active/Passive

---

### Q33：ADCそのまま移行

* **正解：** VMのSAにロール付与

---

### Q34：Data Studio表示エラー

* **正解：** BigQueryジョブ確認

---

### Q35：世界規模＋強一貫性

* **正解：** Cloud Spanner
* **ハック：** Global＋Consistent＝Spanner。

---

### Q36：gcloudにパス残したくない

* **正解：** 環境変数

---

### Q37：重要＋中断OK混在

* **正解：** 標準ノード＋Spotノード

---

### Q38：Cloud Run一部公開

* **正解：** Traffic Splitting

---

### Q39：脆弱性可視化

* **正解：** OS Config Agent

---

### Q40：Cloud Run安全リリース

* **正解：** Gradual Rollout

---

# 🛡 応用・DB選択 (Q41–Q50)

### Q41：世界中＋リレーショナル＋予測不能

* **正解：** Spanner

---

### Q42：GoogleアカウントなしSSH

* **正解：** 公開鍵をメタデータ登録

---

### Q43：Firewall変更監視

* **正解：** Log-based Metrics + Alert

---

### Q44：IP維持TCP公開

* **正解：** External TCP Network Load Balancer
* **ハック：** L4＝IP維持。

---

### Q45：PJT-A VM→PJT-B BQ

* **正解：** VMのSAに bigquery.dataViewer
* **ハック：** Ownerは毒。

---

### Q46：/25 IP枯渇

* **正解：** /24へ拡張
* **ハック：** マスク小さく＝IP増。

---

### Q47：毎回zone指定が面倒

* **正解：** `gcloud config set compute/zone`

---

### Q48：Jenkins最速

* **正解：** Marketplace

---

### Q49：部門ごと請求分離

* **正解：** 別Billing Account紐付け

---

### Q50：世界規模配車アプリ（追加項目）

* **キーワード：** high volume of rides worldwide, SQL queries, highly available and scalable
* **正解：** **Multi-region Cloud Spanner**
* **ハック：**

  * Global
  * SQL
  * High availability
  * High transaction volume
    ＝ Spanner

  ※ BigQueryは分析専用（OLAP）。配車はリアルタイム処理（OLTP）なので毒。

---

# 💊 試験攻略・超圧縮

* Global＋Relational＋Scale → Spanner
* IoT＋大量書込 → Bigtable
* 分析 → BigQuery
* 最小の手間 → Marketplace
* HTTPS公開 → Ingress
* IP維持 → L4 Network LB
* 鍵配布回避 → OS Login / SA

---
# ⚡️ Exam 3: ハックリスト v2 (Q1-Q50)

### 1) ☸️ GKE：構造とスケーリング

- **クラスター vs ノードプール**
  - クラスター：マンション一棟（管理単位）
  - ノードプール：スペックごとのフロア（マシンタイプ別の集合）

- **マシンタイプ変更の定石（ゼロ停止）**
  - 既存ノードを改造しない
  - **新しいスペックのノードプールを追加**
  - **Podを引っ越し（cordon / drain）**して段階移行  
  → これがサービスを止めない正解

- **スケーラビリティ**
  - スケールアップ（垂直）：1台をデカくする（例：`n1-standard-96`）  
    → 移行初期 / DB寄りに効く
  - スケールアウト（水平）：台数を増やす  
    → クラウドの真骨頂

### 2) 💰 コストとストレージの階層（Tiering）

- **GCSクラス境界**
  - **Nearline**：**「30日保持・月1アクセス」** がキーワード
  - 罠：安いクラス（Coldline/Archive）ほど **取り出し料金（毒）** が重い  
    → 月1回触るなら Nearline がトータル最安になりやすい

- **コスト可視化の黄金ルート**
  - 標準画面だけでは弱い
  - **Billing Export → BigQuery → Looker Studio** の3段活用  
  → 組織全体のコストを「一画面」で見る定番

### 3) 🌐 ネットワークと環境分離

- **VPC Peering**
  - 同じ組織内のVPCを繋ぐ最速・最安
  - **Route Tableの手動設定は不要**（SDNが自動でルートを通す）
  - **IP帯の重複は厳禁**

- **環境分離のベストプラクティス**
  - **「プロジェクトを分ける」** がGoogle推奨の基本
  - 理由：IAM / Billing / Quota が **プロジェクト単位で隔離**され、事故が波及しにくい

### 4) 🔑 セキュリティと権限（IAM）

- **Dedicated Service Account（専用SA）**
  - デフォルトSA（Editor残存）使い回しは毒
  - タスク専用SAを作って最小権限を付与
    - 例：GCS書き込みだけ → `storage.objectCreator`（削除不可）

---

## 🌐 自動化・パイプライン (Q1-Q10)

**Q1：Deployment Manager変更前の「最速」依存関係チェック**
- キーワード：`verify resource dependencies`, `quickest possible validation`
- 正解：**`--preview`**
- ハック：リソースを作らずシミュレーションでミスを潰す

**Q2：A/CメーカーのIoTパイプライン（収集→保存→分析）**
- キーワード：`time-series data`, `Box 1, 2, 3`
- 正解：**Dataflow / Bigtable / BigQuery**
- ハック：Dataflow（流す）→ Bigtable（貯める）→ BigQuery（分析）

**Q3：外部監査人に「アクセスログ」と「BQ」を見せたい**
- キーワード：`external auditing`, `view audit logs`, `BigQuery dataset`
- 正解：Groupに **`logging.viewer`** + **`bigquery.dataViewer`**
- ハック：個人よりGroup、CustomよりPredefined

**Q4：VM→GCS書き込み権限（最小権限）**
- キーワード：`write sensor data`, `specific Cloud Storage bucket`, `best practices`
- 正解：Dedicated SA → バケットへ **`storage.objectCreator`**
- ハック：`objectAdmin` は削除できるので強すぎ（毒）

**Q5：従業員の写真閲覧・メタデータ変更履歴**
- キーワード：`verify which photos viewed`, `added or modified metadata`, `fewest steps`
- 正解：Consoleの **Activity log**
- ハック：監査の最短ルート

**Q6：Googleアカウントなし業者へ4時間限定共有**
- キーワード：`no Google accounts`, `accessible for four hours`, `securely shared`
- 正解：**Signed URL**
- ハック：公開はNG。時間制限共有＝署名URL

**Q7：SAが作成された正確な時間**
- キーワード：`exact creation time`
- 正解：Activity log（Configuration / Service Account）
- ハック：作成削除＝Configuration、閲覧＝Data Access

**Q8：GKE全ノードに監視Podを強制配備**
- キーワード：`monitoring pod deployed on each node`, `cluster autoscaler enabled`
- 正解：**DaemonSet**
- ハック：全ノードに1つ＝DaemonSet

**Q9：IP枯渇サブネットの拡張**
- キーワード：`out of available IP addresses`, `without additional network routes`
- 正解：subnet **`expand-ip-range`**
- ハック：作り直しはダウンタイム（毒）。拡張が正解

**Q10：WorkspaceユーザーにPJTアクセス付与**
- キーワード：`WorkSuite accounts`, `grant access`
- 正解：メールアドレスにIAMロール付与
- ハック：そのままIAMに入れるだけ

---

## 💻 運用・コスト管理 (Q11-Q20)

**Q11：複数PJTでVM作成（CLI、地域違い）**
- 正解：`gcloud config configurations create` → `activate`
- ハック：PJTごとにプロファイル分離

**Q12：全コンピュート一覧を毎日自動取得**
- 正解：configを2つ作り切替しつつ `instances list` を回す
- ハック：config切替ループが王道

**Q13：7TB AVROをSQLで最速・安価に分析**
- 正解：**BigQuery External Tables**
- ハック：ロードは時間/コストが毒。外部参照で叩く

**Q14：Dev→Prod移行（新PJT）**
- 正解：新PJT作成 → そこへ再デプロイ
- ハック：コピー機能に逃げない

**Q15：UDP 636 を許可**
- 正解：Network Tag + Ingress Firewall Rule（UDP 636）
- ハック：タグだけでは穴は開かない

**Q16：共通Billingで1PJTだけBudgetアラート**
- 正解：Billing AccountでBudget作成 → Projectフィルタ
- ハック：Budgetは請求側でPJTを絞れる

**Q17：公共ネットから絶対遮断したいVM**
- 正解：Public IPなしで作成
- ハック：物理的に外から来ない

**Q18：インフラ変更案をチーム共有（Google推奨）**
- 正解：Deployment Managerテンプレ → Git（Cloud Source Repos等）
- ハック：IaC + Gitレビューが基本

**Q19：GKEで一部チームだけGPU（コスト最小）**
- 正解：GPU専用Node Pool → `nodeSelector`
- ハック：全体GPU化は毒

**Q20：同僚にGCSを全管理させたい**
- 正解：**Storage Admin**
- ハック：バケット作成/削除込みならAdmin

---

## 📦 GKE・スケーリング (Q21-Q30)

**Q21：別スペックNodeを追加（停止なし）**
- 正解：新Node Pool作成 → Pod段階移行
- ハック：スペック変更は「新プール追加」が定石

**Q22：Spanner（最新）+ Bigtable（履歴）を一時結合して分析**
- 正解：BigQuery（外部参照/連携）でSQL
- ハック：ad hoc結合＝BQで即席

**Q23：96 vCPU必要**
- 正解：`n1-standard-96`
- ハック：型番指定なら迷わない

**Q24：ゾーン障害に耐え、ゼロ停止、低コスト**
- 正解：**同一リージョン内の別ゾーンへ展開** → LBで冗長化
- ハック：マルチゾーンが最小コストのHA

**Q25：GCS：30日後アーカイブ、月1回読取＋更新**
- 正解：Lifecycle → Nearline
- ハック：月1ならNearline（取り出し毒が軽い）

**Q26：誰がProject Ownerか調査**
- 正解：`gcloud projects get-iam-policy`
- ハック：ポリシーを丸ごと取得が確実

**Q27：毎日バックアップ、30日保持、管理最小**
- 正解：Snapshot Schedule
- ハック：標準機能で済ませる

**Q28：複数PJTコストを一画面・ほぼリアルタイム**
- 正解：Billing Export → BigQuery → Looker Studio
- ハック：横断可視化の定番

**Q29：夜間巨大バッチ。中断OK、最安**
- 正解：Spot / Preemptible VM
- ハック：fault-tolerant＝Spot

**Q30：外部ネット禁止VMからGCSアクセス**
- 正解：Private Google Access
- ハック：外に出さずGoogle APIへ

---

## 🛡 ネットワーク・高度な管理 (Q31-Q50)

**Q31：買収PJTを自社Orgへ移動＋請求も自社**
- 正解：`projects.move` + Billing更新
- ハック：作り直しは毒。移動できる

**Q32：DNS：root/www/homeをLBへ**
- 正解：root→A、subdomain→CNAME
- ハック：naked domainはA

**Q33：財務ルールに合わせたコスト分析自動化**
- 正解：Billing Export → BigQuery → Looker Studio
- ハック：tailored＝SQL

**Q34：サードパーティPMPを最速導入**
- 正解：Cloud Marketplace
- ハック：ポチ導入＝Marketplace

**Q35：個人カードなしでPJT作成可能に**
- 正解：会社Billing Account作成＋紐付け権限付与
- ハック：支払い元を中央化

**Q36：時系列・高負荷・原子性**
- 正解：Bigtable
- ハック：IoT/時系列＝Bigtable

**Q37：CLIでinstances list前に必要な2設定**
- 正解：`gcloud auth login` + `gcloud config set project`
- ハック：誰が/どこで を先に決める

**Q38：CI/CD権限エラーの確認先**
- 正解：SAのIAM Roles（Project/Folder/Org + 継承含む）
- ハック：inheritedも見る

**Q39：マニフェストは使うがインフラ管理は最小**
- 正解：GKE Autopilot
- ハック：Node管理を捨てる

**Q40：Public IP不要で安全にSSH**
- 正解：IAP `--tunnel-through-iap`
- ハック：晒さず裏口SSH

**Q41：世界規模・予測不能・relational**
- 正解：Cloud Spanner
- ハック：Global + ACID + Scale＝Spanner

**Q42：VPC A と VPC B を接続（同一組織）**
- 正解：VPC Network Peering
- ハック：追加インフラ不要で最速

**Q43：App→DBだけ許可（よりセキュアに）**
- 正解：SAベース許可（source SA → target SA）
- ハック：IP/タグより偽装耐性が高い

**Q44：US内のみ作成を許可**
- 正解：Organization Policy（ロケーション制限）
- ハック：禁止/制限＝Org Policy

**Q45：GKE Node IP枯渇**
- 正解：CIDR拡張（expand-ip-range等）
- ハック：作り直しより拡張

**Q46：GCS到着でSpeech-to-Text（管理最小）**
- 正解：Cloud Functions（GCSトリガー）
- ハック：イベント駆動の教科書

**Q47：買収先Orgでも同じ権限を使いたい**
- 正解：`gcloud iam roles copy`
- ハック：既存カスタムロールを複製

**Q48：GCS静的コンテンツを効率配信**
- 正解：HTTP(S) Load Balancer + URL map（GCS backend）
- ハック：パスで振り分け

**Q49：300TBオンプレ＋Redshift＋S3ロゴ移行**
- 正解：Transfer Appliance + BQ Data Transfer Service + Storage Transfer Service
- ハック：物理便 / BQ連携 / クラウド間転送

**Q50：Cloud SQL：暗号化＋IAM連携＋管理最小**
- 正解：IAM DB Auth + Cloud SQL Auth Proxy
- ハック：パスワード運用を捨てる

---

## 💡 試験攻略の「一言」

「ad hoc（一時的）なデータ結合」と言われたら **BigQuery** を最優先で探す。  
このパターンだけで 1〜2点拾える。

---
# ⚡ Exam 4: ハックリスト (Q1-Q50)【完全版・GKE知識マージ済み】

## 🔐 セキュリティ・権限管理 (Q1-Q10)

**Q1：別プロジェクト(PJT-B)のVMスナップショットをPJT-AのSAで行いたい**

* キーワード：`service account from project A`, `take snapshots in project B`
* 正解：**PJT-B** で、**PJT-AのSA** に対して **`Compute Storage Admin`** ロールを付与
* ハック：

  * 鍵(JSON)を配布するのは毒。**リソースがある側（PJT-B）でIAM付与**が正解
  * SA = Service Account（人ではなく“ワークロード用のアカウント”）。権限は **SAに付く**（人に付くのと同じIAMモデル）

---

**Q2：3人の開発者にSpannerの「閲覧と修正」権限を付与。管理しやすく。**

* キーワード：`view and modify`, `three developers`, `correct permissions`
* 正解：**Google Group** を作成 ➔ 開発者を追加 ➔ グループに **`roles/spanner.databaseUser`** を付与
* ハック：

  * 個人への直接付与は管理が崩れる。**Groupで束ねる**
  * `viewer` は修正できない

---

**Q3：GKEクラスターを常に「サポート対象の安定版」に保つ**

* キーワード：`GKE cluster`, `consistent supported and stable version`
* 正解：**Node Auto-Upgrades** を有効にする
* ハック：

  * `Auto-Repair` は「壊れたら直す」であって、バージョン維持ではない
  * 補強：試験で “安定版” が強い場合、**Release channel（stable/regular/rapid）** の概念が絡むことがある（ただし本問は Auto-Upgrades が薬）

---

**Q4：ウェブアプリ(HTTPS)の負荷分散 ＋ SSL終端。Google推奨。**

* キーワード：`served over HTTPS`, `properly load-balanced`, `terminate SSL at LB`
* 正解：**HTTP(S) Load Balancer**
* ハック：

  * Web(L7)はこれ一択。SSL Proxy は非HTTP寄りで最適ではない
  * 補強：外部公開で防御も絡むなら **Cloud Armor** がセットで出やすい（WAF）

---

**Q5：オンプレとGCP間の「プライベートIP」通信。低遅延。**

* キーワード：`communicate directly using private IP`, `low-latency`
* 正解：**Cloud VPN**
* ハック：

  * PeeringはVPC同士、Shared VPCは組織内共有用
  * “専用線” がほしいなら Dedicated Interconnect の方向（ただし本問はVPN）

---

**Q6：1000個のBQデータセットから「customer_id」列を持つテーブルを探す**

* キーワード：`over 1000 datasets`, `identify column named customer_id`, `minimal manual effort`
* 正解：**Data Catalog** で検索
* ハック：

  * “列名などのメタデータ横断検索”＝Data Catalog
  * 自作スクリプトは手間が増える

---

**Q7：GKEデプロイ：1つはRunning、もう1つがPending。原因は？**

* キーワード：`one pod is Running`, `second one remains in Pending`
* 正解：**リソース不足**（Insufficient resources）
* ハック（補強済み・ここ重要）：

  * 1つ動いているなら、イメージ名ミスやSA権限不足は主因になりにくい
  * **Pendingで真っ先に見る順**

    1. CPU/メモリ不足（最頻）
    2. nodeSelector / taints / affinity など “席の指定”
    3. IP枯渇（サブネット / Pod CIDR / ノードIP）
  * 最短確認：`kubectl describe pod` の Events を見る（Insufficient cpu/memory が出る）

---

**Q8：App Engine：us-central1 から asia-northeast1 へ変更したい**

* キーワード：`App Engine`, `originally us-central1`, `now asia-northeast1`
* 正解：**新しいGCPプロジェクト** を作成し、そこでApp Engineを作成
* ハック：

  * GAEリージョンは一度決めたら変更不可。PJTごと作り直しが唯一

---

**Q9：ShareSyncアプリ：24時間稼働 ＋ インスタンスは「常に1台」厳守。**

* キーワード：`available at all times`, `only one instance active across entire project`
* 正解：**Autoscaling Off** ＋ **Min 1 / Max 1**
* ハック：

  * “絶対1台” と “勝手に増える” は両立しないので Autoscalingは切る
  * 自動復旧は autohealing 側の発想

---

**Q10：PJT内の「IAMユーザーとロール」の割り当て状況を確認**

* キーワード：`verify the IAM users and roles assigned`
* 正解：GCP Console の **IAM セクション**
* ハック：

  * `gcloud roles list` は “ロール一覧” であって “誰に付いてるか” ではない

---

## 💰 請求・コスト・スケーリング (Q11-Q20)

**Q11：新しい Billing Account を作成して既存PJTに紐付けたい**

* キーワード：`create a new billing account`, `link it with an existing project`
* 正解：**Project Billing Manager** 権限を確認 ➔ 新規請求先作成 ➔ PJTにリンク
* ハック：

  * 請求アカウントの作成/リンクは権限が強め。権限確認が先

---

**Q12：BigQuery のコストが爆増。抑えるための2つの有効策。**

* キーワード：`costs becoming excessive`, `strategies to control`
* 正解：**クエリ割当（Quotas）** ＋ **Flat-rate（定額）**
* ハック：

  * 上限を決める（Quotas）/ 予算を固定（Flat-rate）
  * PJT分割だけでは “コストそのもの” は減らない

---

**Q13：信頼できないクライアントコードを実行。GKEでの「最大レベル」の隔離。**

* キーワード：`execute arbitrary code`, `maximum level of isolation between pods`
* 正解：**gVisor**（runtimeClassName: gvisor）
* ハック（補強済み）：

  * “怪しいコード隔離”＝サンドボックス＝gVisor
  * 位置づけ（覚える比較軸）

    * 通常ランタイム（runc）：速い／隔離はOS共有
    * **gVisor：隔離強い／多少オーバーヘッド**
    * Kata等：VM級隔離（ACE頻度は gVisor の方が濃い）

---

**Q14：Spanner：主キーによる読み取り遅延。スキーマをどう変える？**

* キーワード：`read latency issues`, `primarily accessed using primary key`, `monotonically increasing`
* 正解：主キーを **単調増加にしない**
* ハック：

  * 連番はホットスポット化。UUIDなどで分散

---

**Q15：経理部門に「請求レポート」だけ見せたい。**

* キーワード：`access billing report`, `only billing information`
* 正解：**`roles/billing.viewer`**
* ハック：

  * “見るだけ” は viewer。user は強い

---

**Q16：SREに「Googleサポートへのアクセス承認」をさせたい。Google推奨。**

* キーワード：`approve requests from Google support`, `best practices`
* 正解：Google Group ➔ **`roles/accessapproval.approver`**
* ハック：

  * 承認＝accessapproval。個人付与よりグループ

---

**Q17：複数PJTのモニタリングを「1つのダッシュボード」に統合**

* キーワード：`consolidate monitoring`, `unified dashboard`
* 正解：単一の **Monitoring account (Workspace)** を作り、全PJTをリンク
* ハック：

  * 可視化統合は Workspace で束ねる

---

**Q18：VPCからのデータ流出(Egress)を「最小限のポート」で制限**

* キーワード：`controlling data leaving VPC (egress)`, `fewest open ports`
* 正解：優先度低で Deny all ➔ 優先度高で必要ポートのみ Allow
* ハック：

  * “まず全部閉める→必要だけ開ける” が鉄則

---

**Q19：GCSにファイルが置かれたら「即座に」画像処理を開始**

* キーワード：`triggered every time`, `automatically process`
* 正解：**Cloud Functions（GCSトリガー）**
* ハック（補強）：

  * “即座に反応”＝イベント駆動＝Functions
  * Schedulerは時間指定なので “即座” とズレる

---

**Q20：Spanner の IAM ロールに「いつ誰が追加されたか」の履歴調査**

* キーワード：`track when users were added`
* 正解：Cloud Logging（Operation Suite）で **Admin Activity logs** をフィルタ
* ハック：

  * IAM画面は “現状” しか見えない。履歴はログ

---

## 📦 運用・高度な構成 (Q21-Q30)

**Q21：IoTデータ：最初の30日は頻繁に、その後3年間は稀にアクセス。コスト最小。**

* キーワード：`frequent for 30 days`, `rarely accessed`, `3 years`
* 正解：Standard（30日）➔ Archive（3年）
* ハック：

  * 最初は頻繁＝Standard
  * 3年放置＝Archive

---

**Q22：法令遵守：GCSの「全読み取り操作」を記録しなければならない**

* キーワード：`every request to read... recorded`
* 正解：**Data Access audit logs** を有効化
* ハック：

  * デフォルトでは Read のログが出ない。Data Access をON

---

**Q23：10人の開発者。各自のPJTで「月額650ドル」を超えたら自分に通知**

* キーワード：`any exceed $650`
* 正解：**各PJTごとにBudgetとアラート**
* ハック：

  * 1個の予算だと合計しか見えない。PJT別に作る

---

**Q24：VM：管理コンソールでの「うっかり削除」を物理的に防ぐ**

* キーワード：`accidentally deletes`
* 正解：**Delete protection**
* ハック：

  * 削除操作を止める直球の機能

---

**Q25：運用チームに本番PJTの全権限を。将来の権限拡大を防ぐ。**

* キーワード：`prevent unintended permission escalation`
* 正解：**Custom Role** を作って付与
* ハック：

  * Editorは将来権限が増えるリスク（最小権限に反する）

---

**Q26：GCS：単一地域に限定 ＋ 30日後にアーカイブ ＋ 年1回アクセス。**

* キーワード：`single region`, `once a year`
* 正解：Regional ➔ Coldline
* ハック：

  * 年1回＝Coldline、数年1回＝Archive

---

**Q27：Googleアカウントを持たないパートナーにLinux VMのメンテを頼む**

* キーワード：`partner does not use Google Accounts`
* 正解：相手の **SSH公開鍵** をVMに登録
* ハック：

  * IAP/gcloudはGoogleログインが必要。アカウントなし＝鍵

---

**Q28：Pub/Sub API が無効。SAで認証する前に必要なこと。**

* キーワード：`Pub/Sub API is disabled`
* 正解：API Library で有効化
* ハック（補強）：

  * “電話機（SA）” の前に “電話線（API Enable）”
  * API無効なら全部無意味

---

**Q29：Cloud Run：最初の1ページ目だけ異常に遅い（コールドスタート）**

* キーワード：`initial load time slower`
* 正解：min-instances を設定
* ハック：

  * Scale-to-zero を避けて “常に暖める”

---

**Q30：数百万のGPSデバイスからの大量データを、高可用に処理・保存したい**

* キーワード：`streaming`, `resilient`
* 正解：Pub/Sub ➔ Dataflow ➔ GCS
* ハック：

  * 大量流入＝Pub/Sub、処理＝Dataflow、保存＝GCS

---

## 📦 運用・移行・標準化 (Q31-Q40)

**Q31：オンプレの大量動画ファイルを定期的にGCSへ同期したい。自動化。**

* 正解：`gcloud storage` ＋ Cron
* ハック：

  * 同期はコマンド＋スケジューラが最短

---

**Q32：大量のGCPリソースを「IaC（コード）」で標準化・簡素化したい。**

* 正解：Deployment Manager
* ハック：

  * “GCP純正IaC” の文脈

---

**Q33：26時間かかる中断不可のバッチ。最低コストで。**

* 正解：Compute Engine VM（手動起動/停止）
* ハック：

  * Spotは中断リスク。26時間なら標準VMが結局安定

---

**Q34：MySQL(オンプレ)、Kafka、PostgresをGCPへ。最小管理・グローバル。**

* 正解：MySQL→Spanner / Kafka→Pub/Sub / Postgres→BigQuery
* ハック：

  * “グローバル・最小管理” という言い回しは Spanner に寄る

---

**Q35：VMのディスクを毎日バックアップ。7日保管。管理最小。**

* 正解：Scheduled snapshots
* ハック：

  * 自作よりマネージド機能

---

**Q36：セキュリティ上「承認された構成」でしかデプロイさせたくない。**

* 正解：Terraform Modules を共有
* ハック：

  * “型紙” を作ってそれを使わせる（統制）

---

**Q37：部門ごとにセキュリティ要件が違う。管理しやすくログも分けたい。**

* 正解：部門ごとFolder ➔ Folderレベルで Org Policy / Log Sink
* ハック：

  * Orgは広すぎ、PJTは細かすぎ。Folderが中間の最適点

---

**Q38：30分限定アップロード ＋ 50日後に自動削除。**

* 正解：Signed URL（30分）＋ Lifecycle（50日）
* ハック：

  * 期限付きアクセス＝署名付きURL
  * 自動削除＝ライフサイクル

---

**Q39：MIGを「セキュア・高可用」に公開。**

* 正解：HTTP(S) LB ＋ A record
* ハック（補強）：

  * 高可用＝LB
  * 防御も必要なら Cloud Armor を連想（WAF）

---

**Q40：社内ドメイン以外のユーザーアクセスを禁止したい。**

* 正解：Org Policyで制限＋既存ユーザー手動削除
* ハック：

  * ポリシーは “これから” を止める。いま居る異物は掃除が要る

---

## 🧩 組織・IAM・GKE運用 (Q41-Q50)

**Q41：複数製品の権限を「全開発者」に一括適用。**

* 正解：Group作成 ➔ Custom Role作成 ➔ Orgレベルで付与
* ハック：

  * “まとめて” “一括” は Group＋Org付与

---

**Q42：外部デザイナーに「ディスク一覧」だけ見せたい。**

* 正解：list権限だけの Custom Role
* ハック：

  * Adminは強すぎ。Listだけに絞る

---

**Q43：マイクロサービス群のリソース過不足を直したい。**

* 正解：VPA
* ハック：

  * サイズ＝VPA、数＝HPA

---

**Q44：PostgreSQLを最小変更でクラウドへ（ACID）。**

* 正解：Cloud SQL（PostgreSQL）
* ハック：

  * 同エンジン＝改修最小

---

**Q45：BigQuery quotaExceeded の原因調査。**

* 正解：INFORMATION_SCHEMA＋Audit Logs
* ハック：

  * メタ情報と操作ログの突合

---

**Q46：ステートレスアプリをVM上で自動スケール。**

* 正解：MIG＋Autoscaling
* ハック：

  * VM指定＝MIG、コンテナ指定＝GKE/Run

---

**Q47：内部IPのみ・頻繁更新・管理最小。**

* 正解：Cloud Run＋PSC
* ハック（補強）：

  * サーバーレス運用最小＝Cloud Run
  * “内部限定公開” の接続は PSC が薬

---

**Q48：/20のサブネットがIP不足。**

* 正解：/18へ拡張
* ハック：

  * マスクを小さくして “枠を広げる”
  * GKEノード/PodでIP枯渇が絡むときも、この発想

---

**Q49：Cloud Logging をSQLで分析（Google推奨）。**

* 正解：Log Analytics 有効化＋BigQueryリンク
* ハック：

  * いまの推奨は “Log Analytics→BQリンク” が速い

---

**Q50：Cloud Run→Cloud SQL 高負荷でAPI quotaエラー。**

* 正解：max-instances を下げる
* ハック（補強）：

  * インスタンス増＝DB接続増＝クォータ/上限に当たりやすい
  * Run側で上限をかけて守る

---

## ☸️ 追加：GKEトラブルシュート最短インデックス（ACE用）

Podが動かない（Pending）ときの最短手順

1. `kubectl describe pod` → Eventsを見る
2. Insufficient cpu/memory なら CA（Cluster Autoscaler）やノード増強
3. nodeSelector/taints/affinity など “制約” で詰まってないか
4. IP枯渇（サブネット / Pod CIDR / ノードIP）を疑う

オートスケーラー反射表

* Pod数：HPA
* Podサイズ：VPA
* Node数：Cluster Autoscaler
* Cloud Run 初動遅い：min-instances
* Cloud Run→Cloud SQL で増えすぎ：max-instances を絞る

---

## ☠️ 追加：GKE地雷一覧（ACE用・ミニ）

1. Pendingで YAML読み返し地獄（Eventsを見ない）
2. HPA/VPA/CA の混同
3. IP枯渇（ノード増えない／Pod乗らない）を見落とす
4. “怪しいコード隔離” で gVisor を出せない
5. キー(JSON)配布で事故（本来は Workload Identity 方向の思想）

---

## 💡 試験攻略の「急所」

「Google推奨（Best Practices）」と言われたら

* マネージドサービス（Googleが運用を面倒見る）
* IAMは個人ではなくGroup
  この2つをまず当てにいく。

---
# ⚡️ Exam 5: ハックリスト (Q1-Q50)

### 🌐 ネットワーク・データ転送 (Q1-Q10)

**Q1：35GBの巨大ファイルを1Gbps回線で「最速」アップロード**

* **キーワード：** `35 GB file`, `1 Gbps connection`, `maximize upload speed`.
* **正解：** **`gsutil`** で **Parallel composite uploads** を有効にする。
* **ハック：** コンソール(A)は並列処理ができないため遅い。巨大ファイルを分割して並列で投げる `composite uploads` が最速。

**Q2：オートスケーリングで「インスタンスが増えすぎる」のを防ぎたい**

* **キーワード：** `adds more instances than necessary`, `VM takes two minutes to ready`.
* **正解：** **Health Check の Initial Delay** を（2分＝200秒に）増やす。
* **ハック：** 起動に時間がかかるVMを「死んでいる」と誤認して次々追加されるのを防ぐため、待機時間(Initial Delay)を伸ばすのが薬。

**Q3：2時間の夜間バッチ処理を最低コストで。**

* **キーワード：** `nightly batch-processing`, `2 hours to complete`, `reduce cost`.
* **正解：** **Compute Engine Preemptible VM**。
* **ハック：** 24時間以内に終わるバッチなら、最大91%オフの Preemptible が最強。GKE(A, B)は管理コストがかさむ。

**Q4：メンテナンス中も停止させず、クラッシュ時は自動復旧させたい**

* **キーワード：** `available during maintenance`, `crash... automatically restart`.
* **正解：** **Automatic Restart: ON** ＋ **On-host maintenance: Migrate**.
* **ハック：** メンテ時は「別の箱へ引越し(Migrate)」させ、死んだら「勝手に再起動」させる設定のセット。

**Q5：Prod(本番)とTest(検証)のサブネット。同一VPCで内部通信。**

* **キーワード：** `different subnets`, `communicate using Internal IPs`, `no additional routing`.
* **正解：** **単一の Custom VPC** 内に **2つの Subnet** を作成。
* **ハック：** VPCが同じなら、サブネットを跨いでもデフォルトで「内部IP」で会話できる。追加設定は不要。

**Q6：共有プロジェクトで、他チームによる「うっかり削除」を防止**

* **キーワード：** `unintentionally bring offline`, `shared with multiple departments`.
* **正解：** **Deletion protection** (削除保護) を有効にする。
* **ハック：** Exam 4のQ24と同じ。物理的に「削除ボタン」を無効化するのが確実。

**Q7：ローカル（Ubuntu）で Cloud Datastore をシミュレートしてテスト**

* **キーワード：** `Ubuntu`, `simulate Cloud Datastore locally`.
* **正解：** **`apt-get install`** で **`google-cloud-sdk-datastore-emulator`** を導入。
* **ハック：** OSのパッケージ管理(apt)を使っているなら、エミュレータも `apt` で入れるのが一貫性。

**Q8：K8s：YAMLにDBパスワードが平文で書いてある。修正案は？**

* **キーワード：** `DB_PASSWORD value: "securePass123"`, `security best practices`.
* **正解：** **Secret オブジェクト** に保存し、YAMLから参照する。
* **ハック：** 「パスワード」➔「Secret」。ConfigMap(C)は機密でない設定用。イメージ内(A)に埋めるのは論外。

**Q9：組織階層（フォルダ・PJT）の「全体図」だけを特定グループに見せたい**

* **キーワード：** `view the full organizational structure`, `minimal permissions`.
* **正解：** Google Group に対して **`roles/browser`** ロールを付与。
* **ハック：** 組織を眺める（閲覧する）ための専用ロール ＝ `browser`。

**Q10：デプロイ先（プロジェクト）を間違えた。原因を調査したい。**

* **キーワード：** `didn't happen on the correct project`, `investigate`.
* **正解：** **`gcloud config list`** で現在の設定（Active Project）を確認。
* **ハック：** コマンドラインでの操作ミスは、自分の「今の設定」を確認するのが基本。

---

### 💻 認証・インフラ管理 (Q11-Q20)

**Q11：既存の Active Directory SSO を Google でも使いたい**

* **キーワード：** `existing SSO provider`, `authenticate using AcmeSolutions' SSO`.
* **正解：** **Third-party IDP (AD)** ＋ **Google as Service Provider**.
* **ハック：** 「自分たちのADでログインさせ、Googleを使わせる」なら、ADが親(IDP)、Googleが子(Service Provider)。

**Q12：App Engine：バグがある新版を「即座に」旧版へ戻したい**

* **キーワード：** `critical bug`, `quickly revert to previous stable version`.
* **正解：** **Versions ページ** で **100% のトラフィックを旧版へ向ける**。
* **ハック：** デプロイし直すのではなく、トラフィックの蛇口（Split）をひねって戻すのが最速。

**Q13：財務データ：四半期に1回（3ヶ月ごと）アクセス。コスト最小。**

* **キーワード：** `archived datasets`, `once every quarter`, `cost efficiency`.
* **正解：** **Coldline Storage**。
* **ハック：** 罠：Archive(A)は年1回未満。月1回ならNearline。その中間（3ヶ月）なら **Coldline** が薬。

**Q14：GKE：AIモデル（中断不可）の実行に GPU が必要。コスト最小。**

* **キーワード：** `AI models`, `non-restartable tasks`, `GPUs`, `cost-efficient`.
* **正解：** **Node auto-provisioning** (NAP) を有効にする。
* **ハック：** 「必要な時だけGPUノードを自動で作り、終わったら消す」のが NAP。Preemptible(C)は中断されるのでNG。

**Q15：本番(Prod)と開発(Dev)を「絶対に」ネットワーク分離したい。Google推奨。**

* **キーワード：** `no network routes between environments`, `best practices`.
* **正解：** **環境ごとにプロジェクトを分ける**。
* **ハック：** GCPでの「絶対分離」＝ プロジェクト分離。VPCを分ける(B, C)より確実。

**Q16：社内ツール：営業時間外はコストを「ゼロ」にしたい。コンテナ。**

* **キーワード：** `business hours only`, `no charges when not in use`.
* **正解：** **Cloud Run (fully managed)** ＋ **Min instances: 0**。
* **ハック：** 誰もいない時にインスタンスが消えて0円になるのは Cloud Run だけの特技。

**Q17：個人カード払いのPJTを、会社の請求アカウントへ「正式に」移したい**

* **キーワード：** `personal credit card`, `ensure charged to corporate billing account`.
* **正解：** プロジェクトの **Billing Account を変更** する。
* **ハック：** PJTの設定画面で、支払い紐付け先をポチッと変えるだけ。

**Q18：GCS上のPDFリンク：ダウンロードされずに「ブラウザで開く」ようにしたい**

* **キーワード：** `open directly in browser`, `without triggering download prompt`.
* **正解：** メタデータの **Content-Type** を **`application/pdf`** に設定。
* **ハック：** ブラウザに「これはPDFだよ」と教えれば、最近のブラウザは勝手に開いてくれる。

**Q19：分析者：BQのクエリはさせたいが、「削除」はさせたくない。Google推奨。**

* **キーワード：** `query datasets`, `prevent accidentally deleting`, `best practices`.
* **正解：** **Custom Role** (削除権限抜き) を作成 ➔ **Group** に付与。
* **ハック：** `dataEditor` (B) は削除もできる。必要な「閲覧＋クエリ」だけのカスタムロール ＋ グループ管理が最強。

**Q20：社内 AD のユーザーを Google Cloud へ自動同期したい**

* **キーワード：** `Active Directory as primary source of truth`, `complete control`.
* **正解：** **Google Cloud Directory Sync (GCDS)**。
* **ハック：** AD ➔ GCP の同期ツールといえば GCDS。覚えゲー。

---

### 📦 運用・高度な設定 (Q21-Q30)

**Q21：VM：2 vCPU / 4GB を「メモリだけ 8GB」に上げたい。**

* **キーワード：** `out of memory`, `upgrade to 8 GB`, `best approach`.
* **正解：** **VMを停止 ➔ メモリを 8GB に変更 ➔ 起動**。
* **ハック：** スペック変更には一度「停止」が必要。Live migration(A)はメンテ用でスペック変更はできない。

**Q22：パートナー企業(LearnAI)に、こちらのBQデータを読ませたい。**

* **キーワード：** `Partner company requires access to your BQ dataset`.
* **正解：** **相手側のSA** を作成してもらい、こちらのデータセットに **アクセス権** を付与。
* **ハック：** 「鍵を渡す(A)」のではなく「相手を招待する」のが正しい共有。

**Q23：PJT横断で「SAの作成・管理」をする人への最小権限。**

* **キーワード：** `creating and managing all service accounts`, `minimum necessary`.
* **正解：** **`roles/iam.serviceAccountAdmin`**。
* **ハック：** 職務名そのままのロール。`serviceAccountUser` (C) は「使う」権限であり「作成」はできない。

**Q24：オンプレDBへの接続。IPが変わってもアプリを直したくない。**

* **キーワード：** `avoid reconfiguring every time database IP changes`.
* **正解：** **Cloud DNS Private Zone** で DNS名(db.localなど)を使う。
* **ハック：** アプリには名前で呼ばせ、IPが変わったらDNSの設定だけを直す。

**Q25：誰が「機密データ」を見る権限を持っているか特定したい。**

* **キーワード：** `identify who has permission to view sensitive data`.
* **正解：** **IAM 権限のレビュー**。
* **ハック：** ログ(A)は「誰が見たか」の結果。権限設定そのものを見るのが薬。

**Q26：Cloud Run (Anthos)：一部のユーザーで新版をテスト（カナリア展開）。**

* **キーワード：** `Cloud Run for Anthos`, `canary deployment`, `percentage of users`.
* **正解：** **新しい Revision** を作成 ➔ **Traffic Splitting**。
* **ハック：** 新サービス(A)にする必要はない。同じサービス内の「新旧リビジョン」で分ける。

**Q27：リアルタイム・クイズアプリ。大量の UDP パケットを処理。外部公開。**

* **キーワード：** `send UDP packets`, `real time`, `single IP address`, `Internet`.
* **正解：** **External Network Load Balancer**.
* **ハック：** UDP 対応 ＋ 外部公開 ➔ Network LB (L4)。HTTP LB(C)は UDP 非対応。

**Q28：外部監査人に「誰がGCSに触ったか」のログを見せたい。**

* **キーワード：** `who accessed the stored images`, `access logs`.
* **正解：** **Data Access Logs** を有効化 ➔ **ログビューア** でフィルタ。
* **ハック：** 罠：デフォルトでこのログは出ない。明示的に「Data Access」をONにする必要がある。

**Q29：MIG内の1台が応答不能。サービスを止めずに交換したい。**

* **キーワード：** `process no longer responding`, `replace this unresponsive VM`.
* **正解：** **`recreate-instances`** コマンド。
* **ハック：** 死にかけの個体だけを「作り直す」ピンポイントの外科手術。

**Q30：Workspace 管理下の組織が10倍に増える。スケーラブルな認証。**

* **キーワード：** `handle tenfold growth`, `Google Workspace`, `smoothly`.
* **正解：** **Cloud Identity と Workspace の連携（Federation）**。
* **ハック：** 既に使っている Workspace を親にして Identity を束ねるのが一番自然。

---

### 💡 このセクションのポイント

「 **Google推奨（Best Practices）** 」では、**「自作（スクリプト・手動）」よりも「マネージド機能（Lifecycle, Auto-scaling, IAM Predefined）」** を選ぶのが王道です。
# ⚡️ Exam 6: ハックリスト (Q1-Q50)

### 🔐 組織統制・IAM (Q1-Q10)

**Q1：少人数の分析チーム。頻繁に入れ替わるメンバーにクエリ権限を効率よく付与。**

* **キーワード：** `frequently changes`, `perform queries`, `Google-recommended`.
* 
**正解：** **Google Group** を作成 ➔ メンバーを追加 ➔ グループに **`BigQuery Job User`** ロールを付与。 


* 
**ハック：** 人が変わるたびに設定するのは非効率。グループ管理がGoogleの鉄板。 



**Q2：組織ポリシー「ドメイン制限共有」がある環境で、外部監査人に閲覧権限を。**

* **キーワード：** `Domain Restricted Sharing`, `external auditor`, `view, but not modify`.
* 
**正解：** **自社ドメイン内に一時アカウントを作成** ➔ そのアカウントに **`Viewer`** ロールを付与。 


* 
**ハック：** 組織ポリシーで「社外アドレスへの共有」が禁止されているなら、社内アカウントを一時的に貸すしかない。 



**Q3：特定のGKEコンテナが大量のログを吐き、コスト爆増。最速で止めたい。**

* **キーワード：** `GKE container generated a large number of logs`, `quickly stop`.
* 
**正解：** **Logs Ingestion 画面** で、対象の **GKE container リソースのログソースを無効化**。 


* 
**ハック：** クラスタごと作り直すのは論外。蛇口（Ingestion）をピンポイントで閉めるのが最速。 



**Q4：App Engine：2%のユーザーだけに新版をテスト。シンプルに。**

* **キーワード：** `App Engine standard`, `test a new version with 2%`, `as simple as possible`.
* 
**正解：** 同じアプリにデプロイし、**`--splits` オプション** で重みを「98:2」にする。 


* 
**ハック：** `migrate`(A)は全部移してしまう。トラフィックの「分割（Splitting）」が正解。 



**Q5：MIGの更新：現在の処理能力（可用性）を下げずにデプロイしたい。**

* **キーワード：** `managed instance group`, `doesn’t affect the current capacity`.
* 
**正解：** **`maxSurge: 1`** ＋ **`maxUnavailable: 0`** でローリングアップデート。 


* 
**ハック：** 「一時的に1台増やしてもいい（Surge）」けど「今の台数は絶対に減らすな（Unavailable: 0）」という指示。 



**Q6：グローバルなソーシャルアプリ。予測不能な成長に対応、管理最小。**

* **キーワード：** `globally distributed`, `unpredictable growth`, `minimal configuration changes`.
* 
**正解：** **Cloud Spanner**。 


* 
**ハック：** Spannerは水平スケール（横に増やす）が得意。Cloud SQL(A)は垂直スケール（箱を大きくする）が限界。 



**Q7：退職した従業員の「機密データアクセス」を2週間分調査したい。**

* **キーワード：** `former employee accessed any sensitive customer data`.
* 
**正解：** **Data Access audit logs** を Cloud Logging で検索。 


* 
**ハック：** Q22(Exam 4)と同じ。中身へのアクセス履歴は `Data Access` ログ。 



**Q8： finance チームだけに「請求先紐付け」をさせたい。開発者には禁止。**

* **キーワード：** `only finance can link projects to billing account`.
* 
**正解：** financeチームに **`Billing Account User`** ＋ **`Project Billing Manager`** ロール。 


* 
**ハック：** PJTを作る権限とは別に、「支払い紐付け」の専用権限を管理部門に集中させる。 



**Q9：別のVPCにいるGCEから、GKEアプリへ内部通信で繋ぎたい。管理最小。**

* **キーワード：** `separate VPC`, `Internal IPs`, `minimal effort`.
* 
**正解：** **Internal Load Balancer** を作成 ➔ **VPC Peering** で繋ぐ。 


* 
**ハック：** ネットを通さず、VPC同士をガッチャンコ(Peering)して内部LBで受けるのが一番楽。 



**Q10：ブートディスクを頻繁にバックアップ、即時復旧、古いのは自動削除。**

* **キーワード：** `backed up frequently`, `restore quickly`, `cleaned up automatically`.
* 
**正解：** **Snapshot Schedule** を作成。 


* 
**ハック：** Q27(Exam 3)等と同じ。MIGのインスタンステンプレート(A)はバックアップではない。 



---

### 💻 運用・高度な管理 (Q11-Q20)

**Q11：全プロジェクトの過去60日分のログを横断分析。Google推奨。**

* **キーワード：** `all logs from their projects`, `past 60 days`, `best practices`.
* 
**正解：** **Logging Export ➔ Sink to BigQuery** ➔ テーブル有効期限を60日に設定。 


* 
**ハック：** 複数PJTの分析(Analytics) ＝ BigQuery への集約。 



**Q12：PJT内の全リソースを大至急削除。ステップ最小。**

* **キーワード：** `shutting down all active services`, `fewest steps`.
* 
**正解：** **Project Owner** 権限で、PJT自体を **Shut Down** する。 


* 
**ハック：** 1つずつ消す(B, D)のは手間。プロジェクトを潰すのが一番速い。 



**Q13：us-central1 のVMから europe-west1 のVMへ内部通信。Google推奨。**

* **キーワード：** `Compute Engine in different regions`, `access application hosted in another`, `best practices`.
* 
**正解：** **同一VPC** 内に新地域の **Subnetwork** を作成。 


* 
**ハック：** VPCは「グローバル」リソース。同一VPCなら、リージョンを跨いでも内部IPで会話できる。 



**Q14：外部監査人に「監査ログ」と「データアクセスログ」を見せたい。**

* **キーワード：** `external auditor`, `examine Audit Logs and Data Access logs`.
* 
**正解：** **`roles/logging.privateLogViewer`** を付与。 


* 
**ハック：** 機密性の高いデータアクセスログを見るには、通常の `viewer` ではなく `privateLogViewer` が必要。 



**Q15：3層アプリ。Tier1 ➔ 2 ➔ 3 の通信だけを許可したい。**

* **キーワード：** `Tier #1 communicate with Tier #2`, `distinct service account`.
* 
**正解：** **Source Service Account** ➔ **Target Service Account** を指定した Ingress ルール。 


* 
**ハック：** Q43(Exam 3)と同じ。IPではなく「サービスアカウント」で縛るのが一番セキュア。 



**Q16：大量の「未構造化データ（動画、画像、文書）」をETL処理したい。**

* **キーワード：** `massive amount of unstructured data`, `ETL transformations`, `Dataflow`.
* 
**正解：** **Cloud Storage** (gsutilでアップ)。 


* 
**ハック：** 未構造化データの「ゴミ箱兼、倉庫」は GCS。BQ(A)は構造化データ用。 



**Q17：複数PJTの管理。CLIでの切り替えを最小ステップに。**

* **キーワード：** `SDK CLI for easy switching`, `fewest steps`.
* 
**正解：** PJTごとに **Configuration** を作成 ➔ **`activate`** で切り替え。 


* 
**ハック：** 毎回 `init` (B, D) し直すのは非効率。プロファイル(Configuration)を使い分ける。 



**Q18：MySQLの月末コピーを3年間保持。監査用。**

* **キーワード：** `retain month-end copy for three years`, `audit purposes`.
* 
**正解：** 月初に **Export** 実行 ➔ **Archive class** の GCS バケットへ保存。 


* 
**ハック：** Cloud SQL標準バックアップ(B, C)は最大1年(365日)しか持たない。3年なら外部(GCS Archive)へ出す。 



**Q19：SAの権限エラー再発を防ぎたい。自動通知が必要。**

* **キーワード：** `Service Account lacks permissions`, `alerted if this issue happens again`.
* 
**正解：** **カスタムの Log-based metric** を作成 ➔ **Alerting Policy** に紐付け。 


* 
**ハック：** 特定の「エラーログ」が出たら通知 ➔ ログベース指標 ＋ アラート。 



**Q20：グローバルeコマース。世界中どこでも「同じデータ」を見せたい。**

* **キーワード：** `global`, `exact same data state`, `relational`, `minimize latency`.
* 
**正解：** **Cloud Spanner**。 


* 
**ハック：** Q6と同じ。「世界規模」＋「強い一貫性（ACID）」＝ Spanner。 



---

### 📦 パフォーマンス・最適化 (Q21-Q30)

**Q21：分析チーム：BQにクエリを投げたいだけ。管理最小。**

* **キーワード：** `run custom SQL queries`, `most recent data in BigQuery`, `Google Group`.
* 
**正解：** **Google Group** に対して **`BigQuery User`** ロールを付与。 


* 
**ハック：** データ閲覧(Viewer)だけでは「クエリ実行」ができない場合がある。クエリするなら `User` ロール。 



**Q22：メモリ内(In-memory)データ。高速アクセス重視。**

* **キーワード：** `dataset in-memory`, `quick access`.
* 
**正解：** **M1 machine type** (Memory-optimized)。 


* 
**ハック：** 「メモリ命」なら Mシリーズ。SSD(C)はあくまでディスクなのでメモリには勝てない。 



**Q23：カスタムIAMロール。 production-ready で、状況をチームに伝えたい。**

* **キーワード：** `production-ready`, `communicate the role’s status`.
* 
**正解：** **'supported'** レベルの権限を使用 ➔ ロールステージを **ALPHA** (またはBETA) に設定。 


* 
**ハック：** 権限自体は安定版(Supported)を使いつつ、ロールの「開発状況」はステージ(Alpha/Beta)で示す。 



**Q24：HTTPSアプリ。不調なVMを「勝手に」交換してほしい。**

* **キーワード：** `unhealthy VMs are automatically identified and replaced`.
* 
**正解：** **Port 443 の Health Check** を作成 ➔ **MIG** に紐付ける。 


* 
**ハック：** 「死んだら作り直す」のトリガーは Health Check。ポートがアプリ(443)と合っていることが重要。 



**Q25：VMごとに違うSAを使わせたい。最も詳細なレベルで。**

* **キーワード：** `each instance uses a specific service account`.
* 
**正解：** **インスタンス作成時** に Service Account を指定。 


* 
**ハック：** メタデータ(B)に名前を書くだけでは権限は付かない。器（VM）を作る時に魂（SA）を入れる。 



**Q26：GKE：画像レンダリング（CPU大/メモリ小）とその他。効率よく。**

* **キーワード：** `CPU大 / Memory小`, `optimized for general-purpose for others`.
* 
**正解：** **Compute-optimized node pool** ＋ **General-purpose node pool**。 


* 
**ハック：** Q31(Exam 2)と同じ。特性の違う仕事は「ノードプール」を分けて最適なマシンを割り振る。 



**Q27：MongoDB をマネージド環境で使いたい。SLAあり。**

* **キーワード：** `MongoDB`, `managed environment`, `SLA`.
* 
**正解：** **MongoDB Atlas** を Google Cloud Marketplace から導入。 


* 
**ハック：** Google純正にMongoDBはない。マーケットプレイスで「餅は餅屋(Atlas)」を呼ぶのが正解。 



**Q28：深夜50分のバッチ。メモリ消費大（最大20GB）。管理最小・安価。**

* **キーワード：** `midnight`, `50 minutes`, `in-memory`, `minimal effort and cost`.
* 
**正解：** **Compute Engine VM** ＋ **Instance Schedule** (自動起動/停止)。 


* 
**ハック：** Cloud Functions(C)は9分制限でNG。Cloud Run(A)もメモリ20GBは厳しい。VMを必要な時間だけ動かすのが一番堅実。 



**Q29：最重要アプリを GKE に。最大信頼性、Google推奨。**

* **キーワード：** `maximum reliability`, `Google-recommended`.
* 
**正解：** **GKE Autopilot** ＋ **Stable release channel**。 


* 
**ハック：** AutopilotはGoogleが管理してくれるので信頼性大。本番(Production)なら最新(Rapid)ではなく「Stable」を選ぶ。 



**Q30：オンプレの DMZ / LAN 環境を GCP で再現したい。**

* **キーワード：** `DMZ (public-facing)`, `LAN (internal-only)`, `communicate with each other`.
* 
**正解：** **単一VPC** ＋ **DMZ用Subnet** ＋ **LAN用Subnet** ＋ **Firewallルール**。 


* 
**ハック：** VPCを分ける(C, D)と通信が面倒になる。1つのVPCの中でサブネットと防火壁（Firewall）で分けるのが定石。 



---

**Q31：Spannerインスタンスを作る前の「絶対」最初の一歩。**

* **キーワード：** `before you can create Cloud Spanner instance`, `what should you do first`.
* 
**正解：** **Cloud Spanner API を有効化**。 


* 
**ハック：** Q20(Exam 1)と同じ。GCPの鉄則：何はともあれ「API Enable」。 



**Q32：VM、Firewall、GCS。設定にあたってのGoogle推奨。**

* **キーワード：** `best practices as you set up the environment`.
* 
**正解：** **必要なサービス（Compute, Storage）のAPIだけ** 個別に有効化。 


* 
**ハック：** 全部入り(A, C)はセキュリティ上よろしくない。「使う分だけ空ける」のがプロ。 



**Q33：Dockerイメージあり。インフラ管理したくない ＋ 自動スケール。**

* **キーワード：** `Docker images`, `avoid managing underlying infrastructure`, `automatically scale`.
* 
**正解：** **Cloud Run**。 


* 
**ハック：** 「インフラ管理嫌い」＋「コンテナ」なら Cloud Run 一択。GKE(B, C)は管理が必要。 



**Q34：注文管理：ゾーン障害でも「即座に」アクセス可能に。ダウンタイムなし。**

* **キーワード：** `accessible immediately in case of a zonal failure`, `preventing any downtime`.
* 
**正解：** **Regional Persistent Disk**。 


* 
**ハック：** スナップショット(A, C)は復旧に時間がかかる。最初から2つのゾーンに書き込む `Regional Disk` が最強の薬。 



**Q35：GKE：高可用・耐障害性 ＋ Google推奨。**

* **キーワード：** `highly available and resilient`, `Google’s recommended practices`.
* 
**正解：** **GKE Autopilot** (Regional by default)。 


* 
**ハック：** 単一ゾーン(Zonal)は死ぬリスクあり。運用をお任せ(Autopilot)して地域分散(Regional)させる。 



**Q36：100TBの大容量データ。最初の1回だけ移行したい。帯域は細い。**

* **キーワード：** `migrate 100 TB`, `initial data migration`, `100 Mbps limit`.
* 
**正解：** **Transfer Appliance**。 


* 
**ハック：** Q49(Exam 3)と同じ。細い回線で 100TB は無理 ➔ トラックで運ぶ物理デバイス(Appliance)。 



**Q37：分析チーム：1日1時間だけ使う。いつでも使える状態 ＋ コスト最小。**

* **キーワード：** `ad hoc SQL queries`, `one hour per day`, `always ready`, `cost-effective`.
* 
**正解：** **BigQuery**。 


* 
**ハック：** サーバーレスの鏡。使ってない時間は 0円、クエリを投げれば即答。 



**Q38：マイクロサービス(Docker)をデプロイ。個別にスケールさせたい。**

* **キーワード：** `each microservice can be scaled independently`.
* 
**正解：** マイクロサービスごとに **Deployment** オブジェクトを作成。 


* 
**ハック：** 1つの Deployment ＝ 1つのスケール単位。個別に増減させたいなら器を分ける。 



**Q39：GKE移行：予算を守りつつコスト管理をしたい。**

* **キーワード：** `keep expenses under control`, `stay within budget`.
* 
**正解：** **GKE Autopilot**。 


* 
**ハック：** 使った分（Pod）だけ課金されるので、空のサーバー（Node）に無駄金を払うリスクが消える。 



**Q40：来期のインフラ予算の見積もり。最速で出したい。**

* **キーワード：** `estimate cloud infrastructure costs`, `time is of the essence`, `quickly as possible`.
* 
**正解：** **Google Cloud Pricing Calculator**。 


* 
**ハック：** Q35(Exam 1)と同じ。計算機を叩くのが公式かつ最速。 



---

**Q41：エンジニアチーム：VM管理のみ。他リソースは禁止。Google推奨。**

* **キーワード：** `managing all Compute Engine instances`, `should not be allowed... other resources`, `best practices`.
* 
**正解：** **`roles/compute.admin`** ＋ **`roles/viewer`**。 


* 
**ハック：** 管理する権限(Admin)と、全体を眺める権限(Viewer)の合わせ技。 



**Q42：Docker化されたマイクロサービス。環境変数を多用。GCPサーバーレスへ。**

* **キーワード：** `microservices running in Docker`, `environment variables`, `serverless`.
* 
**正解：** 既存のイメージを **Cloud Run** へデプロイ。 


* 
**ハック：** Dockerイメージをそのまま食わせるなら Cloud Run。Functions(B, C)はコードをバラす必要があり手間。 



**Q43：PJT-AのウェブVMからPJT-BのBQデータへアクセス。Google推奨。**

* **キーワード：** `VM in project A`, `dataset in project B`, `best practices`.
* 
**正解：** **PJT-B（データ側）** で、**VMのSA** に対して **`bigquery.dataViewer`** を付与。 


* 
**ハック：** Q45(Exam 4)と同じ。「誰に」「何をさせるか」を最小権限で。 



**Q44：VMアプリ。顧客が「3分以上の遅延」を感じたらサポートに通知。管理最小。**

* **キーワード：** `automatically notified`, `latency for at least 3 minutes`, `no additional development costs`.
* 
**正解：** Cloud Monitoring で **Alert Policy** を作成。 


* 
**ハック：** 自作(C)やダッシュボード目視(D)はNG。標準機能のアラートが一番安くて確実。 



**Q45：VM内のアプリログを調査したい。原因を特定したい。**

* **キーワード：** `saves logs to a local disk`, `identify the cause`, `best course of action`.
* 
**正解：** **Ops agent** をインストール ➔ Cloud Logging で見る。 


* 
**ハック：** Q17(Exam 4)と同じ。ローカルディスクのログは Agent がないとクラウドに流れない。 



**Q46：Dev, Test, Prod 環境を効率よく、一貫してデプロイ。Google推奨。**

* **キーワード：** `ensure consistency across environments`, `best practices`.
* 
**正解：** **Cloud Foundation Toolkit (CFT)** ＋ **Terraform**。 


* 
**ハック：** 「一貫性」と言われたら IaC（Terraform）。さらにGoogleのベストプラクティス集(CFT)を使うのがプロ。 



**Q47：ビデオ処理：超高速ディスクアクセス ＋ 障害時のデータ継続性が必要。**

* **キーワード：** `high-speed disk access`, `recover seamlessly`.
* 
**正解：** **Hyperdisk Extreme** ＋ **Stateful Managed Instance Group (MIG)**。 


* 
**ハック：** 爆速なら `Hyperdisk`。データを消さない（再起動しても繋ぎ直す）なら `Stateful` なMIG。 



**Q48：VPC内のVM：固定IP、他サービスとの通信、低コスト、Google推奨。**

* **キーワード：** `fixed IP address`, `seamless communication`, `keep costs low`.
* 
**正解：** **Static Internal IP** (静的内部IP) を予約して割り当てる。 


* 
**ハック：** 外部IP(A, C, D)は「外部との通信用」でお金もかかる。内部IPの固定化が最も安くてセキュア。 



**Q49：eコマース：リソース消費とコストの詳細レポート。効率よく。**

* **キーワード：** `optimize resource consumption`, `detailed report`, `associated costs`.
* 
**正解：** **Labels** (ラベル) を付与 ➔ **BigQuery Export** ➔ **Data Studio**。 


* 
**ハック：** ラベルは「課金分析」の必須タグ。BQとData Studioで可視化するのが最強。 



**Q50：アプリのバグや攻撃による「予想外のコスト爆増」を物理的に防ぎたい。**

* **キーワード：** `unexpected usage... bug or attack`, `avoid sudden billing spikes`.
* 
**正解：** **Quotas (クォータ)** を設定する。 


* 
**ハック：** 予算アラート(A)は「通知」するだけ。物理的に止める（上限を作る）のは `Quotas`。 



---
