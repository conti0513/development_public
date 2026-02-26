# ⚡️ Exam 4: 瞬殺ハックリスト (Q1-Q50)

### 🔐 セキュリティ・権限管理 (Q1-Q10)

**Q1：別プロジェクト(PJT-B)のVMスナップショットをPJT-AのSAで行いたい**

* **キーワード：** `service account from project A`, `take snapshots in project B`.
* 
**正解：** **PJT-B** で、**PJT-AのSA** に対して **`Compute Storage Admin`** ロールを付与。 


* **ハック：** 鍵(JSON)を配布するのは「毒」。相手側のプロジェクト（リソースがある場所）で権限を与えるのが正解。

**Q2：3人の開発者にSpannerの「閲覧と修正」権限を付与。管理しやすく。**

* **キーワード：** `view and modify`, `three developers`, `correct permissions`.
* 
**正解：** **Google Group** を作成 ➔ 開発者を追加 ➔ グループに **`roles/spanner.databaseUser`** を付与。 


* **ハック：** 個人(A, C)への直接付与はNG。`viewer` (C, D) は「修正」ができないのでNG。

**Q3：GKEクラスターを常に「サポート対象の安定版」に保つ**

* **キーワード：** `GKE cluster`, `consistent supported and stable version`.
* 
**正解：** **Node Auto-Upgrades** を有効にする。 


* **ハック：** 「自動更新」がキーワード。`Auto-Repair` (A) は「壊れたら直す」だけでバージョン管理ではない。

**Q4：ウェブアプリ(HTTPS)の負荷分散 ＋ SSL終端。Google推奨。**

* **キーワード：** `served over HTTPS`, `properly load-balanced`, `terminate SSL at LB`.
* 
**正解：** **HTTP(S) Load Balancer**。 


* **ハック：** ウェブアプリ(L7)ならこれ一択。SSL Proxy(C)は非HTTP用なので最適ではない。

**Q5：オンプレとGCP間の「プライベートIP」通信。低遅延。**

* **キーワード：** `communicate directly using private IP`, `low-latency`.
* 
**正解：** **Cloud VPN** を設定。 


* **ハック：** ネットを介さない「専用通路」を作る。Peering(B)はVPC同士、Shared VPC(A)は組織内共有用。

**Q6：1000個のBQデータセットから「customer_id」列を持つテーブルを探す**

* **キーワード：** `over 1000 datasets`, `identify column named customer_id`, `minimal manual effort`.
* 
**正解：** **Data Catalog** で検索。 


* **ハック：** 「メタデータ（列名など）の横断検索」＝ Data Catalog。スクリプト(B, C)自作は手間大。

**Q7：GKEデプロイ：1つはRunning、もう1つがPending。原因は？**

* **キーワード：** `one pod is Running`, `second one remains in Pending`.
* 
**正解：** **リソース不足** (Insufficient resources to schedule the pending Pod)。 


* **ハック：** 1つ動いているならイメージ(C)やSA権限は問題ない。2つ目の「席（リソース）」が足りないのが原因。

**Q8：App Engine：us-central1 から asia-northeast1 へ変更したい**

* **キーワード：** `App Engine`, `originally us-central1`, `now asia-northeast1`.
* 
**正解：** **新しい GCP プロジェクト** を作成し、そこで App Engine を作成。 


* **ハック：** 罠：GAEのリージョンは「一度決めたら絶対に変えられない」。プロジェクトごと作り直すのが唯一の薬。

**Q9：ShareSyncアプリ：24時間稼働 ＋ インスタンスは「常に1台」厳守。**

* **キーワード：** `available at all times`, `only one instance active across entire project`.
* 
**正解：** **Autoscaling Off** ＋ **Min 1 / Max 1**。 


* **ハック：** 「絶対に1台」なら勝手に増減するAutoscalingは切る(B)。自動復旧は `autohealing` に任せる。

**Q10：PJT内の「IAMユーザーとロール」の割り当て状況を確認**

* **キーワード：** `verify the IAM users and roles assigned`.
* 
**正解：** GCP Console の **IAM セクション** を確認。 


