# ⚡️ Exam 3: ハックリスト (Q1-Q50)

### 🌐 自動化・パイプライン (Q1-Q10)

**Q1：Deployment Manager変更前の「最速」依存関係チェック**

* **キーワード：** `verify resource dependencies`, `quickest possible validation`.
* **正解：** **`--preview`** フラグを使用して実行。
* **ハック：** 実際にリソースを作らずに「シミュレーション（ドライラン）」してミスを見つける魔法のフラグ。

**Q2：A/CメーカーのIoTパイプライン（1.収集・2.保存・3.分析）**

* **キーワード：** `time-series data`, `Box 1, 2, 3`.
* **正解：** **1. Cloud Dataflow / 2. Cloud Bigtable / 3. BigQuery**.
* **ハック：** IoT/時系列データの王道。Dataflow（流す）➔ Bigtable（貯める）➔ BigQuery（分析）。

**Q3：外部監査人に「アクセスログ」と「BQ」を見せたい**

* **キーワード：** `external auditing`, `view audit logs`, `BigQuery dataset`.
* **正解：** **Auditors Google Group** に対して **`logging.viewer`** と **`bigquery.dataViewer`** を付与。
* **ハック：** 管理負荷最小化のため、個人（C, D）ではなく「Group」に、カスタム（B）ではなく「Predefined（既存）」ロールを付ける。

**Q4：VMからGCSバケットへの書き込み権限（最小権限）**

* **キーワード：** `write sensor data`, `specific Cloud Storage bucket`, `best practices`.
* **正解：** **Dedicated SA** 作成 ➔ バケットに対して **`storage.objectCreator`** を付与。
* **ハック：** 罠：`objectAdmin` (D) は削除もできてしまうので強すぎ。作成(Create)だけなら `objectCreator`。

**Q5：特定の従業員の「写真閲覧・メタデータ変更」履歴を調査**

* **キーワード：** `verify which photos viewed`, `added or modified metadata`, `fewest steps`.
* **正解：** GCP Console で **Activity log** をフィルタリング。
* **ハック：** 「誰が」「何を」したかという操作履歴（Audit）を、専門ツールなしでサクッと見るなら `Activity log`（アクティビティログ）。

**Q6：Googleアカウントなしの業者へ「4時間限定」でデータ共有**

* **キーワード：** `no Google accounts`, `accessible for four hours`, `securely shared`.
* **正解：** **Signed URL** (署名付きURL) を作成。
* **ハック：** アカウントを持たない外の人に、期間限定で鍵を渡す唯一の薬。公開(Public)にするのは絶対にNG。

**Q7：SAが作成された「正確な時間」を知りたい**

* **キーワード：** `confirm when a new service account was created`, `exact creation time`.
* **正解：** **Activity log** ➔ Category: **Configuration** / Resource: **Service Account**.
* **ハック：** リソースの作成・削除（構成変更）は `Configuration` カテゴリ。データの中身を触るのは `Data Access`。

**Q8：GKE全ノードに「監視ポッド」を強制配備**

* **キーワード：** `monitoring pod deployed on each node`, `cluster autoscaler enabled`.
* **正解：** **DaemonSet** オブジェクトとしてデプロイ。
* **ハック：** ノードが増えても減っても「全てのノードに1つずつ居座る」のは DaemonSet の専売特許。

**Q9：IPアドレスが枯渇したゲーム用サブネットの拡張**

* **キーワード：** `out of available IP addresses`, `seamlessly without additional network routes`.
* **正解：** **`gcloud` で subnet の IP range を拡張** (`expand-ip-range`)。
* **ハック：** 作り直し(B)はダウンタイムが出る。今の範囲を「横に広げる」のが正解。

**Q10：WorkSuite (Workspace) ユーザーにPJTへのアクセス権を付与**

* **キーワード：** `WorkSuite accounts`, `grant access to InnovateCloud project`.
* **正解：** ユーザーの **WorkSuiteメールアドレス** に **IAMロール** を付与。
* **ハック：** 既にGoogle系アカウントがあるなら、そのアドレスをそのままIAMに入れるだけ。特別な変換(C)は不要。

