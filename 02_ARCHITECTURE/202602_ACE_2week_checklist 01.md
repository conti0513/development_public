# ⚡️ ACE試験：1-50問 瞬殺ハックリスト（完全版・詳細粒度）

### Q1-Q10：ネットワークと初期設定

**Q1：オンプレからGCSアクセス（ネット禁止）**

* **毒：** `prohibit public IP`, `restrict internet access`, `on-premises`.
* **薬：** **restricted.googleapis.com** へのCNAME設定とルート広報。
* **ハック：** Googleのサービス（GCS等）に「ネットを通らず」オンプレから繋ぐための専用窓口が `restricted` です。

**Q2：VMへのSSH（個人を特定・追跡）**

* **毒：** `administrative access`, `tracked to individual team members`.
* **薬：** **OS Login** (`compute.osAdminLogin`) ロールの付与。
* **ハック：** 共有の秘密鍵を配るのは誰が操作したか不明になるためNG。GoogleアカウントとSSHを紐付ける `OS Login` が正解。

**Q3：個人カード払いのプロジェクトを統合**

* **毒：** `personal credit cards`, `consolidating all projects`, `single billing account`.
* **薬：** **新しい Billing Account** を作成し、全プロジェクトに紐付ける。
* **ハック：** 支払い元を一本化するには「新しい請求アカウント」が必要です。Resource Managerでの移動は組織整理であり、支払い設定とは別物です。

**Q4：CPU不要 / 32GBメモリ / コスト最小**

* **毒：** `almost no CPU`, `30 GB in-memory cache`, `lowest costs`.
* **薬：** **Custom Machine Type**（CPUを最小、メモリを32GBに指定）。
* **ハック：** `n1-standard` 等のプリセットはCPUとメモリが比例して増えるため、メモリだけ欲しい場合は「カスタム」が一番安上がりです。

**Q5：非アクティブなK8s設定を確認**

* **毒：** `Kubernetes cluster configuration`, `inactive environments`, `minimal steps`.
* **薬：** **`kubectl config use-context`** ➔ **`kubectl config view`**。
* **ハック：** 複数のK8s環境がある場合、まず「操作対象（Context）」を切り替えないと中身は見えません。

**Q6：大至急（明日まで）に請求を統合**

* **毒：** `consolidate all GCP costs`, `single invoice`, `as of tomorrow`.
* **薬：** **Link TutorVerse's projects** to Learnly's billing account.
* **ハック：** 組織(Organization)の移行には数日かかることがありますが、プロジェクトを「請求先だけ変える」のは数秒で終わります。

**Q7：画像が置かれたら自動処理（最速）**

* **毒：** `upload images`, `convert images`, `most efficient/cost-effective`.
* **薬：** **GCS ➔ Cloud Functions** 連携。
* **ハック：** ファイルアップロードを検知してプログラムを動かす「イベント駆動」の王道構成です。

**Q8：他PJTのIAMロールをそのまま使いたい**

* **毒：** `same IAM roles to your production project`, `fewest possible steps`.
* **薬：** **`gcloud iam roles copy`** コマンド。
* **ハック：** 手動でポチポチ作る（C, D）のは非効率。コマンド一発で「コピー」するのが最短です。

**Q9：サブネットの最大IPレンジ**

* **毒：** `custom VPC`, `largest possible IP address range`, `future scaling`.
* **薬：** **10.0.0.0/8**。
* **ハック：** プライベートIPの規格（RFC 1918）で最も広いのが `/8`（約1600万アドレス）です。

**Q10：DMからK8s操作（DaemonSet等）**

* **毒：** `Deployment Manager`, `DaemonSet`, `simplest way`.
* **薬：** **Type Provider** を使ってK8s APIをDMに追加。
* **ハック：** Deployment Manager（インフラ管理）で「K8sの中身（アプリ）」まで管理したい時は `Type Provider` という拡張機能を使います。

---

### Q11-Q20：コンピューティングと運用

**Q11：コンテナ / ユーザー極少 / コスト最小**

* **毒：** `container image`, `very few daily users`, `cost-efficient`.
* **薬：** **Cloud Run**。
* **ハック：** リクエストがない時はインスタンスが「0」になり、課金も「0円」になるため、低トラフィックに最強です。

**Q12：ログをSQLで詳細分析したい**