* **ハック：** `gcloud roles list` (A) は「使えるロールのリスト」だけで、誰に付いているかは見えない。

---

### 💰 請求・コスト・スケーリング (Q11-Q20)

**Q11：新しい Billing Account を作成して既存PJTに紐付けたい**

* **キーワード：** `create a new billing account`, `link it with an existing project`.
* 
**正解：** **Project Billing Manager** 権限を確認 ➔ **新規請求先作成 ➔ PJTにリンク**。 


* **ハック：** 「請求アカウントを作る」には高い権限が必要。

**Q12：BigQuery のコストが爆増。抑えるための2つの有効策。**

* **キーワード：** `costs becoming excessive`, `strategies to control`.
* 
**正解：** **カスタムクエリ割当（Quotas）** 設定 ＋ **Flat-rate（定額制）** への切り替え。 


* **ハック：** 1. 上限を決める（Quotas）、2. 予算を固定する（Flat-rate）。PJTを分ける(A)だけではコストは減らない。

**Q13：信頼できないクライアントコードを実行。GKEでの「最大レベル」の隔離。**

* **キーワード：** `execute arbitrary code`, `maximum level of isolation between pods`.
* 
**正解：** **gVisor** (runtimeClassName: gvisor) を使用。 


* **ハック：** 「怪しいコードを隔離」＝ サンドボックス ＝ **gVisor**。ACEの頻出ワード。

**Q14：Spanner：主キーによる読み取り遅延。スキーマをどう変える？**

* **キーワード：** `read latency issues`, `primarily accessed using primary key`, `monotonically increasing`.
* 
**正解：** 主キーを **連続する値（monotonically increasing）にしない**。 


* **ハック：** IDを「1, 2, 3...」にすると特定のサーバーに負荷が集中（Hotspot）して遅くなる。ランダム(UUID)にするのが薬。

**Q15：経理部門に「請求レポート」だけ見せたい。**

* **キーワード：** `access billing report`, `only billing information`, `no additional permissions`.
* 
**正解：** **`roles/billing.viewer`**。 


* **ハック：** 「見るだけ」なら `viewer`。`user` (A) は「紐付け」ができるので強すぎ。

**Q16：SREに「Googleサポートへのアクセス承認」をさせたい。Google推奨。**

* **キーワード：** `SREs can approve requests from Google support`, `best practices`.
* 
**正解：** **Google Group** を作成 ➔ グループに **`roles/accessapproval.approver`** を付与。 


* **ハック：** 承認（Approve） ➔ `accessapproval` ロール。グループ管理が鉄則。

**Q17：複数PJTのモニタリングを「1つのダッシュボード」に統合**

* **キーワード：** `consolidate monitoring`, `different projects`, `unified dashboard`.
* 
**正解：** **単一の Monitoring account (Workspace)** を作り、全PJTをリンクする。 


* **ハック：** Q30と同じ。Workspace でプロジェクトを束ねるのが薬。

**Q18：VPCからのデータ流出(Egress)を「最小限のポート」で制限**

* **キーワード：** `controlling data leaving VPC (egress)`, `fewest number of open ports`.
* 
**正解：** **優先度低(65534)で全拒否(Deny all)** ＋ **優先度高(1000)で必要ポートのみ許可(Allow)**。 


* **ハック：** 最初に全部閉めて、必要な穴だけ空ける。これがファイアウォールの「鉄則」。

**Q19：GCSにファイルが置かれたら「即座に」画像処理を開始**

* **キーワード：** `automatically process images whenever upload`, `triggered every time`.
* 
**正解：** **Cloud Functions** (Trigger: GCS bucket)。 


* **ハック：** 「イベント駆動（何かが起きたら即動く）」＝ Functions。Scheduler(A)は「時間指定」なのでNG。

**Q20：Spanner の IAM ロールに「いつ誰が追加されたか」の履歴調査**

* **キーワード：** `track when users were added to specific Cloud Spanner IAM roles`.
* 
**正解：** **Stackdriver Logging (Operation Suite)** で **admin activity logs** をフィルタリング。 


