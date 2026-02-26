# ⚡️ Exam 1: 瞬殺ハックリスト (Q1-Q50)

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

---