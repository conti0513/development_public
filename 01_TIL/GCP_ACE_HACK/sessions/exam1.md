# ⚡️ Exam 1: ハックリスト (Q1-Q10)

## 🌐 ネットワーク・接続

### 🌐 Q1：オンプレからGCSアクセス（インターネット禁止・非公開でGoogle APIsへ）

* キーワード: `on-premises`, `no public IP`, `restrict internet access`, `Google Cloud APIs`
* 正解（薬）:

  * **DNS を `restricted.googleapis.com` に向ける**（CNAME/Private DNS）
  * **VIP `199.36.153.4/30` への経路を Cloud Router(BGP) でオンプレへ広報**
* ハック（裏口の作り方）:
  インターネット（公道）ではなく、**VPN/Interconnect（地下通路） + DNS書き換え + 専用VIP**で Google APIs に入る。

#### ✅ AA（最小構成イメージ）

```
[On-Prem DNS]  storage.googleapis.com
      |        (CNAME -> restricted.googleapis.com)
      v
[On-Prem App] -----> (VPN / Interconnect) -----> [VPC]
                           |                       |
                           |                  [Cloud Router]
                           |                 (BGP advertise)
                           |                       |
                           +---- route to 199.36.153.4/30 ----+
                                                             |
                                                [restricted.googleapis.com VIP]
                                                             |
                                                           [GCS]
```

#### 🧠 なぜこれか（試験で刺さる理由）

1. DNS（名前の書き換え）

* `storage.googleapis.com` をそのまま引くと、通常は公開経路に寄りがち。
* そこで **`*.googleapis.com` を `restricted.googleapis.com` に向ける**（CNAME/Private DNS）ことで、API宛先を「制限付き」側へ寄せる。

2. VIP（199.36.153.4/30）

* `restricted.googleapis.com` の **VIP レンジが `199.36.153.4/30`**。このIP帯へ「社内から行ける」ようにするのがコア。

3. 経路広報（Cloud Router / BGP）

* オンプレ側に「`199.36.153.4/30` は VPN/Interconnect へ流せ」を教えるために、**Cloud Router で BGP 広報**する。

#### 🛡️ 類似ワードの整理（混同ポイント）

| 用語                          | どこから叩く？ | 典型要件                                          |
| --------------------------- | ------- | --------------------------------------------- |
| Private Google Access (PGA) | VPC内VM  | サブネットで PGA を有効化、など                            |
| PGA for on-premises         | オンプレ    | VPN/Interconnect + DNS + VIP(199.36.153.4/30) |

* 毒になりやすい選択肢（典型）

  * Squid等のプロキシを新設
  * ILBで無理やり中継
    → **要件が「Google推奨・管理最小」なら外しやすい**

#### 💡 2周目用 反射メモ（1行）

> オンプレから非公開Google APIs = **restricted.googleapis.com + 199.36.153.4/30 + Cloud Router(BGP)**

---

### 🧠 Q2：VMへのSSH（個別追跡・効率管理）

* キーワード: `administrative access`, `tracked to individual`, `manage efficiently`
* 正解（薬）: **OS Login**（例: `compute.osAdminLogin`）
* ハック:

  * 共有鍵は「誰が入ったか」追えない → 毒
  * OS Login は **IAM（Googleアカウント）でSSH制御**でき、退職・異動に強い

#### 2周目用メモ

> SSHをスマートに = **OS Login**

---

### 🧠 Q3：支払い元の一本化（Billing Consolidation）

* キーワード: `personal credit cards`, `consolidating`, `single billing account`
* 正解（薬）: **新しい Billing Account を作成**し、各プロジェクトを紐付け
* ハック:

  * Project（箱）と Billing（財布）は別
  * 「組織配下へ移動」だけで請求は切り替わらない（管理構造の話）

#### 2周目用メモ

> 支払い一本化 = **新しいBilling Account作成 → 既存PJTを付け替え**

---

### 🧠 Q4：低CPU / 高メモリ / コスト最小（in-memory cache）