* **ハック：** 「権限変更の過去ログ」＝ `Admin Activity Log`。IAM画面(B)には履歴はない。

---

### 📦 運用・高度な構成 (Q21-Q30)

**Q21：IoTデータ：最初の30日は頻繁に、その後3年間は稀にアクセス。コスト最小。**

* **キーワード：** `frequent for 30 days`, `then rarely accessed`, `retained for three years`.
* 
**正解：** **Standard** (30日) ➔ **Archive** (3年)。 


* **ハック：** 罠：最初は頻繁なので Nearline(A) は不適切。3年放置なら最安の Archive へ一気に飛ばす。

**Q22：法令遵守：GCSの「全読み取り操作」を記録しなければならない**

* **キーワード：** `legal regulations`, `every request to read... recorded for auditing`.
* 
**正解：** **Data Access audit logs** を有効にする。 


* **ハック：** デフォルトでは「読み取り(Read)」のログは出ない。`Data Access` ログを明示的にONにする必要がある。

**Q23：10人の開発者。各自のPJTで「月額650ドル」を超えたら自分に通知**

* **キーワード：** `alerted if any of the developers exceed $650`.
* 
**正解：** **各プロジェクトごとに予算(Budget)** とアラートを設定。 


* **ハック：** 1つの予算(A)だと合計額しかわからない。個人別に管理するなら予算設定も10個作る。

**Q24：VM：管理コンソールでの「うっかり削除」を物理的に防ぐ**

* **キーワード：** `ensure no one accidentally deletes`, `mistakenly clicking`.
* 
**正解：** **Delete protection** (削除保護) を有効にする。 


* **ハック：** 削除ボタンを無効化する専用の薬。

**Q25：運用チームに本番PJTの全権限を。将来の製品アプデによる権限拡大を防ぐ。**

* **キーワード：** `access to all services`, `prevent unintended permission escalation`, `best practices`.
* 
**正解：** 必要な権限だけをまとめた **Custom Role** を作成し付与。 


* **ハック：** `Editor` ロール(B)はGoogleが将来追加する権限も自動で付いてしまうため「最小権限」に反する。

**Q26：GCS：単一地域に限定 ＋ 30日後にアーカイブ ＋ 年1回アクセス。**

* **キーワード：** `single geographic region`, `accessible once a year`.
* 
**正解：** **Regional Storage** ➔ **Coldline Storage**。 


* **ハック：** 年1回 ➔ Coldline。数年1回なら Archive。単一地域 ➔ Regional。

**Q27：Googleアカウントを持たないパートナーにLinux VMのメンテを頼む**

* **キーワード：** `maintenance partner who does not use Google Accounts`.
* 
**正解：** 相手の **SSH公開鍵** をVMに登録。 


* **ハック：** IAP(A)やgcloud(B)はGoogleログイン必須。アカウントなし ➔ 昔ながらの鍵登録。

**Q28：Pub/Sub API が無効。SAで認証する前に必要なこと。**

* **キーワード：** `Cloud Pub/Sub API is disabled`.
* 
**正解：** GCP Console の **API Library** で有効化する。 


* **ハック：** Q20と同じ。使う前に必ず「有効化(Enable)」が必要。

**Q29：Cloud Run：最初の1ページ目だけ異常に遅い（コールドスタート）**

* **キーワード：** `initial load time... significantly slower`, `Cloud Run`.
* 
**正解：** **最小インスタンス数 (min-instances)** を3などに設定。 


* **ハック：** サーバーを常に暖めておく（Scale-to-zeroさせない）のが「薬」。

**Q30：数百万のGPSデバイスからの大量データを、高可用に処理・保存したい**

* **キーワード：** `GPS devices`, `streaming structured and unstructured`, `resilient`.
* 
**正解：** **Pub/Sub ➔ Dataflow ➔ Cloud Storage**. 


* **ハック：** 大量流入 ➔ Pub/Sub。リアルタイム処理 ➔ Dataflow。保存 ➔ GCS。鉄板の流れ。

---

**Q31：オンプレの大量動画ファイルを定期的にGCSへ同期したい。自動化。**

