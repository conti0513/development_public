# GCP ACE 模試 Session1

## 間違えた問題の論点整理

### Q13: ログの長期保存

* **【元の文】**: Your organization runs a social media platform that needs to store user activity log files for 3 years. Your platform manages hundreds of Google Cloud projects. You need to implement a cost-effective solution for retaining these log files.
* **【論点抽出】**
* **主体**: 数百プロジェクトのログ
* **目的**: 3年間の長期保持
* **制約**: **Cost-effective（最安）** / 低頻度アクセス


* **【コンセプト】**: 分析不要の長期保存 ➔ GCSの安いクラス。BigQueryは保存コスト高で「毒」。
* **【結論】**: **Log Sink ➔ GCS Coldline**

---

### Q15: Cloud Run と Pub/Sub 連携

* **【元の文】**: You are managing a new microservices-based application... SnapWave... audio clips... processes user activity messages from a Cloud Pub/Sub topic... follow Google's recommended best practices...
* **【論点抽出】**
* **主体**: Pub/Sub ➔ Cloud Run
* **目的**: メッセージ処理
* **制約**: **Best Practices（サーバーレスの作法）**


* **【コンセプト】**: Cloud Runは受動的な「Push」が正義。認証は「合言葉（SA + Invoker）」を添える。
* **【結論】**: **Push Subscription ＋ SA ＋ Invoker Role**


---


### Q17: 特定リソースの費用監視

* **【元の文】**: ...Apache web server that runs on a Compute Engine instance... Apache web server is just one of many applications... want to receive an email notification when the egress network costs for the Apache server exceed $100 for the current month...
* **【論点抽出】**
* **主体**: 特定の VM（Apache）
* **目的**: **Egress（送信）通信費**が $100 超えたら通知
* **制約**: 標準の予算アラート（プロジェクト単位）では粒度が足りない。


* **【コンセプト】**: 「特定の何か」を細かく集計するなら、生データを BigQuery に投げて SQL で叩く。
* **【結論】**: **BQ Export ＋ Cloud Function ＋ Scheduler**


---



### Q25: プロジェクトの完全分離

* **【元の文】**: The content management team has a project named Content Analytics Hub... You need to set up similar Google Cloud resources for the design team, but their resources must be organized independently of the content management team.
* **【論点抽出】**
* **主体**: コンテンツチーム と デザインチーム
* **目的**: リソースのセットアップ
* **制約**: **Organized independently（完全に独立・分離）**


* **【コンセプト】**: 独立＝壁。GCP最大の壁はプロジェクト。同じIDは二度と使えない。
* **【結論】**: **Create Another Project (Unique ID)**


---



### Q40: GKEリソースの最適化

* **【元の文】**: ...deploy a new workload... uncertain about the workload's exact resource needs because they may vary based on different usage patterns... implement a solution that offers cost-effective suggestions for CPU and memory...
* **【論点抽出】**
* **主体**: GKE Workload
* **目的**: CPU/メモリの最適化
* **制約**: **Uncertain about exact needs（需要不明）** / Cost-effective


* **【コンセプト】**: 数（HPA）とサイズ（VPA）の使い分け。需要不明なら VPA の「提案」を聞く。
* **【結論】**: **HPA（可用性） ＋ VPA（サイズ提案）**


---



### Q41: 特定VMへの権限絞り込み

* **【元の文】**: ...manage a third-party photo editing application... other Compute Engine instances... are using default configurations... ensure that the new instance can access these installation files without allowing other virtual machines (VMs) in PixelPro's network to access them.
* **【論点抽出】**
* **主体**: 特定の 1 台の VM
* **目的**: GCS バケットへのアクセス
* **制約**: **Without allowing other VMs（他のVMには絶対見せない）**


* **【コンセプト】**: 合鍵（Default SA）はダメ。専用の身分証（New SA）を作って渡す。
* **【結論】**: **New Service Account ＋ Bucket 権限**


---



### Q43: 頻繁アクセスのストレージ

* **【元の文】**: ...setting up the most cost-efficient storage solution... processes large datasets continuously for critical analytics tasks... accessed regularly by teams based in Boston... ensure minimal storage costs while maintaining optimal access speeds...
* **【論点抽出】**
* **主体**: ボストンのチーム
* **目的**: データセットの継続的分析
* **制約**: **Minimal costs（最安）** / **Optimal access speed（速度）** / 頻繁アクセス


* **【コンセプト】**: ボストン限定なら Regional。毎日使うなら Standard（Nearlineは取り出し料が高い）。
* **【結論】**: **Regional ＋ Standard**


---



### Q46: DBのクラウド移行

* **【元の文】**: ...handles order processing for a single warehouse facility... app runs on PostgreSQL, and you are looking to migrate it to the cloud with minimal changes to the existing codebase.
* **【論点抽出】**
* **主体**: PostgreSQL アプリ
* **目的**: クラウド移行
* **制約**: **Minimal changes to codebase（コード修正なし）** / ACID（整合性）


* **【コンセプト】**: 最短ルートは「同じもの」を選ぶ。PostgreSQL ➔ Cloud SQL (PostgreSQL)。
* **【結論】**: **Cloud SQL (PostgreSQL)**

---