* キーワード: `almost no CPU`, `30 GB in-memory cache`, `lowest costs`
* 正解（薬）: **Custom machine type**（CPU最小 + メモリ32GB級）
* ハック:

  * Standard はCPU:メモリ比が固定 → メモリ目的だとCPU過剰でコスト増
  * “in-memory” は **RAM**。SSD（ディスク）増設は筋違いになりやすい

#### 2周目用メモ

> いびつな要求（メモリ偏重）= **Custom machine**

---

### 🧠 Q5：K8sクラスター設定の確認（詳細 vs 一覧）

* キーワード: `Kubernetes cluster configuration`, `inactive environments`, `minimal steps`
* 正解（薬）:

  * `kubectl config use-context <ctx>`
  * `kubectl config view`
* ハック:

  * `get-contexts` は「一覧」寄り（名前と現在地）
  * “configuration をチェック” は **中身(view)** を求めていることが多い

#### 2周目用メモ

> K8sの設定を見たい = **kubectl config view**

---

### 🧠 Q6：M&Aで請求一本化（明日まで・爆速）

* キーワード: `consolidate all costs`, `single invoice`, `as of tomorrow`
* 正解（薬）: **買収先プロジェクトを自社の Billing Account に付け替え**
* ハック:

  * 組織(Organization)移行は重い（IAM/ポリシー再設計が発生しやすい）
  * “明日まで” があるなら、財布（Billing）を先に揃える

#### 2周目用メモ

> 期限が短い一本化 = **Billing付け替え**

---

### 🧠 Q7：画像アップロード → 自動変換（イベント駆動）

* キーワード: `upload images`, `processed by converting`, `most efficient and cost-effective`
* 正解（薬）: **Cloud Storage → Cloud Functions（GCSイベントで起動）**
* ハック:

  * 画像/動画/PDF は **GCS**
  * 「置かれたら動く」= Functions の定番

#### 2周目用メモ

> ファイル置いたら処理 = **GCS + Functions**

---

### 🧠 Q8：カスタムロールの複製（Dev → Prod、最小ステップ）

* キーワード: `launching production`, `apply the same IAM roles`, `fewest possible steps`
* 正解（薬）: **`gcloud iam roles copy`**（コピー先をProd Project）
* ハック:

  * 手作業で作り直しはミス源＆最小ステップではない
  * 組織レベルへコピーは影響範囲が広がりやすく、最小権限と衝突しがち

#### 2周目用メモ

> カスタムロール複製 = **gcloud iam roles copy**

---

### 🧠 Q9：VPC設計（単一サブネットで最大レンジ）

* キーワード: `custom VPC`, `single subnet`, `largest possible IP address range`, `future scaling`
* 正解（薬）: **`10.0.0.0/8`**
* ハック:

  * CIDRは **/の数字が小さいほど大きい**
  * `/32` はIP1個（サブネットとしてはほぼ使い物にならない）

#### 実務注意（試験と現場の差）

* 試験: “最大”なら `/8` が素直
* 実務: Peering/統合で **アドレス重複**が毒になり得るので、設計思想次第

#### 2周目用メモ

> 最大レンジ = **/8**

---

### 🧠 Q10：GKEリソース（DaemonSet）を Deployment Manager で展開（最小サービス）

* キーワード: `GKE cluster`, `DaemonSet`, `fewest services`, `Deployment Manager`
* 正解（薬）: **Type Provider で K8s API を登録し、Deployment Manager から DaemonSet を作る**
* ハック:

  * Deployment Manager は基本 GCP リソース向け
  * **Type Provider** を使うと、外部/別API（K8s API含む）を “型” として扱える ([Google Cloud Documentation][1])
* 毒になりやすい選択肢

  * Runtime Configurator: 変数/同期用途で、K8sマニフェスト適用の本道ではない
  * `kubectl` を叩くためだけのVM維持: “fewest services” に反しがち

#### 現場メモ（重要）

* Deployment Manager は **2026-03-31 でサポート終了**が明記されているため、実務では Infrastructure Manager / Terraform 等へ寄せる前提で考えるのが安全。 ([Google Cloud Documentation][1])