---

### 💻 運用・コスト管理 (Q11-Q20)

**Q11：複数PJT（デフォルト/非デフォルト地域）のVM作成**

* **キーワード：** `two separate projects`, `non-default region/zone`, `command line`.
* **正解：** **`gcloud config configurations create`** ➔ **`activate`** で切り替え。
* **ハック：** プロジェクトごとに「プロファイル（Configuration）」を分けると、毎回 region/zone を打たなくて済む。

**Q12：全コンピュートリソースのリストを毎日自動取得**

* **キーワード：** `Production and Development environments`, `automated process`, `retrieve list daily`.
* **正解：** **2つの gcloud config** を作成 ➔ 切り替えながら **`instances list`** を実行するスクリプト。
* **ハック：** Q11と同じ。configを切り替えながらループを回すのが Ops の王道。

**Q13：7TBのAVROファイルをSQLで「最速・安価」に分析したい**

* **キーワード：** `7-TB AVRO file`, `only familiar with SQL`, `cost-efficient`, `as quickly as possible`.
* **正解：** **BigQuery External Tables** (外部テーブル) として参照。
* **ハック：** 罠：BQにロード(B)すると 7TB 分の取り込み時間と費用がかかる。GCSのファイルを「そのまま」SQLで叩くのが最速・最安。

**Q14：開発(Dev)環境から本番(Prod)プロジェクトへの移行**

* **キーワード：** `development environment`, `set up a new project to serve as the production`.
* **正解：** **`gcloud` で新PJT作成 ➔ そこへデプロイ**。
* **ハック：** アプリそのものを「コピー(B)」する機能はない。新しい器（PJT）を作って、そこにデプロイし直す。

**Q15：UDP 636 ポートへのアクセス許可設定**

* **キーワード：** `TLS over port 636 using UDP`, `ensure clients can access`.
* **正解：** **Network Tag** を付与 ➔ **Ingress Firewall Rule** (UDP 636) を作成。
* **ハック：** タグだけ(A)ではダメ。タグ ＋ ファイアウォールルールのセットが薬。

**Q16：複数PJT（共通Billing）のうち、1つだけに予算アラートを設定**

* **キーワード：** `three separate projects`, `single billing account`, `budget alert specifically for one project`.
* **正解：** **Billing Admin** ロールで、**Billing account** を選択し、**Project フィルタ** で作成。
* **ハック：** 予算アラートは「Billing Account（請求先）」の中で、どのプロジェクトを監視するか選べる。

**Q17：公共ネットからの通信を「絶対に」遮断したいVMの作成**

* **キーワード：** `ensure no public Internet traffic is routed to it`.
* **正解：** **Public IP アドレスを無し** で作成。
* **ハック：** 物理的に Public IP がなければ、外からは絶対に繋がらない。

**Q18：インフラ変更案をチームに共有（Google推奨）**

* **キーワード：** `share proposed changes`, `best practices`.
* **正解：** **Deployment Manager テンプレート** ➔ **Cloud Source Repositories** (Git)。
* **ハック：** インフラをコード(IaC)として定義し、バージョン管理(Git)で共有するのがモダンなエンジニア。GCS(A)はバージョン管理が弱い。

**Q19：GKEで一部のチーム（分析）だけ GPU を使いたい。コスト最小。**

* **キーワード：** `Data Analytics team requires GPUs`, `minimizing both effort and costs`.
* **正解：** **GPU専用 Node Pool** を追加 ➔ **`nodeSelector`** を使用。
* **ハック：** クラスタ全体をGPU化(B)するのは超高額。必要な分だけ Node Pool を作る。

**Q20：同僚に「GCSバケットとファイル」の全管理を任せたい**

* **キーワード：** `manage storage buckets and files`, `delegate control`.
* **正解：** **Storage Admin**。
* **ハック：** 「バケットの作成/削除」も含む全権限なら `Storage Admin`。ファイルの中身(Object)だけなら `Object Admin`。

