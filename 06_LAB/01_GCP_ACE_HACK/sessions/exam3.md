# ⚡️ Exam 3: ハックリスト v2 (Q1-Q50)

### 1) ☸️ GKE：構造とスケーリング

- **クラスター vs ノードプール**
  - クラスター：マンション一棟（管理単位）
  - ノードプール：スペックごとのフロア（マシンタイプ別の集合）

- **マシンタイプ変更の定石（ゼロ停止）**
  - 既存ノードを改造しない
  - **新しいスペックのノードプールを追加**
  - **Podを引っ越し（cordon / drain）**して段階移行  
  → これがサービスを止めない正解

- **スケーラビリティ**
  - スケールアップ（垂直）：1台をデカくする（例：`n1-standard-96`）  
    → 移行初期 / DB寄りに効く
  - スケールアウト（水平）：台数を増やす  
    → クラウドの真骨頂

### 2) 💰 コストとストレージの階層（Tiering）

- **GCSクラス境界**
  - **Nearline**：**「30日保持・月1アクセス」** がキーワード
  - 罠：安いクラス（Coldline/Archive）ほど **取り出し料金（毒）** が重い  
    → 月1回触るなら Nearline がトータル最安になりやすい

- **コスト可視化の黄金ルート**
  - 標準画面だけでは弱い
  - **Billing Export → BigQuery → Looker Studio** の3段活用  
  → 組織全体のコストを「一画面」で見る定番

### 3) 🌐 ネットワークと環境分離

- **VPC Peering**
  - 同じ組織内のVPCを繋ぐ最速・最安
  - **Route Tableの手動設定は不要**（SDNが自動でルートを通す）
  - **IP帯の重複は厳禁**

- **環境分離のベストプラクティス**
  - **「プロジェクトを分ける」** がGoogle推奨の基本
  - 理由：IAM / Billing / Quota が **プロジェクト単位で隔離**され、事故が波及しにくい

### 4) 🔑 セキュリティと権限（IAM）

- **Dedicated Service Account（専用SA）**
  - デフォルトSA（Editor残存）使い回しは毒
  - タスク専用SAを作って最小権限を付与
    - 例：GCS書き込みだけ → `storage.objectCreator`（削除不可）

---

## 🌐 自動化・パイプライン (Q1-Q10)

**Q1：Deployment Manager変更前の「最速」依存関係チェック**
- キーワード：`verify resource dependencies`, `quickest possible validation`
- 正解：**`--preview`**
- ハック：リソースを作らずシミュレーションでミスを潰す

**Q2：A/CメーカーのIoTパイプライン（収集→保存→分析）**
- キーワード：`time-series data`, `Box 1, 2, 3`
- 正解：**Dataflow / Bigtable / BigQuery**
- ハック：Dataflow（流す）→ Bigtable（貯める）→ BigQuery（分析）

**Q3：外部監査人に「アクセスログ」と「BQ」を見せたい**
- キーワード：`external auditing`, `view audit logs`, `BigQuery dataset`
- 正解：Groupに **`logging.viewer`** + **`bigquery.dataViewer`**
- ハック：個人よりGroup、CustomよりPredefined

**Q4：VM→GCS書き込み権限（最小権限）**
- キーワード：`write sensor data`, `specific Cloud Storage bucket`, `best practices`
- 正解：Dedicated SA → バケットへ **`storage.objectCreator`**
- ハック：`objectAdmin` は削除できるので強すぎ（毒）

**Q5：従業員の写真閲覧・メタデータ変更履歴**
- キーワード：`verify which photos viewed`, `added or modified metadata`, `fewest steps`
- 正解：Consoleの **Activity log**
- ハック：監査の最短ルート

**Q6：Googleアカウントなし業者へ4時間限定共有**
- キーワード：`no Google accounts`, `accessible for four hours`, `securely shared`
- 正解：**Signed URL**
- ハック：公開はNG。時間制限共有＝署名URL

