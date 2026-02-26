# ⚡️ Exam 2: ハックリスト (Q1-Q50)

### 🌐 管理・デプロイ (Q1-Q10)

**Q1：Jenkinsサーバーを「最小の手間」で構築**

* **キーワード：** `Jenkins`, `minimal effort`.
* **正解：** **GCP Marketplace** でプリセットを展開。
* **ハック：** 「サードパーティ製の有名ソフト」＋「最小の手間」＝ **Marketplace** が鉄板の薬。

**Q2：Deployment Managerで「ダウンタイムなし」の更新**

* **キーワード：** `Deployment Manager`, `no downtime`, `update configuration`.
* **正解：** **`gcloud deployment-manager deployments update`**。
* **ハック：** `create` は新規作成用。既存のリソースを維持したまま変更を反映するのは `update` コマンド。

**Q3：VMベースのアプリを「CPU使用率」で自動スケール**

* **キーワード：** `must use virtual machines directly`, `scale based on CPU usage`, `quickly as possible`.
* **正解：** **Managed Instance Group (MIG)** + **Autoscaling**.
* **ハック：** VM指定ならGKEはNG。MIG＋インスタンステンプレート＋Autoscalingが標準の薬。

**Q4：VMにデフォルト以外の「カスタムサービスアカウント」を紐付け**

* **キーワード：** `custom service account`, `instead of the default`.
* **正解：** VM作成時の **'Identity and API Access'** セクションで指定。
* **ハック：** 鍵(JSON)をダウンロードしてVM内に置く(D)のはセキュリティ上「毒」とされる。

**Q5：SQL Server搭載VMへの「最短・最速」接続**

* **キーワード：** `SQL Server on Compute Engine`, `simplest and quickest connection`.
* **正解：** **Windowsユーザー/パスワード設定** ➔ **Port 3389開放** ➔ **RDPボタン**。
* **ハック：** Windows VM ＝ RDP (Port 3389)。SSH (Port 22) は Linux 用。

**Q6：別PJTの Artifact Registry からイメージを引く**

* **キーワード：** `separate project`, `Artifact Registry`, `Kubernetes cluster pull images`.
* **正解：** イメージがあるPJTで、**GKEノードのSA** に **Artifact Registry Reader** ロールを付与。
* **ハック：** 「別PJTのリソースを触る」➔「触る側のSA」に「触られる側の権限」を付ける。

**Q7：Windows VM のログイン情報を取得**

* **キーワード：** `Windows virtual machine`, `Remote Desktop (RDP)`, `best approach`.
* **正解：** **`gcloud compute reset-windows-password`**。
* **ハック：** Googleアカウントでそのまま入れる(A)わけではない。コマンドでパスワードを発行/リセットするのが正解。

**Q8：構成ファイルに基づきVMを「自動プロビジョニング」**

* **キーワード：** `provision virtual machines`, `stored in a configuration file`, `best practices`.
* **正解：** **Deployment Manager**。
* **ハック：** 「構成ファイル(YAML/Jinja2)」でインフラを作る ＝ Infrastructure as Code (IaC) ＝ Deployment Manager。

**Q9：App Engineで「1%のユーザー」にだけ新版を公開**

* **キーワード：** `App Engine`, `roll out to just 1%`, `monitor performance`.
* **正解：** **Traffic Splitting** (トラフィック分割)。
* **ハック：** GAEの最強機能。別アプリにする(C)必要はなく、同一サービス内の「バージョン間」で分ける。

**Q10：GCSの自動クラス変更と削除（90日/1年）**

* **キーワード：** `move to Coldline after 90 days`, `delete after one year`.
* **正解：** **Lifecycle Management** (Age 90 ➔ SetStorageClass, Age 365 ➔ Delete)。
* **ハック：** `gsutil` で計算して手動実行(C, D)はNG。Lifecycleルールで「自動化」するのが正解。

---

### 💻 運用・トラブルシューティング (Q11-Q20)

**Q11：DockerfileからGKEへのデプロイ手順**

