# ⚡️ Exam 6: ハックリスト (Q1-Q50)

### 🔐 組織統制・IAM (Q1-Q10)

**Q1：少人数の分析チーム。頻繁に入れ替わるメンバーにクエリ権限を効率よく付与。**

* **キーワード：** `frequently changes`, `perform queries`, `Google-recommended`
* **正解：** **Google Group** を作成 ➔ メンバーを追加 ➔ グループに **BigQuery の権限（例：`roles/bigquery.jobUser`）** を付与
* **ハック：** 人が変わるたびに個別付与は非効率。グループ運用が鉄板。

※補足：データ閲覧が必要なら `roles/bigquery.dataViewer` も併用。

---

**Q2：組織ポリシー「ドメイン制限共有」がある環境で、外部監査人に閲覧権限を。**

* **キーワード：** `Domain Restricted Sharing`, `external auditor`, `view, but not modify`
* **正解：** **自社ドメイン内に一時アカウントを作成** ➔ そのアカウントに **Viewer**（必要最小）を付与
* **ハック：** 組織ポリシーで社外共有が禁止なら、社内アカウントの一時発行が現実解。

---

**Q3：特定のGKEコンテナが大量のログを吐き、コスト爆増。最速で止めたい。**

* **キーワード：** `GKE container generated a large number of logs`, `quickly stop`
* **正解：** Cloud Logging で **該当ログを除外する Exclusion（除外フィルタ）** を作成して **取り込みを止める**
* **ハック：** クラスタ作り直しは論外。**ログの蛇口（取り込み）を閉める**のが最速。

※注意：画面表記は環境で差があるが、概念は「除外（Exclusions）で取り込み停止」。

---

**Q4：App Engine：2%のユーザーだけに新版をテスト。シンプルに。**

* **キーワード：** `App Engine standard`, `test a new version with 2%`, `as simple as possible`
* **正解：** 同じアプリにデプロイし、**Traffic Splitting**（例：`--splits`）で「98:2」にする
* **ハック：** `migrate` は全移行。正解は「分割」。

---

**Q5：MIGの更新：現在の処理能力（可用性）を下げずにデプロイしたい。**

* **キーワード：** `managed instance group`, `doesn’t affect the current capacity`
* **正解：** ローリング更新で **`maxSurge: 1`** ＋ **`maxUnavailable: 0`**
* **ハック：** 「一時的に増やす（Surge）」OK、「減らす（Unavailable）」NG。

---

**Q6：グローバルなソーシャルアプリ。予測不能な成長に対応、管理最小。**

* **キーワード：** `globally distributed`, `unpredictable growth`, `minimal configuration changes`
* **正解：** **Cloud Spanner**
* **ハック：** 水平スケール前提なら Spanner。

---

**Q7：退職した従業員の「機密データアクセス」を2週間分調査したい。**

* **キーワード：** `former employee accessed any sensitive customer data`
* **正解：** Cloud Logging で **Data Access audit logs** を検索
* **ハック：** “中身へのアクセス”は Data Access。

---

**Q8：finance チームだけに「請求先紐付け」をさせたい。開発者には禁止。**

* **キーワード：** `only finance can link projects to billing account`
* **正解：** finance チームに **`Billing Account User`**（必要に応じて）＋ **`Project Billing Manager`**
* **ハック：** 「支払い紐付け」だけを分離して付与。

---

**Q9：別のVPCにいるGCEから、GKEアプリへ内部通信で繋ぎたい。管理最小。**

* **キーワード：** `separate VPC`, `Internal IPs`, `minimal effort`
* **正解：** **Internal Load Balancer** を作成 ➔ **VPC Peering**（必要に応じて）
* **ハック：** 内部LB＋Peeringが最短ルート。

---

**Q10：ブートディスクを頻繁にバックアップ、即時復旧、古いのは自動削除。**

* **キーワード：** `backed up frequently`, `restore quickly`, `cleaned up automatically`
* **正解：** **Snapshot Schedule**
* **ハック：** 目的が「定期スナップショット」ならこれ一択。

---

### 💻 運用・高度な管理 (Q11-Q20)

**Q11：全プロジェクトの過去60日分のログを横断分析。Google推奨。**