* **毒：** `collect logs`, `further analysis`, `cost efficiency`.
* **薬：** **BigQuery への Sink**（エクスポート）。
* **ハック：** 「分析(Analysis)」「SQL」という言葉が出たら、ログの送り先は BigQuery 一択です。

**Q13：ログを3年間保管（激安）**

* **毒：** `store activity log files for 3 years`, `cost-effective`.
* **薬：** **Coldline Storage** への Sink（エクスポート）。
* **ハック：** 「3年」などの長期保管で、分析もしないなら GCS の安いクラス（Coldline/Archive）が最適です。

**Q14：災害復旧（DR）用バックアップ**

* **毒：** `disaster recovery`, `long-term backup retention`, `best practices`.
* **薬：** **Coldline Storage**。
* **ハック：** 災害（めったに起きない）＝ アクセス頻度が極めて低い ➔ Coldline です。

**Q15：Pub/Sub ➔ Cloud Run 連携**

* **毒：** `Cloud Run`, `processes messages from Cloud Pub/Sub`, `best practices`.
* **薬：** **Push Subscription** + **Cloud Run Invoker** ロール。
* **ハック：** サーバーレスなCloud Runは、メッセージを自分から取りに行く（Pull）のではなく、投げてもらう（Push）のが定石です。

**Q16：指定された内部IP（10.194...）を固定**

* **毒：** `specific IP address 10.194.3.41`, `proprietary software hard-coded`.
* **薬：** **Static Internal IP** を `gcloud` で予約して割り当てる。
* **ハック：** アプリが「このIPじゃないと動かない」とわがままを言うなら、予約（Static）して固定するしかありません。

**Q17：特定アプリ（Apache等）の費用のみ監視**

* **毒：** `egress network costs for the Apache server`, `not for entire project`.
* **薬：** **Billing Export + BigQuery**。
* **ハック：** 予算アラートは「プロジェクト単位」まで。特定のVMだけの費用を見たいなら BigQuery で詳細クエリが必要です。

**Q18：VMが死んだら自動再生成（Autohealing）**

* **毒：** `unresponsive`, `automatically re-created`, `minimum number of steps`.
* **薬：** **Managed Instance Group (MIG)** + **Autohealing Health Check**。
* **ハック：** 「死んだら作り直す」は MIG の基本機能です。LB（A, B）は「送らない」だけで「作り直し」はしません。

**Q19：GKEインフラ（Node）を自動拡張**

* **毒：** `GKE cluster`, `scale automatically`, `minimize manual configuration`.
* **薬：** **Autoscaling enabled on the node pool**（Cluster Autoscaler）。
* **ハック：** HPA(A)やVPA(B)は「中身のPod」を増やすだけ。インフラ自体（Node）を増やすのは Cluster Autoscaler です。

**Q20：CLIでVM作成の絶対前提**

* **毒：** `Compute Engine instance using the CLI`, `prerequisite steps`.
* **薬：** **`compute.googleapis.com` API の有効化**。
* **ハック：** GCPのプロジェクトは、各サービスのAPIを「有効化」しないとコマンドが受け付けられません。

---

### Q21-Q30：スケーリングとデータベース

**Q21：App Engineで「予備」を常に待機**

* **毒：** `App Engine`, `4 unoccupied instances ready at all times`, `sudden increases`.
* **薬：** **Automatic Scaling** + **`min_idle_instances`**。
* **ハック：** 急なスパイクに備えて「暇な（Idle）」インスタンスをキープするのが `min_idle_instances` です。

**Q22：30日経った画像を安く（消さない）**

* **毒：** `older than 30 days`, `minimize costs`, `automatically managing`.
* **薬：** **Lifecycle Management** で **Archive Storage** へ移動。
* **ハック：** 削除ではなく「安く維持」したいなら、Archive クラスへの自動移行が最適です。

**Q23：DBのポイントインタイムリカバリ(PITR)**

* **毒：** `Cloud SQL (MySQL)`, `point-in-time recovery`, `accidental deletions`.
* **薬：** **Binary Logging** の有効化。
* **ハック：** 「特定の瞬間（10時5分）に戻したい」と言われたら、MySQLでは Binary Logging が必須キーワードです。

**Q24：Cassandra を最速導入**

* **毒：** `Cassandra`, `isolated development environment`, `minimize overhead`.
* **薬：** **Cloud Marketplace** でプリセット画像を使用。
* **ハック：** サードパーティ製ソフトを「手早く、確実に」用意したいなら Marketplace が最短です。