* **キーワード：** `containerized application`, `Dockerfile`, `Kubernetes Engine`.
* **正解：** **Docker Image作成/Registry登録 ➔ Deployment YAML作成 ➔ kubectl apply**。
* **ハック：** Dockerfileを直接kubectlに投げるコマンド(A)は存在しない。

**Q12：有効化されている全APIのリストを取得**

* **キーワード：** `list of all the enabled Google Cloud Platform APIs`.
* **正解：** **`gcloud services list --enabled`** (または `--project` 指定)。
* **ハック：** `--available` (B, D) は「これから有効化できるもの」も含んでしまうのでNG。

**Q13：部門別・サービス別の「6ヶ月分」の費用分析**

* **キーワード：** `broken down by service type`, `daily and monthly`, `standard query syntax (SQL)`.
* **正解：** **Billing Export to BigQuery** ➔ **SQLクエリ**。
* **ハック：** 「SQL」「大量データ」「分析」＝ BigQuery。Google Sheets(B)は半年分の全PJTデータには耐えられない。

**Q14：GKEフロントエンドをHTTPS/固定IPで外部公開**

* **キーワード：** `GKE`, `expose to the public`, `HTTPS`, `public IP`.
* **正解：** **NodePort Service** ＋ **Ingress** (Cloud Load Balancer経由)。
* **ハック：** HTTPS化 ➔ L7負荷分散が必要 ➔ Ingress が薬。

**Q15：監査人(Auditor)に「全リソース」への閲覧権限**

* **キーワード：** `review all aspects`, `should not have permission to make changes`.
* **正解：** **Predefined IAM Project Viewer** ロール。
* **ハック：** 「全リソース」ならサービスごと(D)やカスタム(A)より、組み込みの `Viewer` が管理負荷最小。

**Q16：既存VMのコピーを大量作成してスケール**

* **キーワード：** `existing VM`, `create and deploy copies`, `scale effectively`.
* **正解：** **Custom Image** を作成 ➔ それからインスタンスを作成。
* **ハック：** スナップショット(B)はバックアップ用。複製（クローン）の「種」にするのは `Image` です。

**Q17：VM内部に保存されたアプリログをCloud Loggingで見たい**

* **キーワード：** `writes detailed logs to the local disk`, `diagnose causes`.
* **正解：** **Cloud Logging Agent** のインストール。
* **ハック：** 標準ではOSのシステムログしか見えない。アプリが独自に吐くログを見るには「Agent」が必須。

**Q18：別PJTのGCSバケットにVMから自動書き込み**

* **キーワード：** `VM in project A`, `Bucket in project B`, `automatically available`, `minimal steps`.
* **正解：** **バケットB** に対して、**VMのSA** に **Storage Object Creator** 権限を付与。
* **ハック：** フォルダをまとめる(A)だけでは権限は付かない。リソースに対して直接SAを許可する。

**Q19：2つの別VPCにいるインスタンス同士を通信させたい**

* **キーワード：** `two separate GCP projects`, `each resides in its own VPC`, `communicate with each other`.
* **正解：** **Shared VPC** (共有VPC) の活用。
* **ハック：** 組織(Organization)に属していることが前提。一箇所に作り直す(A)のはダウンタイム大。

**Q20：GKEのコスト見積もり（高IOPS/バックアップあり）**

* **キーワード：** `Kubernetes cluster`, `high IOPs`, `disk snapshots for backups`.
* **正解：** **Local SSD** ＋ **Persistent Disk** ＋ **Snapshot Storage** を入力。
* **ハック：** 高IOPS ➔ Local SSD、バックアップ ➔ Snapshot。要件をそのまま計算機に反映する。

---

### 📦 ネットワーク・スケーリング (Q21-Q30)

**Q21：GKE Pod が PENDING（保留）状態の調査**

* **キーワード：** `one of the pods is stuck in a PENDING state`, `troubleshoot`.
* **正解：** **`kubectl describe pod`** でイベント/メッセージを確認。
* **ハック：** PENDING ＝ まだ動いていない ➔ ログ(D)は見れない。なぜ動かないか(Describe)を見る。