#### 2周目用メモ

> DMでK8s操作 = **Type Provider**

---




### 💻 サーバーレス・Compute (Q11-Q20)

**Q11：コンテナ / ユーザー極少 / コスト最小**

* **キーワード：** `container image`, `very few daily users`, `cost-efficient`.
* **正解：** **Cloud Run**。
* **ハック：** リクエストがない時は「0円」になる。Scale-to-zeroが低トラフィックに最強。

**Q12：ログをSQLで詳細分析したい**

* **キーワード：** `collect logs`, `further analysis`, `cost efficiency`.
* **正解：** **BigQuery への Sink**（エクスポート）。
* **ハック：** 「分析(Analysis)」「SQL」が出たら、ログの送り先は BigQuery。

**Q13：ログを3年間保管（激安）**

* **キーワード：** `store log files for 3 years`, `cost-effective`.
* **正解：** **Coldline Storage** への Sink。
* **ハック：** 「3年」などの長期保管で、分析もしないなら GCS の安いクラス（Coldline）が最適。

**Q14：災害復旧（DR）用バックアップ**

* **キーワード：** `disaster recovery`, `long-term backup retention`, `best practices`.
* **正解：** **Coldline Storage**。
* **ハック：** 災害（めったに起きない）＝ アクセス頻度が極めて低い ➔ Coldline。

**Q15：Pub/Sub ➔ Cloud Run 連携**

* **キーワード：** `Cloud Run`, `processes messages from Cloud Pub/Sub`, `best practices`.
* **正解：** **Push Subscription** + **Invoker** ロール。
* **ハック：** Runは受動的。Pub/Subから「投げてもらう(Push)」のが定石。

**Q16：指定された内部IP（10.194...）を固定**

* **キーワード：** `specific IP 10.194.3.41`, `proprietary software hard-coded`.
* **正解：** **Static Internal IP** を予約。
* **ハック：** アプリがIP指定なら、予約して固定するしかない。

**Q17：特定アプリ（Apache等）の「下り通信費」のみ監視**

* **キーワード：** `egress network costs for the Apache server`, `not for entire project`.
* **正解：** **Billing Export + BigQuery**。
* **ハック：** 予算アラートは「PJT単位」。特定リソースだけの細かな費用は BigQuery で分析が必要。

**Q18：VMが死んだら自動再生成（Autohealing）**

* **キーワード：** `unresponsive`, `automatically re-created`, `minimum number of steps`.
* **正解：** **Managed Instance Group (MIG)** + **Autohealing Health Check**。
* **ハック：** 作り直すのは MIG の仕事。LBはトラフィックを止めるだけ。

**Q19：GKEインフラを自動拡張**

* **キーワード：** `GKE cluster`, `scale automatically`, `minimize manual configuration`.
* **正解：** **Node Pool の Autoscaling 有効化**（Cluster Autoscaler）。
* **ハック：** Podを増やすのがHPA。インフラ（Node/VM）自体を増やすのが CA。

**Q20：CLIでVM作成の前提条件**

* **キーワード：** `Compute Engine instance using the CLI`, `prerequisite`.
* **正解：** **`compute.googleapis.com` API の有効化**。
* **ハック：** GCPはAPIを「有効化」しないと何も始まらない。

---

### 📦 Storage & Database (Q21-Q30)

**Q21：App Engineで「予備」を常に待機**

* **キーワード：** `App Engine`, `4 unoccupied instances ready`, `sudden increases`.
* **正解：** **Automatic Scaling** + **`min_idle_instances`**。
* **ハック：** スパイクに備えて「暇な(Idle)」インスタンスをキープ。

**Q22：30日経った画像を安く（消さない）**

* **キーワード：** `older than 30 days`, `minimize costs`, `automatically managing`.
* **正解：** **Lifecycle Management** で **Archive Storage** へ移動。
* **ハック：** 「削除」ではなく「安く維持」なら Archive。

**Q23：DBのポイントインタイムリカバリ(PITR)**