* **キーワード：** `all logs from their projects`, `past 60 days`, `best practices`
* **正解：** **Logging Export（Sink）→ BigQuery** ➔ テーブル有効期限を 60 日
* **ハック：** 横断分析＝BQ集約。

---

**Q12：PJT内の全リソースを大至急削除。ステップ最小。**

* **キーワード：** `shutting down all active services`, `fewest steps`
* **正解：** **プロジェクトを Shut down（削除）**
* **ハック：** 1つずつ消すより、プロジェクトごと落とす。

---

**Q13：us-central1 のVMから europe-west1 のVMへ内部通信。Google推奨。**

* **キーワード：** `Compute Engine in different regions`, `best practices`
* **正解：** **同一VPC** に新リージョンの **サブネット** を追加
* **ハック：** VPCはグローバル。

---

**Q14：外部監査人に「監査ログ」と「データアクセスログ」を見せたい。**

* **キーワード：** `external auditor`, `examine Audit Logs and Data Access logs`
* **正解：** **`roles/logging.privateLogViewer`**
* **ハック：** Data Access は PrivateLogViewer が必要になりやすい。

---

**Q15：3層アプリ。Tier1 ➔ 2 ➔ 3 の通信だけを許可したい。**

* **キーワード：** `Tier #1 communicate with Tier #2`, `distinct service account`
* **正解：** Firewall で **Source SA → Target SA** を指定（Ingress）
* **ハック：** IPよりSAで縛る。

---

**Q16：大量の未構造化データ（動画/画像/文書）をETL処理したい。**

* **キーワード：** `massive amount of unstructured data`, `ETL`, `Dataflow`
* **正解：** **Cloud Storage** に格納（ETLの入力置き場）
* **ハック：** 未構造化の置き場＝GCS。BQは構造化向け。

---

**Q17：複数PJTの管理。CLIでの切り替えを最小ステップに。**

* **キーワード：** `SDK CLI for easy switching`, `fewest steps`
* **正解：** gcloud の **Configuration** を作成 ➔ **activate** で切り替え
* **ハック：** `init` 再実行は無駄。プロファイル運用。

---

**Q18：MySQLの月末コピーを3年間保持。監査用。**

* **キーワード：** `retain month-end copy for three years`, `audit purposes`
* **正解：** 定期 **Export** ➔ **GCS Archive** に保存
* **ハック：** Cloud SQL の標準バックアップだけでは要件不足になりがち。長期はGCSへ。

---

**Q19：SAの権限エラー再発を防ぎたい。自動通知が必要。**

* **キーワード：** `Service Account lacks permissions`, `alerted if this issue happens again`
* **正解：** **Log-based metric** ➔ **Alerting Policy**
* **ハック：** “特定ログが出たら通知”の王道。

---

**Q20：グローバルeコマース。世界中どこでも「同じデータ」を見せたい。**

* **キーワード：** `global`, `exact same data state`, `relational`, `minimize latency`
* **正解：** **Cloud Spanner**
* **ハック：** グローバル＋強整合＝Spanner。

---

### 📦 パフォーマンス・最適化 (Q21-Q30)

**Q21：分析チーム：BQにクエリを投げたいだけ。管理最小。**

* **キーワード：** `run custom SQL queries`, `most recent data in BigQuery`, `Google Group`
* **正解：** **Google Group** に **`roles/bigquery.jobUser`**（＋必要なら `dataViewer`）
* **ハック：** “クエリ実行”は jobUser が効く。

---

**Q22：メモリ内(In-memory)データ。高速アクセス重視。**

* **キーワード：** `dataset in-memory`, `quick access`
* **正解：** **メモリ最適化 VM**（例：M系）
* **ハック：** SSDはディスク。メモリ要件ならメモリ最適化。

---

**Q23：カスタムIAMロール。production-ready で、状況をチームに伝えたい。**

* **キーワード：** `production-ready`, `communicate the role’s status`
* **正解：** ロールに入れる権限は **GA（supported/一般提供）相当**を使い、ロールの **stage は ALPHA/BETA/GA** で示す
* **ハック：** “権限の安定度”と“ロールの成熟度”を分けて表現。

※ここ、元文だと「supported なのに stage を ALPHA」が混ざって見えるので、意図が伝わるように整理。

---