* **キーワード：** `gym workout videos`, `automated solution`, `as soon as they are generated`.
* 
**正解：** **`gcloud storage`** コマンド ＋ **Cron job**。 


* **ハック：** ファイル同期なら `gcloud storage`（旧 `gsutil`）。Cron で定期実行するのがシンプル。

**Q32：大量のGCPリソースを「IaC（コード）」で標準化・簡素化したい。**

* **キーワード：** ` standardized way using Infrastructure as Code`, `Deployment Manager`.
* 
**正解：** **Cloud Deployment Manager**。 


* **ハック：** GCP純正の IaC ツール ＝ Deployment Manager。

**Q33：26時間かかる中断不可のバッチ。最低コストで。**

* **キーワード：** `takes about 26 hours`, `if interrupted started from beginning`, `lowest cost`.
* 
**正解：** **Compute Engine VM** (手動で起動/停止)。 


* **ハック：** Q24と同じ。Spot VM(A, C, D)は24時間以内に切れるリスクがある。26時間かかるなら「標準VM」が結局一番安い。

**Q34：MySQL(オンプレ)、Kafka、PostgresをGCPへ。最小管理・グローバル。**

* **キーワード：** `MySQL`, `Kafka`, `PostgreSQL`, `minimal operational management`.
* 
**正解：** **MySQL ➔ Cloud Spanner**, **Kafka ➔ Pub/Sub**, **PostgreSQL ➔ BigQuery**. 


* **ハック：** グローバルスケールを求めるなら、MySQL でも Cloud SQL ではなく **Spanner** を選ぶのが試験の薬。

**Q35：VMのディスクを毎日バックアップ。7日保管。管理最小。**

* **キーワード：** `back up the entire disk daily`, `keep for 7 days`.
* 
**正解：** **Scheduled snapshots** (7日保持)。 


* **ハック：** Q27と同じ。スナップショット・スケジュール機能一択。

**Q36：セキュリティ上「承認された構成」でしかデプロイさせたくない。**

* **キーワード：** `align with these pre-approved configurations`.
* 
**正解：** **Terraform Modules** を作成し、リポジトリで共有。 


* **ハック：** 「型紙（Module）」を配って、それを使わせるのが一番確実な統制。

**Q37：部門ごとにセキュリティ要件が違う。管理しやすくログも分けたい。**

* **キーワード：** `security requirements differ across divisions`, `log sinks`.
* 
**正解：** 部門ごとの **Folder** を作成 ➔ フォルダレベルで **Organization Policy と Log Sink** を設定。 


* **ハック：** プロジェクト単位(B)は手間。組織単位(A)は要件が合わない。フォルダで括るのが正解。

**Q38：マーケットプレイス：30分限定のアップロード ＋ 50日後に自動削除。**

* **キーワード：** `30-minute window`, `delete files over 50 days old`, `low-maintenance`.
* 
**正解：** **Signed URLs** (30分) ＋ **Lifecycle Policy** (50日)。 


* **ハック：** 期間限定アクセス ➔ 署名付きURL。自動削除 ➔ ライフサイクル。

**Q39：ビデオ配信：バックエンド(MIG)を「セキュア・高可用」に公開。**

* **キーワード：** `managed instance group (MIG)`, `secure and highly available`.
* 
**正解：** **HTTP(S) Load Balancer** ＋ **A record** (Public DNS)。 


* **ハック：** 高可用 ➔ LB。外部公開 ➔ Public DNS。

**Q40：社内ドメイン(VirtualMart)以外のユーザーアクセスを禁止したい。**

* **キーワード：** `only matching company's domain`, `avoid manually identifying`.
* 
**正解：** **Organization Policy** でドメイン制限 ＋ **手動で既存の異物を削除**。 


* **ハック：** ポリシーをかけても「今いる人」は消えない。設定 ＋ 掃除のセットが薬。

---

**Q41：複数製品（GCE, Functions, SQL）の権限を「全開発者」に一括適用。**