---

### 📦 GKE・スケーリング (Q21-Q30)

**Q21：GKEで「n2-highmem-16」という別スペックのNodeを追加。停止なし。**

* **キーワード：** `n2-highmem-16 nodes`, `without any service downtime`.
* **正解：** **新しい Node Pool** を作成 ➔ Podを順次デプロイ。
* **ハック：** 既存ノードを「アップグレード(A)」してもマシンタイプは変わらない。別のスペックが必要なら「別ノードプール」を足すのが基本。

**Q22：Spanner（最新）と Bigtable（履歴）のデータを「一時的に」結合して分析**

* **キーワード：** `join data from Spanner and Bigtable`, `ad hoc request efficiently`.
* **正解：** **BigQuery External Tables** 経由で SQL を実行。
* **ハック：** 「違うDB同士のデータを今すぐ繋ぎたい」➔ Dataflow(A, B)やDataproc(C)はコードを書く手間大。BQの外部参照で繋ぐのが「秒殺」の薬。

**Q23：96 vCPU 必要なアプリをGCPへ移行。スペック指定。**

* **キーワード：** `requires 96 vCPUs`, `smooth data processing`.
* **正解：** マシンタイプ **`n1-standard-96`** を選択。
* **ハック：** 必要なスペックが分かっているなら、作成時に直接その「型番」を指名するのが最短。

**Q24： us-central1-a のVM。ゾーン1つの障害に耐え、ゼロ停止、低コスト。**

* **キーワード：** `handle failure of a single zone`, `zero downtime`, `minimize costs`.
* **正解：** **us-central1-b にもリソース作成** ➔ 両方に負荷分散。
* **ハック：** 「マルチゾーン」構成。同じリージョン内の別ゾーンにバックアップを置くのが一番コスパが良い。

**Q25：GCS：30日後にアーカイブ。月1回読み取り、たまに更新。**

* **キーワード：** `archived after 30 days`, `accessed once a month`, `updated at end of month`.
* **正解：** **Lifecycle ➔ Nearline Storage**.
* **ハック：** 罠：Coldline(A)は年1回、Archiveは数年に1回レベル。月1回触るなら **Nearline** が取り出しコストを含めて最も安い。

**Q26：誰が「Project Owner」権限を持っているか調査（監査用）**

* **キーワード：** `review individuals... assigned the Project Owner role`.
* **正解：** **`gcloud projects get-iam-policy`** コマンド。
* **ハック：** 今の権限リスト（Policy）をまるごと取得して目視するのが確実。

**Q27：VMのディスクを毎日バックアップ。30日保管。管理最小。**

* **キーワード：** `daily backup`, `retain for 30 days`, `least management overhead`.
* **正解：** **Snapshot Schedule** を設定。
* **ハック：** スクリプト(D)や関数(C)を自作するのは非効率。GCP標準の「スケジュール機能」を使うのが正義。

**Q28：複数PJTのコストを「一画面で」「ほぼリアルタイム」に可視化**

* **キーワード：** `unified visual representation of all costs`, `latest data incorporated quickly`.
* **正解：** **Billing Export to BigQuery** ➔ **Data Studio** (Looker Studio)。
* **ハック：** デフォルトのレポート(D)は1PJTずつ。全PJTを横断・カスタマイズするなら BQ ＋ Data Studio が王道。

**Q29：夜間の巨大バッチ。中断OK、コストを極限まで削る。**

* **キーワード：** `fault-tolerant`, `terminate unexpectedly`, `cost-efficient`.
* **正解：** **Preemptible (Spot) VMs**.
* **ハック：** 「消えてもいいから安くして」＝ Preemptible。最大91%オフ。

**Q30：外部ネット禁止のVMから、自分のGCSにアクセスしたい**

* **キーワード：** `only internal IP`, `not permitted to connect to the internet`, `access Cloud Storage`.
* **正解：** Subnet で **Private Google Access** を有効化。
* **ハック：** 外部IPを持たないVMが、Googleのサービス（GCS, BQ等）にアクセスするための専用トンネル機能。