* **キーワード：** `Cloud SQL (MySQL)`, `point-in-time recovery`, `accidental deletions`.
* **正解：** **Binary Logging** の有効化。
* **ハック：** 過去の特定の瞬間に戻すための必須設定。

**Q24：Cassandra を最速導入**

* **キーワード：** `Cassandra`, `isolated development environment`, `migration quickly`.
* **正解：** **Cloud Marketplace** でプリセット画像を使用。
* **ハック：** 自分で入れるのは手間。ポチるのが最速。

**Q25：他チームと独立した環境で作りたい**

* **キーワード：** `organized independently`, `separate resources`.
* **正解：** **新しい Project を作成**。
* **ハック：** GCPの「独立」の最小単位はプロジェクト。IAMで分けるのは不十分。

**Q26：CPU 90%超えで通知**

* **キーワード：** `CPU usage exceeds 90%`, `notified`.
* **正解：** **Monitoring Alerting Policy**。
* **ハック：** 独自スクリプトは運用負荷が高いので不正解。

**Q27：監視チームにDBの中身は見せない**

* **キーワード：** `monitor environment`, `not be able to access any review details`.
* **正解：** **`roles/monitoring.viewer`** の付与。
* **ハック：** 中身を見る権限（Reader）を避け、インフラを見るロールを与える。

**Q28：Spannerの自動拡張（CPUベース）**

* **キーワード：** `Spanner nodes automatically scales`, `CPU exceeds threshold`.
* **正解：** **Monitoring Alert ➔ Webhook ➔ Cloud Function** でリサイズ。
* **ハック：** Spannerにネイティブな自動スケールはないため、FunctionsでAPIを叩く。

**Q29：Googleアカウントの競合**

* **キーワード：** `personal Google accounts overlap`, `avoid conflicts`.
* **正解：** **転送（Transfer）** を招待。
* **ハック：** 削除しろと言うのはマナー違反。会社管理下に移ってもらうのが正解。

**Q30：他PJTのBQデータを「読みたい」**

* **キーワード：** `BigQuery dataset in a separate project`, `read data`.
* **正解：** **`roles/bigquery.dataViewer`**。
* **ハック：** **Job User** ロールは「クエリを実行する権利」だけでデータは読めない。

---

### 🛠 運用・管理 (Q31-Q40)

**Q31：オンプレアプリのAPI認証**

* **キーワード：** `on-premises application`, `authenticate and connect to GCP APIs`.
* **正解：** **Service Account Key (JSON)** を作成。
* **ハック：** 外の世界から入るための物理的な「鍵」を持っていく。

**Q32：Serverless移行（Dashboard/API/Batch）**

* **キーワード：** `minimize operational expenses`, `serverless architecture`.
* **正解：** **App Engine** (Dashboard) / **Cloud Run** (API) / **Cloud Tasks** (Batch)。
* **ハック：** VM(GCE)でバッチをやると立ち上げっぱなしで金がかかる。

**Q33：GKE管理最小＋ネット遮断**

* **キーワード：** `GKE cluster`, `not accessible from public internet`, `minimize overhead`.
* **正解：** **Private Autopilot Cluster**。
* **ハック：** 管理最小＝Autopilot、遮断＝Private。最強防御形態。

**Q34：Spannerクエリ性能を最短改善**

* **キーワード：** `shortest possible time`, `enhance performance`.
* **正解：** **CPU 65%アラート ➔ Node追加**。
* **ハック：** クエリ修正は時間がかかる。サーバー増強（金の力）が最短。

**Q35：月額費用の見積もり**

* **キーワード：** `estimate the monthly cost`, `accurate estimate`.
* **正解：** **Pricing Calculator**。
* **ハック：** 1週間動かして予想するのは金と時間の無駄。

**Q36：5年保存 / 5世代管理 / 1年で安く**

* **キーワード：** `retained for 5 years`, `up to five versions`, `older than one year... tier`.
* **正解：** **Versioning** (世代) ＋ **Lifecycle** (移行)。
* **ハック：** GCSの標準機能の組み合わせが最も運用負荷が低い。