* **キーワード：** `Compute Engine, Cloud Functions, and Cloud SQL`, `least amount of effort`.
* 
**正解：** **Cloud Identity の Google Group** を作成 ➔ **Custom Role** (3製品分) を作成 ➔ **Orgレベルで付与**。 


* **ハック：** 1つのカスタムロールにまとめ、組織レベルでガツンと当てるのが最速。

**Q42：外部デザイナーに「ディスク一覧」だけ見せたい。最小権限。**

* **キーワード：** `list disk images and snapshots`, `least privilege`.
* 
**正解：** **`compute.disks.list` と `compute.images.list` だけ** 入れた **Custom Role**。 


* **ハック：** 既存の Admin ロール(D)は強すぎる。「List（一覧）」の権限だけに絞る。

**Q43：数百のマイクロサービス。リソース設定のムダ（過剰/不足）を正したい。**

* **キーワード：** `over- or under-provisioned`, `optimal resource limits`.
* 
**正解：** **Vertical Pod Autoscaler (VPA)**。 


* **ハック：** 「Podのサイズ（CPU/メモリ）」を適正化（垂直）するのは VPA。数は HPA。

**Q44：PostgreSQL アプリを最小変更でクラウドへ。ACID一貫性。**

* **キーワード：** `PostgreSQL`, `ACID transactions`, `minimal code modifications`.
* 
**正解：** **Cloud SQL (PostgreSQL)**。 


* **ハック：** 同じ DB エンジンを選ぶのがコード修正最小への近道。

**Q45：BigQuery：「quotaExceeded（制限オーバー）」エラーの調査。**

* **キーワード：** `quotaExceeded error`, `identify cause`.
* 
**正解：** **INFORMATION_SCHEMA** のクエリ ＋ **Cloud Audit Logs** の確認。 


* **ハック：** 「何が起きていたか」のメタデータ(SCHEMA)と、操作記録(Audit)を突き合わせる。

**Q46：ステートレスアプリ。VM上で動かし、予測不能な負荷で自動スケール。**

* **キーワード：** `directly on virtual machines`, `automatically scale`.
* 
**正解：** **Managed Instance Group (MIG)** ＋ **Autoscaling**。 


* **ハック：** VM指定 ➔ MIG。コンテナ指定なら GKE や Cloud Run です。

**Q47：ステートレスアプリ。内部IPのみ ＋ 1日何度も更新 ＋ 管理最小。**

* **キーワード：** `internal IP only`, `updated several times throughout the day`, `simple`.
* 
**正解：** **Cloud Run** ＋ **Private Service Connect (PSC)**。 


* **ハック：** サーバーレスの王様 Cloud Run。内部通信に絞るなら PSC が最強の薬。

**Q48：カスタムVPC：/20 サブネットの IP が足りなくなった。**

* **キーワード：** `running out of internal IP`, `10.0.1.0/20`.
* 
**正解：** サブネットの範囲を **`/18` へ広げる**。 


* **ハック：** 以前の問題(Q46)と同じ。マスクを小さくして枠を広げる。

**Q49：Cloud Logging のログを「SQL」で分析したい。Google推奨。**

* **キーワード：** `use SQL to analyze logs`, `Google-recommended`.
* 
**正解：** **Log Analytics** を有効にし、**BigQuery リンク** を作成。 


* **ハック：** ログエクスポート(D)もできるが、今の「推奨（推薦）」はボタン一つでBQと繋がる Log Analytics。

**Q50：Cloud Run ➔ Cloud SQL：高負荷時に API クォータエラーが出る。**

* **キーワード：** `Cloud SQL API quota errors`, `reached maximum allowed API quota`.
* 
**正解：** **最大インスタンス数 (max-instances)** を減らして制限する。 


* **ハック：** インスタンスが増えすぎる ＝ DB接続が増えすぎる。上限（Max）を抑えてクォータを守る。

---

### 💡 試験攻略の「急所」

「 **Google推奨（Best Practices）** 」と聞かれたら、**「マネージドサービス（Googleが面倒見てくれるもの）」** か **「グループ管理（IAMを個人に付けない）」** を選ぶと 8割正解します。ｗｗｗ