**Q7：SAが作成された正確な時間**
- キーワード：`exact creation time`
- 正解：Activity log（Configuration / Service Account）
- ハック：作成削除＝Configuration、閲覧＝Data Access

**Q8：GKE全ノードに監視Podを強制配備**
- キーワード：`monitoring pod deployed on each node`, `cluster autoscaler enabled`
- 正解：**DaemonSet**
- ハック：全ノードに1つ＝DaemonSet

**Q9：IP枯渇サブネットの拡張**
- キーワード：`out of available IP addresses`, `without additional network routes`
- 正解：subnet **`expand-ip-range`**
- ハック：作り直しはダウンタイム（毒）。拡張が正解

**Q10：WorkspaceユーザーにPJTアクセス付与**
- キーワード：`WorkSuite accounts`, `grant access`
- 正解：メールアドレスにIAMロール付与
- ハック：そのままIAMに入れるだけ

---

## 💻 運用・コスト管理 (Q11-Q20)

**Q11：複数PJTでVM作成（CLI、地域違い）**
- 正解：`gcloud config configurations create` → `activate`
- ハック：PJTごとにプロファイル分離

**Q12：全コンピュート一覧を毎日自動取得**
- 正解：configを2つ作り切替しつつ `instances list` を回す
- ハック：config切替ループが王道

**Q13：7TB AVROをSQLで最速・安価に分析**
- 正解：**BigQuery External Tables**
- ハック：ロードは時間/コストが毒。外部参照で叩く

**Q14：Dev→Prod移行（新PJT）**
- 正解：新PJT作成 → そこへ再デプロイ
- ハック：コピー機能に逃げない

**Q15：UDP 636 を許可**
- 正解：Network Tag + Ingress Firewall Rule（UDP 636）
- ハック：タグだけでは穴は開かない

**Q16：共通Billingで1PJTだけBudgetアラート**
- 正解：Billing AccountでBudget作成 → Projectフィルタ
- ハック：Budgetは請求側でPJTを絞れる

**Q17：公共ネットから絶対遮断したいVM**
- 正解：Public IPなしで作成
- ハック：物理的に外から来ない

**Q18：インフラ変更案をチーム共有（Google推奨）**
- 正解：Deployment Managerテンプレ → Git（Cloud Source Repos等）
- ハック：IaC + Gitレビューが基本

**Q19：GKEで一部チームだけGPU（コスト最小）**
- 正解：GPU専用Node Pool → `nodeSelector`
- ハック：全体GPU化は毒

**Q20：同僚にGCSを全管理させたい**
- 正解：**Storage Admin**
- ハック：バケット作成/削除込みならAdmin

---

## 📦 GKE・スケーリング (Q21-Q30)

**Q21：別スペックNodeを追加（停止なし）**
- 正解：新Node Pool作成 → Pod段階移行
- ハック：スペック変更は「新プール追加」が定石

**Q22：Spanner（最新）+ Bigtable（履歴）を一時結合して分析**
- 正解：BigQuery（外部参照/連携）でSQL
- ハック：ad hoc結合＝BQで即席

**Q23：96 vCPU必要**
- 正解：`n1-standard-96`
- ハック：型番指定なら迷わない

**Q24：ゾーン障害に耐え、ゼロ停止、低コスト**
- 正解：**同一リージョン内の別ゾーンへ展開** → LBで冗長化
- ハック：マルチゾーンが最小コストのHA

**Q25：GCS：30日後アーカイブ、月1回読取＋更新**
- 正解：Lifecycle → Nearline
- ハック：月1ならNearline（取り出し毒が軽い）

**Q26：誰がProject Ownerか調査**
- 正解：`gcloud projects get-iam-policy`
- ハック：ポリシーを丸ごと取得が確実

**Q27：毎日バックアップ、30日保持、管理最小**
- 正解：Snapshot Schedule
- ハック：標準機能で済ませる

