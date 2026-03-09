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