---

### 🛡 ネットワーク・高度な管理 (Q31-Q50)

**Q31：買収した他社のPJTを自社Orgに移動。請求も自社へ。**

* **キーワード：** `move that project under organization`, `ensure billed to your organization`, `minimal effort`.
* **正解：** **`projects.move`** API使用 ➔ **Billing Account** の更新。
* **ハック：** 作り直し(D)は不要。API一発で「引越し」できる。

**Q32：DNS：root(A.com), www, home を全て LB へ向けたい**

* **キーワード：** `direct traffic from home, root, and www to load balancer`.
* **正解：** **Root ➔ A record**, **subdomains ➔ CNAME record**.
* **ハック：** Rootドメイン（naked domain）には Aレコードが必要。子（www等）は親を指す CNAME にするのが管理しやすい。

**Q33：コスト分析を「自社の財務ルールに合わせて」自動化したい**

* **キーワード：** `tailored to company's financial requirements`, `automated`.
* **正解：** **Billing Export to BigQuery** ➔ **Looker Studio**.
* **ハック：** Q28と同じ。「独自ルール（Tailored）」で分析するなら BigQuery で SQL を書くしかない。

**Q34：サードパーティのPMP（プロジェクト管理ツール）を最速導入**

* **キーワード：** `fast and straightforward way to deploy and install`.
* **正解：** **Cloud Marketplace** から直接デプロイ。
* **ハック：** Q1, Q48と同じ。出来合いのソフトをポチるなら Marketplace。

**Q35：エンジニアが「個人カード」なしでPJTを作れるようにしたい**

* **キーワード：** `create new projects without personal credit card`.
* **正解：** 会社名義の **Billing Account** 作成 ➔ エンジニアに **紐付け権限** 付与。
* **ハック：** 支払い元を中央管理し、利用者に「これ使っていいよ」と許可を出すスタイル。

**Q36：フィットネス機器。毎秒データ、高負荷、原子性、時系列。**

* **キーワード：** `high volume`, `thousands of data points every hour`, `consistent retrieval based on timestamp`, `atomic`.
* **正解：** **Cloud Bigtable** (Row key に timestamp 使用)。
* **ハック：** Q2, Q25と同じ。IoT/センサー/時系列 ＝ Bigtable。

**Q37：CLIで「インスタンス一覧」を見る前に必要な2つの設定**

* **キーワード：** `gcloud compute instances list`, `what must you do first`.
* **正解：** **`gcloud auth login`** (認証) ＋ **`gcloud config set project`** (プロジェクト指定)。
* **ハック：** 「誰が（認証）」「どのプロジェクトを（設定）」の2つがないと、CLIは動けない。

**Q38：CI/CDが権限エラー。どこをチェックすべきか？**

* **キーワード：** `CI/CD system can't perform actions`, `permission problems`.
* **正解：** SAの **IAM Roles** (Project/Folder/Orgレベル) を確認。
* **ハック：** 権限不足 ➔ IAM画面。継承（inherited）されている権限も含めてチェックするのが Ops の基本。

**Q39：K8sマニフェストは使いたいが、インフラ管理はしたくない。**

* **キーワード：** `Kubernetes manifest`, `full control over deployment`, `minimizing infrastructure configuration`.
* **正解：** **GKE Autopilot**.
* **ハック：** アプリ（K8s）の操作感はそのままに、サーバー（Node）の管理をGoogleに丸投げできるモード。

**Q40：Linux VMへの安全かつ「パブリックIP不要」なログイン**

* **キーワード：** `secure and cost-efficient login`, `connecting to these instances`.
* **正解：** **`--tunnel-through-iap`** (Identity-Aware Proxy) を使用。
* **ハック：** ネットに晒さず、Googleの認証を通って裏口から SSH する最強に安全な方法。

---

**Q41：世界規模フィットネス。予測不能なスケールへの対応。**