**Q22：特定VMへのSSHを「特定チーム」だけに許可（管理最小）**

* **キーワード：** `secure SSH access`, `single instance`, `only resource they need`.
* **正解：** **OS Login** 有効化 (`enable-oslogin=true`) ➔ **`compute.osLogin`** ロール付与。
* **ハック：** 個別鍵の配布(C, D)は管理負荷が高い。OS Login＋IAMが「薬」。

**Q23：PJT作成からVM立ち上げまでの一連の手順**

* **キーワード：** `project hasn't been set up yet`, `launch a new VM`.
* **正解：** **PJT作成 ➔ Compute API有効化 ➔ VM作成**。
* **ハック：** APIを有効にしないと、VM作成コマンドはエラーになる。

**Q24：40時間かかるバッチ。中断しても再開可能だが安くしたい**

* **キーワード：** `takes 40 hours`, `can run without user interaction`, `restart if interrupted`, `lowest cost`.
* **正解：** **Compute Engine VM** (手動起動/停止)。
* **ハック：** 罠：Preemptible(Spot)は24時間以内に必ず死ぬ(Q24)。40時間かかるなら、死ぬたびにやり直しで逆に非効率。標準VMを使い、終わったら消すのが正解。

**Q25：ドローンからの大量センサーデータ（タイムスタンプ順、原子性）**

* **キーワード：** `thousands of events every hour`, `consistent data based on timestamp`, `atomic`.
* **正解：** **Cloud Bigtable**。
* **ハック：** 「大量」「時系列(Timestamp)」「低遅延」「原子性」＝ Bigtable が最強。

**Q26：BigQueryクエリ実行前の「コスト見積もり」**

* **キーワード：** `on-demand pricing`, `figure out how much running the query will cost`.
* **正解：** **`--dry-run`** で読み取りバイト数を確認 ➔ 計算機でドル換算。
* **ハック：** 罠：クエリの「戻り値のサイズ(C)」ではなく「読み取ったデータ量(Read bytes)」で課金される。

**Q27：DockerイメージをGKEにデプロイする最小手順**

* **キーワード：** `Docker image`, `deploy as a workload on GKE`.
* **正解：** **Container Registry** にアップ ➔ **Kubernetes Deployment** を作成。
* **ハック：** Service(A, C)は「公開用」。アプリを動かす「器」は Deployment。

**Q28：IAMポリシーが似ているリソースをまとめて管理**

* **キーワード：** `resources with similar access`, `managed together`.
* **正解：** **Folders** (フォルダ) を使ってグループ化。
* **ハック：** フォルダに付与したIAMは、配下のプロジェクトに「継承」されるため一括管理に最適。ラベル(A)に継承機能はない。

**Q29：パブリックIPなしのVMにローカルからSSHしたい**

* **キーワード：** `connect securely via SSH`, `without exposing public IP`.
* **正解：** **Cloud Identity-Aware Proxy (IAP)** の TCP Forwarding を使う。
* **ハック：** 外部IPを持たないサーバーへの「裏口」を作るのが IAP for SSH。

**Q30：複数PJT (A, B, C) のメトリクスを「一画面」で見たい**

* **キーワード：** `unified view`, `track metrics across all three projects`.
* **正解：** Apolloで **Monitoring Workspace** を作成 ➔ LunaとNovaを追加。
* **ハック：** 個別のグラフ共有(A)は非効率。WorkspaceでPJTを束ねるのが正攻法。

---

### 💻 負荷分散・データベース (Q31-Q40)

**Q31：CPU集約型と標準型、混在環境のコスト最適化**

* **キーワード：** `large amount of CPU`, `n1-standard for others`, `resources efficiently`.
* **正解：** **Compute-optimized node pool** ＋ **General-purpose node pool**。
* **ハック：** 1つのノードプールに混ぜると無駄が出る。仕事の内容に合わせて「ノードプール」を分ける。