**Q37：既存SubnetのIPアドレス枯渇**

* **キーワード：** `IP address exhaustion`, `minimizing complexity`.
* **正解：** **`expand-ip-range`** コマンド。
* **ハック：** VPC作り直しは大変。今のサブネットを広げるのが最短。

**Q38：CLIのデフォルトGKE設定**

* **キーワード：** `CLI to target this GKE cluster by default`.
* **正解：** **`gcloud config set container/cluster`**。
* **ハック：** `gcloud config set` は「今後ずっとこの設定でいく」宣言。

**Q39：SSD読込性能の限界（最大スループット）**

* **キーワード：** `disk read throttling`, `maximum amount of throughput`.
* **正解：** **Local SSD**。
* **ハック：** ネットワーク経由(Persistent)より物理直結(Local)が最強。

**Q40：リソース不明なWorkloadのコスト提案**

* **キーワード：** `uncertain about resource needs`, `cost-effective suggestions`.
* **正解：** **VPA (Vertical Pod Autoscaler)** 推薦モード。
* **ハック：** 提案(Suggestions)と言われたら VPA の出番。

---

### 🛡 セキュリティ・負荷分散 (Q41-Q50)

**Q41：特定のVMだけGCSにアクセス**

* **キーワード：** `new instance can access`, `without allowing other virtual machines`.
* **正解：** **専用 Service Account** を作成。
* **ハック：** デフォルトSAを使うと全VMに権限が漏れる。

**Q42：インフラ構成の総コスト見積もり**

* **キーワード：** `estimate total cost`, `three-tier social media`.
* **正解：** **Pricing Calculator** で全リソースを入力。
* **ハック：** オンプレと同スペックの構成を計算機に入れる。

**Q43：地域限定 / 頻繁アクセス / 低コスト**

* **キーワード：** `processed regularly`, `Boston`, `minimal storage costs`.
* **正解：** **Regional + Standard**。
* **ハック：** 毎日触るなら Nearline は手数料で高くなる。

**Q44：数%のユーザーにだけ新版をテスト**

* **キーワード：** `test new features with a small portion of live traffic`.
* **正解：** **App Engine Traffic Splitting**。
* **ハック：** 新版に数%だけ割り振る専用機能。

**Q45：Bigtableの全操作を監査**

* **キーワード：** `log all read and write`, `PII`, `send to SIEM`.
* **正解：** **Audit Logs (Data Read/Write)** 有効化 ➔ Pub/Sub 経由で飛ばす。
* **ハック：** 個人情報(PII)の操作ログは標準ではなく「監査ログ」をONにする。

**Q46：PostgreSQLを「最小変更」で移行**

* **キーワード：** `runs on PostgreSQL`, `minimal changes to codebase`.
* **正解：** **Cloud SQL (PostgreSQL)**。
* **ハック：** 同じエンジンならコード修正がほぼ不要。

**Q47：別の環境（dev等）のNode状態を確認**

* **キーワード：** `view the nodes from prod`, `verify for dev`.
* **正解：** **`gcloud get-credentials`**。
* **ハック：** まず資格情報を切り替えないと kubectl は動かない。

**Q48：SAキー寿命制限（24時間）**

* **キーワード：** `keys valid for only one day`, `centralized project`.
* **正解：** **Organization Policy** で制限。
* **ハック：** 個別設定ではなく組織全体でルールとして縛る。

**Q49：CI/CDパイプラインの安全な権限**

* **キーワード：** `CI/CD pipeline`, `correct permissions`, `best practices`.
* **正解：** **複数 SA + Secret Manager**。
* **ハック：** 1つのSAに盛らず、タスクごとに最小権限のSAを作る。

**Q50：SSL/TCP 443（non-HTTP）＋全世界**

* **キーワード：** `SSL-encrypted TCP`, `port 443`, `various regions`.
* **正解：** **SSL Proxy Load Balancer**。
* **ハック：** 443ポートだが「HTTP/S」ではない「TCP」ならこれ。

---