**Q25：他チームと独立した環境で作りたい**

* **毒：** `organized independently`, `separate resources`.
* **薬：** **新しい Project を作成**。
* **ハック：** GCPにおける「独立・分離」の最小単位はプロジェクトです。IAM（権限）で分けるのは管理が混ざるためNG。

**Q26：CPU 90%超えで通知**

* **毒：** `CPU usage exceeds 90%`, `notified`.
* **薬：** **Cloud Monitoring Alerting Policy**。
* **ハック：** 標準機能を使いましょう。独自スクリプト(A)やログ抽出(D)は手間がかかりすぎます。

**Q27：監視チームにDBの中身は見せない**

* **毒：** `monitor the app's environment`, `should not be able to access any review details`.
* **薬：** **`roles/monitoring.viewer`** の付与。
* **ハック：** 「中身を見る」権限（databaseReader）を避け、インフラ状態だけ見る `monitoring` ロールが正解。

**Q28：Spannerの自動拡張（CPUベース）**

* **毒：** `Spanner nodes automatically scales`, `CPU exceeds threshold`.
* **薬：** **Monitoring Alert ➔ Webhook ➔ Cloud Function** でリサイズ。
* **ハック：** 実はSpanner自体には自動スケール機能がないため、Functionsを介して自前でAPIを叩いてリサイズさせるのが正解です。

**Q29：Googleアカウントの競合**

* **毒：** `personal Google accounts overlap`, `avoid potential account conflicts`.
* **薬：** **転送（Transfer）** を招待。
* **ハック：** 「削除しろ」は横暴すぎ。会社管理下に「移ってもらう（Transfer）」のがベストプラクティス。

**Q30：他PJTのBQデータを「読みたい」**

* **毒：** `BigQuery dataset in a separate project`, `be able to read the data`.
* **薬：** **`roles/bigquery.dataViewer`** ロール。
* **ハック：** Job User(A)は「クエリを実行する権利」だけで、データの中身（テーブル）を見るには `dataViewer` が必要です。

---

### Q31-Q40：開発と管理

**Q31：オンプレアプリのAPI認証**

* **毒：** `on-premises application`, `authenticate and connect to GCP APIs`.
* **薬：** **`gcloud` で Service Account Key (JSON)** を作成。
* **ハック：** オンプレ（外の世界）からアクセスするには、鍵（JSONファイル）を持っていく必要があります。

**Q32：Serverless移行（Dashboard/API/Batch）**

* **毒：** `minimize operational expenses`, `serverless architecture`.
* **薬：** **App Engine** (Dashboard) / **Cloud Run** (API) / **Cloud Tasks** (Batch)。
* **ハック：** バッチ処理をVM(GCE)でやると、立ち上げっぱなしでコストがかかるため非効率です。

**Q33：GKEノード管理最小＋ネット遮断**

* **毒：** `GKE cluster`, `not be accessible from public internet`, `minimize operational overhead`.
* **薬：** **Private Autopilot Cluster**。
* **ハック：** 管理最小 ➔ Autopilot。ネット遮断 ➔ Private。これがGKEの最強防御形態です。

**Q34：Spannerクエリ性能を最短改善**

* **毒：** `shortest possible time`, `enhance query performance`.
* **薬：** **CPU 65%アラート ➔ Node追加**。
* **ハック：** クエリを書き直す(B, D)のは時間がかかります。一番手っ取り早い（Shortest time）のは、サーバーを増やす（Scale up）ことです。

**Q35：月額費用の見積もり（公式）**

* **毒：** `estimate the monthly cost`, `accurate estimate`.
* **薬：** **Google Cloud Pricing Calculator**。
* **ハック：** 自分で計算したり(B)、1週間動かして予想する(C)のは非効率かつ不正確です。

**Q36：5年保存 / 5世代管理 / 1年で安く**

* **毒：** `retained for 5 years`, `up to five versions`, `older than one year... lower-cost tier`.
* **薬：** **Versioning** (世代管理) ＋ **Lifecycle** (安く移行)。
* **ハック：** Cloud Storageの標準機能を組み合わせるのが最も運用コストが低いです。

**Q37：既存SubnetのIPアドレスが枯渇**