* **キーワード：** `predictable growth`, `unpredictable size`, `relational`.
* **正解：** **Cloud Spanner**.
* **ハック：** 「世界規模」「一貫性(ACID)」「スケール」＝ Spanner。

**Q42： frontend(VPC A) と backend(VPC B) を通信させたい。同じ組織内。**

* **キーワード：** `establish communication between these projects`, `efficient, cost-effective`.
* **正解：** **VPC Network Peering**.
* **ハック：** 同じ組織のVPCを繋ぐなら、Peering が最も安くて速い（追加インフラ不要）。

**Q43：Firewall：アプリVM ➔ DB VM の通信だけを許可したい。**

* **キーワード：** `only the application servers to communicate with the database servers`.
* **正解：** **Service Account A (source) ➔ Service Account B (target)** の許可。
* **ハック：** IP(C)やタグ(B, D)でもできるが、偽装しにくい「サービスアカウント」で制限するのが最もセキュア。

**Q44：開発チーム。US国内でしかリソースを作らせたくない。**

* **キーワード：** `only create cloud resources within the United States`, `comply with local regulations`.
* **正解：** **Organization Policy** でロケーション制限をかける。
* **ハック：** 「〜を禁止する/制限する」という組織全体のルールは Organization Policy の仕事。

**Q45：GKE Node の IP が枯渇した。**

* **キーワード：** `nodes' available IP addresses are fully utilized`.
* **正解：** **CIDR range の拡張** (`expand-ip-range`)。
* **ハック：** Q9と同じ。既存のサブネットの範囲を広げるのが最短。

**Q46：GCSにファイルが置かれたら Speech-to-Text を動かす。管理最小。**

* **キーワード：** `fully managed, serverless`, `Speech-to-Text API for each file as it arrives`.
* **正解：** **Cloud Functions** (Cloud Storage trigger)。
* **ハック：** 「何かが起きたら、単機能のプログラムを動かす」＝ Functions の教科書通りの使い方。

**Q47：買収した会社のOrgでも、自社のSREが同じ権限を使えるようにしたい。**

* **キーワード：** `same project permissions in the new startup's organization`.
* **正解：** **`gcloud iam roles copy`** で組織を跨いでコピー。
* **ハック：** ゼロから作る(A, B)のは手間。既存の「カスタムロール」をそのままコピーしてインポート。

**Q48：画像などの静的コンテンツを GCS から効率よく配信したい。**

* **キーワード：** `static content (images) stored in Cloud Storage`, `manage and distribute efficiently`.
* **正解：** **HTTP(S) Load Balancer** ＋ **URL map** (GCS backend)。
* **ハック：** LBでリクエストを見て「画像のパスならGCSへ、それ以外はアプリへ」と振り分ける構成。

**Q49：300TBビデオ(オンプレ)、Redshiftデータ、S3ロゴ。移行の最適解。**

* **キーワード：** `300 TB video (SAN)`, `Amazon Redshift`, `S3 bucket`.
* **正解：** **Transfer Appliance** (300TB) ＋ **BQ Data Transfer Service** (Redshift) ＋ **Storage Transfer Service** (S3)。
* **ハック：** TB級のオンプレ ➔ Appliance（物理便）。クラウド間 ➔ STS。BQへ ➔ BQ DTS。

**Q50：Cloud SQL：暗号化接続 ＋ IAM連携 ＋ 管理最小。**

* **キーワード：** `encrypted and authenticated`, `minimize administrative overhead`, `IAM`.
* **正解：** **IAM database authentication** ＋ **Cloud SQL Auth Proxy**.
* **ハック：** ユーザー名/パスワード(A, D)を管理したくないなら IAM 認証 ＋ Proxy（自動トンネル）が薬。

---

### 💡 試験攻略の「一言」

「 ad hoc（一時的）なデータ結合 」と言われたら **BigQuery 外部テーブル** を真っ先に探してください。このパターンを知っているだけで 1〜2 点は確実に拾えます。ｗｗｗ

Exam 3までの150問で、ACE試験のパターンの 60% 以上を網羅したことになります！