**Q32：VPCとオンプレ間のVPN（IP指定、無駄なトンネル排除）**

* **キーワード：** `Cloud VPN`, `high availability`, `no extra tunnels during failover`.
* **正解：** **Custom mode VPC** ＋ **Cloud Router (BGP)** ＋ **Active/Passive**.
* **ハック：** 罠：Active/Active(B)は帯域が増えるが、要件の「余分なトンネルを作らない」なら Active/Passive。

**Q33：開発環境のADC認証をそのままVMへ移行（最小変更）**

* **キーワード：** `Application Default Credentials`, `move to VM`, `minimal changes`.
* **正解：** **VMのSA** に必要な権限を付与する。
* **ハック：** ADCは「環境（VMのSA等）」を自動で見に行く。SAにロールを付けるだけで、コード変更は不要。

**Q34：Data Studioの図が表示されないトラブル（BigQuery連携）**

* **キーワード：** `summary table recalculated nightly`, `sales charts stopped displaying`.
* **正解：** **BigQuery インターフェース** で夜間ジョブの履歴を確認。
* **ハック：** 表示エラー ➔ データソース（BQ）が死んでいないか？ をまず疑う。

**Q35：グローバルなe-learning。世界中で「強一貫性」＋「管理最小」**

* **キーワード：** `global`, `consistent performance`, `optimal learning experience`, `strongly available`.
* **正解：** **Cloud Spanner**。
* **ハック：** 「グローバル」「一貫性(Consistent)」「リレーショナル」＝ Spanner。Cloud SQL(A)は世界規模の一貫性は弱い。

**Q36：gcloud CLI ログにプロキシのパスワードを残したくない**

* **キーワード：** `proxy credentials`, `ensure sensitive information remains secure`.
* **正解：** **環境変数** (`CLOUDSDK_PROXY_PASSWORD`) をセットする。
* **ハック：** `config set`(A)で設定すると、平文で設定ファイルに保存されてしまうためNG。

**Q37：GKEで「重要」と「中断OK」なマイクロサービスをコスト安く運用**

* **キーワード：** `recommendation engines (fault-tolerant)`, `order processing (critical)`, `cost-efficient`.
* **正解：** **Standard Node Pool** (重要用) ＋ **Spot VM Node Pool** (中断OK用)。
* **ハック：** 全部Spot(B)は重要サービスが死ぬのでNG。適材適所で使い分ける。

**Q38：Cloud Run の新版を一部のユーザーでテストしたい**

* **キーワード：** `serverless`, `test this new version with a small percentage`.
* **正解：** **Cloud Run Gradual Rollouts** (Traffic Splitting)。
* **ハック：** コンテナ版のGAE traffic splittingと同じ。Cloud Runも「パーセンテージ」で分けられる。

**Q39：セキュリティ担当者にVMの「脆弱性」と「OSメタデータ」を見せたい**

* **キーワード：** `visibility into potential vulnerabilities`, `OS metadata`.
* **正解：** **OS Config agent** 導入 ＋ **`osconfig.vulnerabilityReportViewer`** 権限。
* **ハック：** 罠：Ops Agent(A)はログ/モニタリング用。脆弱性診断は「OS Config」の仕事。

**Q40：Cloud Run デプロイ。リスク最小化 ➔ 顧客負担なし ➔ Google推奨**

* **キーワード：** `minimize customers affected`, `no additional costs`, `Google-recommended`.
* **正解：** **Gradual Rollout** (Traffic Splitting) で徐々に移行。
* **ハック：** 顧客にリトライさせる(A)のは、ユーザー体験が最悪になるためGoogleは推奨しない。

---

### 🛡 応用・DB選択 (Q41-Q50)

**Q41：世界規模フィットネスアプリ。予測不能なスケールへの対応**

* **キーワード：** `relational data`, `users from all over the world`, `unpredictable size`, `scale efficiently`.
* **正解：** **Cloud Spanner**。
* **ハック：** 「世界中」「予測不能なスケール」「リレーショナル」＝ Spanner。Firestore(B)はNoSQLなので要件（Relational）に合わない。

