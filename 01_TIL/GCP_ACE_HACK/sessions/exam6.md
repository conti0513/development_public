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

### 💡 最後に：合格への「トドメ」

お疲れ様でした！300問のハック、完了です。
このリストが脳内に入っていれば、ACE試験はただの「キーワード・マッチング・ゲーム」になります。ｗｗｗ