**Q24：HTTPSアプリ。不調なVMを「勝手に」交換してほしい。**

* **キーワード：** `unhealthy VMs are automatically identified and replaced`
* **正解：** **Health Check（443）** ➔ **MIG** に紐付け
* **ハック：** “交換”の起点は Health Check。

---

**Q25：VMごとに違うSAを使わせたい。最も詳細なレベルで。**

* **キーワード：** `each instance uses a specific service account`
* **正解：** **インスタンス作成時** に SA を指定
* **ハック：** メタデータでは権限にならない。

---

**Q26：GKE：画像レンダリング（CPU大/メモリ小）とその他。効率よく。**

* **キーワード：** `CPU大 / Memory小`, `general-purpose`
* **正解：** **Compute-optimized node pool** ＋ **General-purpose node pool**
* **ハック：** 特性が違う仕事は NodePool を分ける。

---

**Q27：MongoDB をマネージド環境で使いたい。SLAあり。**

* **キーワード：** `MongoDB`, `managed environment`, `SLA`
* **正解：** **MongoDB Atlas**（Marketplace）
* **ハック：** GCP純正にMongoDBはない。

---

**Q28：深夜50分のバッチ。メモリ消費大（最大20GB）。管理最小・安価。**

* **キーワード：** `midnight`, `50 minutes`, `in-memory`, `minimal effort and cost`
* **正解：** **Compute Engine VM** ＋（必要なら）**スケジューリングで起動/停止**
* **ハック：** 時間が決まってるならVMを必要時間だけ動かす。

---

**Q29：最重要アプリを GKE に。最大信頼性、Google推奨。**

* **キーワード：** `maximum reliability`, `Google-recommended`
* **正解：** **GKE Autopilot** ＋ **Stable release channel**
* **ハック：** 本番は Rapid ではなく Stable。

---

**Q30：オンプレの DMZ / LAN 環境を GCP で再現したい。**

* **キーワード：** `DMZ`, `LAN`, `communicate with each other`
* **正解：** **単一VPC** ＋ **DMZ用Subnet** ＋ **LAN用Subnet** ＋ **Firewall**
* **ハック：** VPCを分けると通信が面倒。1VPC内で分離が定石。

---

### （続き）Q31-Q40

**Q31：Spannerインスタンスを作る前の「絶対」最初の一歩。**

* **キーワード：** `before you can create Cloud Spanner instance`, `what should you do first`
* **正解：** **Cloud Spanner API を有効化**
* **ハック：** まず API Enable。

---

**Q32：VM、Firewall、GCS。設定にあたってのGoogle推奨。**

* **キーワード：** `best practices as you set up the environment`
* **正解：** **必要なサービス（Compute/Storage等）のAPIのみ** 個別に有効化
* **ハック：** 全部入りは避ける。使う分だけ有効化。

---

**Q33：Dockerイメージあり。インフラ管理したくない ＋ 自動スケール。**

* **キーワード：** `Docker images`, `avoid managing underlying infrastructure`, `automatically scale`
* **正解：** **Cloud Run**
* **ハック：** コンテナ＋運用最小＝Cloud Run。

---

**Q34：注文管理：ゾーン障害でも「即座に」アクセス可能に。ダウンタイムなし。**

* **キーワード：** `accessible immediately in case of a zonal failure`, `preventing any downtime`
* **正解：** **Regional Persistent Disk**
* **ハック：** スナップショット復旧は“即座”ではない。

---

**Q35：GKE：高可用・耐障害性 ＋ Google推奨。**

* **キーワード：** `highly available and resilient`, `Google’s recommended practices`
* **正解：** **GKE Autopilot（Regional）**
* **ハック：** Zonalはリスク。

---

**Q36：100TBの大容量データ。最初の1回だけ移行したい。帯域は細い。**

* **キーワード：** `migrate 100 TB`, `initial data migration`, `100 Mbps limit`
* **正解：** **Transfer Appliance**
* **ハック：** 回線が細いなら物理搬送。

---

**Q37：分析チーム：1日1時間だけ使う。いつでも使える状態 ＋ コスト最小。**

* **キーワード：** `ad hoc SQL queries`, `one hour per day`, `always ready`, `cost-effective`
* **正解：** **BigQuery**
* **ハック：** サーバーレス＝待機コストを避けやすい。