* **毒：** `IP address exhaustion`, `minimizing complexity`.
* **薬：** **`expand-ip-range`** コマンド。
* **ハック：** VPCを作り直すのは大仕事です。既存のサブネットの「マスク（/25 ➔ /24など）」を広げるのが最短です。

**Q38：CLIのデフォルトGKE設定**

* **毒：** `CLI to always target this GKE cluster by default`.
* **薬：** **`gcloud config set container/cluster`**。
* **ハック：** `gcloud config set` は「今後ずっとこの設定でいくぞ」という意思表示です。

**Q39：SSDで読込スロットリング（最大性能）**

* **毒：** `excessive disk read throttling`, `maximum amount of throughput`.
* **薬：** **Local SSD**。
* **ハック：** ネットワーク経由のSSD（Persistent Disk）には限界があります。物理的に直結されている `Local SSD` が最速です。

**Q40：リソース不明なWorkloadのコスト提案**

* **毒：** `uncertain about resource needs`, `cost-effective suggestions`.
* **薬：** **VPA (Vertical Pod Autoscaler)** を推薦モードで使用。
* **ハック：** 提案(Suggestions)と言われたら、リソースの適正サイズを教えてくれる VPA の出番です。

---

### Q41-Q50：上級管理と負荷分散

**Q41：特定のVMだけGCSにアクセス**

* **毒：** `new instance can access`, `without allowing other virtual machines`.
* **薬：** **専用 Service Account** を作成して付与。
* **ハック：** デフォルトSA(A)を使うと、同じSAを使っている他のVMまで権限が漏れてしまいます。

**Q42：インフラ構成の総コスト見積もり**

* **毒：** `estimate the total cost`, `three-tier social media platform`.
* **薬：** **Pricing Calculator**。
* **ハック：** オンプレと同スペックのVMやCloud SQLを Calculator に入れるのが定石です。

**Q43：地域限定 / 頻繁アクセス / 低コスト**

* **毒：** `processed regularly`, `teams based in Boston`, `minimal storage costs`.
* **薬：** **Regional + Standard**。
* **ハック：** 毎日触るなら Nearline(A, C) は取り出し手数料で高くなります。一箇所から触るなら Regional で十分。

**Q44：数%のユーザーにだけ新版をテスト**

* **毒：** `test new features with a small portion of live traffic`.
* **薬：** **App Engine Traffic Splitting**。
* **ハック：** App Engineの「Traffic Splitting（トラフィック分割）」は、新バージョンに数%だけ割り振るための専用機能です。

**Q45：Bigtableの全操作を監査**

* **毒：** `log all read and write operations`, `PII`, `send to SIEM`.
* **薬：** **Audit Logs (Data Read/Write)** を有効化し、Pub/Sub 経由で飛ばす。
* **ハック：** 個人情報（PII）の操作を追うなら、標準のログではなく `Audit Logs`（監査ログ）を明示的にONにする必要があります。

**Q46：PostgreSQLを「最小変更」で移行**

* **毒：** `runs on PostgreSQL`, `minimal changes to existing codebase`.
* **薬：** **Cloud SQL (PostgreSQL)**。
* **ハック：** 同じエンジン（Postgres）ならコードを書き直さなくて済みます。Spanner(C)はコード修正が必要です。

**Q47：別の環境（dev等）のNode状態を確認**

* **毒：** `view the nodes from the prod-environment`, `verify for the dev-environment`.
* **薬：** **`gcloud container clusters get-credentials`**。
* **ハック：** K8sは「今どこのクラスターを操作してるか」の資格情報を取得（Switch）しないと、別の環境は見えません。

**Q48：SAキー寿命制限（24時間）＋集中管理**

* **毒：** `keys are valid for only one day`, `centralized project`.
* **薬：** **Organization Policy** で制約をかける。
* **ハック：** 個別の設定ではなく、組織全体でルール（Policy）として縛るのが「管理負荷最小」です。

**Q49：CI/CDパイプラインの安全な権限**

* **毒：** `CI/CD pipeline`, `correct permissions`, `security best practices`.
* **薬：** **複数 SA + Secret Manager**。
* **ハック：** パイプラインごとに専用SAを作り、最小権限を与える。鍵は Secret Manager で管理する。これが鉄板の安全性です。

**Q50：SSL/TCP 443（non-HTTP）＋全世界**