**Q42：Googleアカウントを持っていない外部業者にVMのSSHを許可**

* **キーワード：** `external contractor`, `perform maintenance`, `no Google account`.
* **正解：** 業者の **Public Key** をもらい、VMのメタデータに登録。
* **ハック：** IAP(A)やgcloudコマンド(B)はGoogleアカウントが必須。アカウントなし ➔ 昔ながらの「鍵登録」が唯一の薬。

**Q43：Firewall変更やVM作成を監視。シンプルにやりたい**

* **キーワード：** `unexpected changes to firewall`, `creation of new VMs`, `straightforward`.
* **正解：** **Cloud Logging フィルタ** ➔ **Log-based Metrics** ➔ **Alerting**。
* **ハック：** 独自ツール（Kibanaなど）(C)を入れるのは「シンプル」に反する。GCP標準の通知機能を使う。

**Q44：ポート389のTCP。クライアントの「IPアドレス」を維持して公開**

* **キーワード：** `TCP traffic`, `port 389`, `original IP address preserved`.
* **正解：** **External TCP Network Load Balancer**。
* **ハック：** ネットワークLB（L4）は、中身をいじらずパススルーするのでIPが維持される。Proxy LBはIPが書き換わる。

**Q45：PJT-AのフロントエンドVMからPJT-BのBQへアクセス。最小権限で**

* **キーワード：** `VM in project A`, `Dataset in project B`, `least privilege`.
* **正解：** **バケットB** にて **VMのSA** に **`bigquery.dataViewer`** を付与。
* **ハック：** 罠：Project Owner(A, B)は強すぎる。必要なサービス(BQ)のロールだけ付ける。

**Q46：IPアドレスが枯渇した /25 のサブネットを拡張**

* **キーワード：** `range of 10.18.20.128/25`, `no available private IP`, `minimum steps`.
* **正解：** **`/24` に変更** (10.18.20.0/24)。
* **ハック：** サブネットマスクを小さくする（/25 ➔ /24）＝ 使えるIPが2倍になる。これが「最小の手順」。

**Q47：gcloudコマンドで毎回ゾーン指定するのが面倒**

* **キーワード：** `avoid manually specifying the zone every time`.
* **正解：** **`gcloud config set compute/zone [ZONE_NAME]`**。
* **ハック：** `config set` は CLI 自体の初期設定を固定するコマンド。

**Q48：Jenkinsを「最速」でインストールして使い始めたい**

* **キーワード：** `Jenkins`, `streamline this process`, `quickly and easily`.
* **正解：** **GCP Marketplace**。
* **ハック：** Q1と同じパターン。「とにかく最速でJenkins」なら Marketplace 一択。

**Q49：マーケティング部門のアプリ費用だけ、その部門に請求したい**

* **キーワード：** `ensure Marketing team is billed only for their services`.
* **正解：** 担当者が **Billing Admin** ロールを持ち、PJTを **Marketing Billing Account** に紐付ける。
* **ハック：** ラベル(B)は分析には良いが、請求書を物理的に分けるなら「Billing Account」の指定が必要。

**Q50：世界規模の配車アプリ。SQL分析が必要で、高可用性・スケーラブル**

* **キーワード：** `high volume of rides worldwide`, `SQL queries`, `highly available and scalable`.
* **正解：** **Multi-region Cloud Spanner**。
* **ハック：** 「世界規模(Global)」「SQL」「大規模トランザクション」＝ Spanner。BigQuery(D)は分析用であり、リアルタイムの配車(Transactional)には向かない。

---

### 💡 試験攻略の「薬」まとめ

* **「世界中」＋「SQL」＋「強い一貫性」** ➔ **Spanner**
* **「最小の手間」＋「有名ソフト」** ➔ **Marketplace**
* **「IP維持」＋「L4/TCP」** ➔ **Network Load Balancer**
* **「構成ファイル」＋「インフラ作成」** ➔ **Deployment Manager**