---

**Q38：マイクロサービス(Docker)をデプロイ。個別にスケールさせたい。**

* **キーワード：** `each microservice can be scaled independently`
* **正解：** マイクロサービスごとに **Deployment** を分ける
* **ハック：** Deployment がスケール単位。

---

**Q39：GKE移行：予算を守りつつコスト管理をしたい。**

* **キーワード：** `keep expenses under control`, `stay within budget`
* **正解：** **GKE Autopilot**
* **ハック：** ノードのムダ課金を減らしやすい。

---

**Q40：来期のインフラ予算の見積もり。最速で出したい。**

* **キーワード：** `estimate cloud infrastructure costs`, `time is of the essence`, `quickly as possible`
* **正解：** **Google Cloud Pricing Calculator**
* **ハック：** 最速は公式計算機。

---

### （続き）Q41-Q50

**Q41：エンジニアチーム：VM管理のみ。他リソースは禁止。Google推奨。**

* **キーワード：** `managing all Compute Engine instances`, `should not be allowed... other resources`, `best practices`
* **正解：** **`roles/compute.admin`**（必要に応じて）＋ **`roles/viewer`**
* **ハック：** 管理権限＋参照権限の合わせ技。

---

**Q42：Docker化されたマイクロサービス。環境変数を多用。GCPサーバーレスへ。**

* **キーワード：** `microservices running in Docker`, `environment variables`, `serverless`
* **正解：** **Cloud Run**
* **ハック：** 既存イメージをそのまま。

---

**Q43：PJT-AのウェブVMからPJT-BのBQデータへアクセス。Google推奨。**

* **キーワード：** `VM in project A`, `dataset in project B`, `best practices`
* **正解：** **PJT-B（データ側）** で、**VMのSA** に **`roles/bigquery.dataViewer`** 等を付与
* **ハック：** データ側で最小権限。

---

**Q44：VMアプリ。顧客が「3分以上の遅延」を感じたらサポートに通知。管理最小。**

* **キーワード：** `automatically notified`, `latency for at least 3 minutes`, `no additional development costs`
* **正解：** Cloud Monitoring の **Alert Policy**
* **ハック：** 自作より標準アラート。

---

**Q45：VM内のアプリログを調査したい。原因を特定したい。**

* **キーワード：** `saves logs to a local disk`, `identify the cause`, `best course of action`
* **正解：** **Ops Agent** を導入 ➔ Cloud Logging へ送る
* **ハック：** ローカルは放置すると見えない。

---

**Q46：Dev/Test/Prod を効率よく、一貫してデプロイ。Google推奨。**

* **キーワード：** `ensure consistency across environments`, `best practices`
* **正解：** **Terraform**（＋必要なら CFT）
* **ハック：** “一貫性”＝IaC。

---

**Q47：ビデオ処理：超高速ディスクアクセス ＋ 障害時のデータ継続性が必要。**

* **キーワード：** `high-speed disk access`, `recover seamlessly`
* **正解：** **Hyperdisk（高性能）** ＋ **Stateful MIG**
* **ハック：** “速い”＋“消えない”の組み合わせ。

---

**Q48：VPC内のVM：固定IP、他サービスとの通信、低コスト、Google推奨。**

* **キーワード：** `fixed IP address`, `seamless communication`, `keep costs low`
* **正解：** **Static Internal IP** を予約して割り当て
* **ハック：** 外部IPは不要・コスト/露出増。

---

**Q49：eコマース：リソース消費とコストの詳細レポート。効率よく。**

* **キーワード：** `optimize resource consumption`, `detailed report`, `associated costs`
* **正解：** **Labels** を付与 ➔ **Billing Export to BigQuery** ➔（可視化は Looker Studio）
* **ハック：** “コスト詳細レポート”は **Billing Export** が王道。

※元文の「BigQuery Export」は “Logging export” と混ざるので、ここは **Billing export** に寄せて安全化。

---

**Q50：バグ/攻撃による予想外のコスト爆増を物理的に防ぎたい。**

* **キーワード：** `unexpected usage... bug or attack`, `avoid sudden billing spikes`
* **正解：** **Quotas（クォータ）** を設定
* **ハック：** 予算アラートは通知だけ。止めるのはクォータ。

---