**Q28：複数PJTコストを一画面・ほぼリアルタイム**
- 正解：Billing Export → BigQuery → Looker Studio
- ハック：横断可視化の定番

**Q29：夜間巨大バッチ。中断OK、最安**
- 正解：Spot / Preemptible VM
- ハック：fault-tolerant＝Spot

**Q30：外部ネット禁止VMからGCSアクセス**
- 正解：Private Google Access
- ハック：外に出さずGoogle APIへ

---

## 🛡 ネットワーク・高度な管理 (Q31-Q50)

**Q31：買収PJTを自社Orgへ移動＋請求も自社**
- 正解：`projects.move` + Billing更新
- ハック：作り直しは毒。移動できる

**Q32：DNS：root/www/homeをLBへ**
- 正解：root→A、subdomain→CNAME
- ハック：naked domainはA

**Q33：財務ルールに合わせたコスト分析自動化**
- 正解：Billing Export → BigQuery → Looker Studio
- ハック：tailored＝SQL

**Q34：サードパーティPMPを最速導入**
- 正解：Cloud Marketplace
- ハック：ポチ導入＝Marketplace

**Q35：個人カードなしでPJT作成可能に**
- 正解：会社Billing Account作成＋紐付け権限付与
- ハック：支払い元を中央化

**Q36：時系列・高負荷・原子性**
- 正解：Bigtable
- ハック：IoT/時系列＝Bigtable

**Q37：CLIでinstances list前に必要な2設定**
- 正解：`gcloud auth login` + `gcloud config set project`
- ハック：誰が/どこで を先に決める

**Q38：CI/CD権限エラーの確認先**
- 正解：SAのIAM Roles（Project/Folder/Org + 継承含む）
- ハック：inheritedも見る

**Q39：マニフェストは使うがインフラ管理は最小**
- 正解：GKE Autopilot
- ハック：Node管理を捨てる

**Q40：Public IP不要で安全にSSH**
- 正解：IAP `--tunnel-through-iap`
- ハック：晒さず裏口SSH

**Q41：世界規模・予測不能・relational**
- 正解：Cloud Spanner
- ハック：Global + ACID + Scale＝Spanner

**Q42：VPC A と VPC B を接続（同一組織）**
- 正解：VPC Network Peering
- ハック：追加インフラ不要で最速

**Q43：App→DBだけ許可（よりセキュアに）**
- 正解：SAベース許可（source SA → target SA）
- ハック：IP/タグより偽装耐性が高い

**Q44：US内のみ作成を許可**
- 正解：Organization Policy（ロケーション制限）
- ハック：禁止/制限＝Org Policy

**Q45：GKE Node IP枯渇**
- 正解：CIDR拡張（expand-ip-range等）
- ハック：作り直しより拡張

**Q46：GCS到着でSpeech-to-Text（管理最小）**
- 正解：Cloud Functions（GCSトリガー）
- ハック：イベント駆動の教科書

**Q47：買収先Orgでも同じ権限を使いたい**
- 正解：`gcloud iam roles copy`
- ハック：既存カスタムロールを複製

**Q48：GCS静的コンテンツを効率配信**
- 正解：HTTP(S) Load Balancer + URL map（GCS backend）
- ハック：パスで振り分け

**Q49：300TBオンプレ＋Redshift＋S3ロゴ移行**
- 正解：Transfer Appliance + BQ Data Transfer Service + Storage Transfer Service
- ハック：物理便 / BQ連携 / クラウド間転送

**Q50：Cloud SQL：暗号化＋IAM連携＋管理最小**
- 正解：IAM DB Auth + Cloud SQL Auth Proxy
- ハック：パスワード運用を捨てる

---

## 💡 試験攻略の「一言」

「ad hoc（一時的）なデータ結合」と言われたら **BigQuery** を最優先で探す。  
このパターンだけで 1〜2点拾える。

---