* **毒：** `SSL-encrypted TCP traffic`, `port 443`, `various regions`.
* **薬：** **SSL Proxy Load Balancer**。
* **ハック：** ポート443だが「HTTP/HTTPS（L7）」ではなく「TCP（L4）」なら、SSL Proxy LB の出番です。

---

### 📚 ACE試験：日本人が苦手な重要英単語 30選

| No | 英単語 | クラウド・ITでの意味 | 覚え方のコツ・文脈 |
| --- | --- | --- | --- |
| **1** | **Adhere to** | 〜を遵守する、従う | 「Googleの定石通りにやる」という合図。 |
| **2** | **Prerequisite** | 前提条件 | 「これをする前に、あれが必要」という時に出る。 |
| **3** | **Retain / Retention** | 保持する / 保管期間 | データの保存期間（Lifecycle）の話で必須。 |
| **4** | **Provision** | 準備する、配備する | サーバーを立てる、リソースを確保すること。 |
| **5** | **Ephemeral** | 一時的な、儚い | 消えてしまうIPアドレスやディスクのこと。 |
| **6** | **Incur** | （費用が）発生する | 「追加費用がかかる」＝ `incur extra costs`。 |
| **7** | **Egress / Ingress** | 下り（送出）/ 上り（流入） | 通信費用の計算や、Firewallで頻出。 |
| **8** | **Exhaustion** | 枯渇（こかつ） | IPアドレスが足りなくなる状況。 |
| **9** | **Compliant** | 準拠している | 法規制やルールを守っている状態。 |
| **10** | **Overhead** | 負荷、余分な手間 | 「管理の手間（Operational Overhead）」を減らしたい。 |
| **11** | **Proprietary** | 独自の、社外秘の | 自社開発のソフト。Marketplaceに対する対義語。 |
| **12** | **Unresponsive** | 応答がない | サーバーが死んでいる（Autohealing）の文脈。 |
| **13** | **Constraint** | 制約（せいやく） | Org Policyなどで「禁止・制限」するルール。 |
| **14** | **Consolidate** | 統合する、まとめる | 請求書やプロジェクトを一つにまとめる時。 |
| **15** | **Substantial** | かなりの、大幅な | 費用の「大幅な」削減などの強調表現。 |
| **16** | **Disruption** | 中断、停止 | サービスが止まること。`minimal disruption`（最小の停止）。 |
| **17** | **Audit / Auditor** | 監査 / 監査人 | ログを見せる相手。Conditionで期間を縛る対象。 |
| **18** | **Accidental** | 誤った、不注意な | `Accidental deletion`（うっかり削除）対策の話。 |
| **19** | **Retrieve** | 取り出す、検索する | ストレージからデータを取り出す際の手数料。 |
| **20** | **Consistent** | 一貫性のある | DBのデータがズレていないこと。Spannerの強み。 |
| **21** | **Durable** | 耐久性のある | データが消えないこと。ストレージの信頼性。 |
| **22** | **Unoccupied** | 空いている、暇な | 待機中のインスタンス（Idle）を指す。 |
| **23** | **Enforce** | 強制する、適用する | 組織ポリシーを無理やり全プロジェクトにかける。 |
| **24** | **Expire / Expiry** | 期限が切れる / 有効期限 | IAMキーや一時権限の寿命。 |
| **25** | **Isolated** | 孤立した、分離された | 他のチームと混ざらない独立した環境。 |
| **26** | **Grant** | 付与する、与える | 権限（Role）を与える。`Assign` とほぼ同義。 |
| **27** | **Execute** | 実行する | コマンドを叩く。`Run` のフォーマルな表現。 |
| **28** | **Mitigate** | 軽減する、緩和する | セキュリティリスクやコストを抑える。 |
| **29** | **Preempt / Preemptible** | 横取りする / 中断可能な | 安いけどGoogleに横取りされるVM（Spot VM）。 |
| **30** | **Granular** | きめ細かい、粒度の細かい | 権限を細かく設定すること。 |

---

### 💡 単語を覚えるためのハック

問題文の中で **`Minimal steps`** や **`Cost-effective`** と並んで、これらが「毒（課題）」として出てきます。

特に **`Ephemeral`（一時的）** と **`Provision`（準備）** は、クラウドエンジニアが日常的に使う「カタカナ語」としても有名なので、この機会にマスターしておくと実務でも役立ちます！ｗｗｗ
