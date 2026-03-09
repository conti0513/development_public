# ⚡ Exam 2: ハックリスト v2（Q1–Q50）

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
