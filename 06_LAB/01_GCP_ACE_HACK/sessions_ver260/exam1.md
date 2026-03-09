# ⚡️ Exam 1: ハックリスト (Q1-Q10)

## 🌐 ネットワーク・接続

### 🌐 Q1：オンプレからGCSアクセス（インターネット禁止・非公開でGoogle APIsへ）

* キーワード: `on-premises`, `no public IP`, `restrict internet access`, `Google Cloud APIs`
* 正解（薬）:
  * **Google APIs（`*.googleapis.com`）を `restricted.googleapis.com` に解決させる**（CNAME/Private DNS）
  * **VIP `199.36.153.4/30` への経路を Cloud Router（BGP）でオンプレへ広報**
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
* `storage.googleapis.com` をそのまま引くと、通常は公開インターネット経路に出やすい。
* そこで **Google APIs（`*.googleapis.com`）を `restricted.googleapis.com` に向ける**（CNAME/Private DNS）ことで、API宛先を「制限付き」側へ寄せる。

2. VIP（199.36.153.4/30）
* `restricted.googleapis.com` の **VIP レンジが `199.36.153.4/30`**。このIP帯へ「社内から行ける」ようにするのがコア。

3. 経路広報（Cloud Router / BGP）
* オンプレ側に「`199.36.153.4/30` は VPN/Interconnect へ流せ」を教えるために、**Cloud Router で BGP 広報**する。

#### 🛡️ 類似ワードの整理（混同ポイント）

| 用語 | どこから叩く？ | 典型要件 |
| --- | --- | --- |
| Private Google Access | VPC内VM | サブネットで Private Google Access を有効化、など |
| Private Google Access for on-premises | オンプレ | VPN/Interconnect + DNS + VIP(199.36.153.4/30) |

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
* 正解（薬）: **Custom machine type**（CPU最小（例: 2vCPU）+ メモリ32GB）
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

### 🧠 Q10：コア抜き出し＆速攻ハック

#### **【問題文コア（英）】**

> Deploy a **GKE cluster** AND a **DaemonSet**... in the **simplest way** using the **fewest services**.

#### **【問題文コア（和）】**

> **GKEクラスタ**と**DaemonSet**（K8sリソース）を、**最小限のサービス**で同時にデプロイしたい。

---

#### **【正解ハック（薬）】**

**Type Provider で K8s API を登録する**

* **理由:** 本来「K8s内部」を触れないDeployment Manager(DM)に、**Type Provider** という「拡張プラグイン」を入れて、直接DaemonSetを作らせるのが、追加サービス（踏み台サーバー等）なしの最短ルート。

---

#### **【選択肢の毒（排除理由）】**

* **Runtime Configurator:** 「設定値の保存箱」であり、デプロイツールではない。
* **Startup Script で `kubectl`:** VMを立てる手間が増えるため、「fewest services（最小サービス）」に反する。

---

#### **【一言で覚える】**

> **「DMからK8s操作」＝「Type Provider（型プロバイダ）」**

---





## 💻 サーバーレス・Compute (Q11-Q20)

### Q11：コンテナ / ユーザー極少 / コスト最小
この問題の論点は**「サーバーレス(Serverless) vs 常駐型(Always-on)のコスト境界線」**です。

* キーワード： `container image`, `HTTP endpoint`, `very few daily users`, `cost-efficient`
* 正解（薬）： **Cloud Run**（完全マネージド）
* ハック（「使った分だけ」の極致）：
  * ユーザーがいない時間は **「0円」** にしたいなら、迷わず **Cloud Run**
  * リクエストが来た時だけコンテナが立ち上がり、終われば消える（few usersに最強）

#### 💡 なぜ他の選択肢が「毒」なのか？

1. **GKE（B, Dの毒）**: ノード（VM）が動く限り課金が発生。極少ユーザーには過剰。
2. **App Engine Flexible（Cの毒）**: VMが常駐し最低料金がかかる。起動も遅め。

#### 🛡️ 2周目用：毒と薬の見分け方

| 状況 | 薬（正解） | 毒（不正解） |
| --- | --- | --- |
| トラフィックが極少・不定期 | Cloud Run（Scale to zero） | GKE, Compute Engine |
| 24時間安定した大量アクセス | GKE, Compute Engine | Cloud Run（単価が不利になる可能性） |
| 標準的なWebアプリ（コンテナなし） | App Engine Standard | App Engine Flexible |

#### 🚀 2周目のリズム

「コンテナ ＋ ユーザー少ない ➔ Cloud Run」

---

### 🧠 Q12：Cloud Logging におけるログ転送（Log Sink）の設計

#### **【問題文コア（英）】**

> Send **all logs** from Compute Engine to **BigQuery** for analysis **cost-efficiently**.

#### **【問題文コア（和）】**

> Compute Engine のログを、**分析用（BigQuery）**に**最も安く（標準機能で）**転送したい。

---

#### **【正解ハック（薬）：C】**

**Cloud Logging の「ログのルーター（Log Sink）」を使う**

* **理由:** 「ログの転送（Sink）」は Cloud Logging の標準機能です。
* **手順:** フィルターで対象を絞る ➔ **Create Sink** ➔ 宛先に **BigQuery** を選ぶ。これだけで、全自動・リアルタイム・ノーコードで転送が始まります。

---

#### **【選択肢の毒（排除理由）】**

* **B, D (Cloud Functions / Scheduler):** 自作コードの管理コスト、実行コストがかかるため、標準機能がある場合は「毒」となります。
* **A (Metadata):** ログの転送設定をインスタンスのメタデータで管理する仕組みは存在しません（架空の毒）。

---

#### **【一言で覚える】**

> **「ログを他へ送る」＝「Sink（シンク）を作る」**

---


### 🧠 Q13：長期ログ保存のコスト最適化（アーカイブ設計）

* キーワード： `store for 3 years`, `hundreds of projects`, `cost-effective`
* 論点： 長期・低頻度アクセスは分析用ストレージだとコスト過多
* 正解（ベストプラクティス）： **Cloud Logging Sink → Cloud Storage（Coldline / Archive）**

#### 💡 客観的な技術評価

1. **クラス選定**: Coldline/Archiveで大幅に安い
2. **集約エクスポート**: プロジェクト多数なら Organization レベルでSinkを作るのが効率的
3. **ライフサイクル**: 3年後削除も自動化可能

#### 🛡️ ログ保存先の比較（コストと目的）

| 宛先 | コスト | 主な用途 | 保持期間の目安 |
| --- | --- | --- | --- |
| Cloud Storage | 極低 | コンプライアンス、監査、長期保管 | 数ヶ月〜数年 |
| BigQuery | 中〜高 | 直近の分析、可視化 | 数週間〜数ヶ月 |
| Cloud Logging | 高 | リアルタイムのデバッグ、監視 | 標準30日（最大10年だが高額） |

---

### 🧠 Q14：ディザスタリカバリ（DR）用バックアップの選定

* キーワード： `critical data backups`, `disaster recovery`, `long-term retention`, `best practices`
* 論点： めったに取り出さない長期保管＝最安クラスが基本
* 正解（ベストプラクティス）： **Coldline Storage**（選択肢になければ Archive がより安い）

#### 💡 客観的な技術評価

1. **アクセス頻度とクラスの相関**
   * Multi-Regional / Regional: 常時アクセス用（高い）
   * Nearline: 月1回程度
   * Coldline: 年1回程度（DR向き）
2. **取り出し料金**: 高いがDR用途ならトータルは安くなりやすい
3. **耐久性**: どのクラスも 11 nines は同等

---

### 🧠 Q15：Cloud Run と Pub/Sub のベストな連携（Push型）

* キーワード： `Cloud Run`, `Pub/Sub topic`, `Activity messages`, `Best practices`
* 論点： Cloud Run（scale-to-zero）にメッセージを効率的に届ける
* 正解（ベストプラクティス）： **Pub/Sub の Push サブスクリプションで Cloud Run URL を叩く**

#### 💡 客観的な技術評価

1. **Push vs Pull**
   * Pull: 常時起動が必要になりがち（毒）
   * Push: 必要時だけ叩き起こす（薬）
2. **認証（Invoker）**
   * 誰でも叩ける公開は毒
   * Pub/Sub 側のSAに `Cloud Run Invoker` を付与して保護
3. **中継の増加は毒**
   * Functions中継やGKEプロキシは管理点が増える

---

### 🧠 Q16：Compute Engine 固定（内部）IP の指定（クライアントがハードコード）

**【実質的な問題文】**

> Deploy a Compute Engine instance with a specific fixed internal IP (10.194.3.41) because the client software is hard-coded and cannot be changed.

#### 🛡️ 構造（シグナル）の見極め

1. **特定IPの指定（薬）**
   * `10.194.3.41` を指名して予約（Static Internal IP）：プライベートIP
2. **自動割り当ての罠（毒）**
   * Ephemeral / Automatic は番号を選べない
3. **Promote の罠（毒）**
   * 既存の番号を固定にするだけで、番号自体を `41` に変えられない

#### 💡 2周目用：最短チェックリスト

| 状況（シグナル） | 薬（正解） | 理由 |
| --- | --- | --- |
| IPが直書きされている | Static Internal IP 予約 | 番号を指名する必要がある |
| ネット越しに固定したい | Static External IP | 外向き（パブリック）が必要 |
| 番号はどうでもいい | Ephemeral IP | 簡単で無料 |

---

### Q17：特定アプリ（Apache等）の「下り通信費」のみ監視

#### 🧠 Q17：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Notify via email when a specific service cost (egress for a specific VM) exceeds $100. The project has many other services running.

#### 🛡️ 構造（シグナル）の見極め

1. **標準アラートの限界（毒）**
   * Budget Alerts は合計金額向け。特定VMのEgressだけは難しい
2. **詳細分析には BigQuery（薬）**
   * Billing Export → BigQuery で明細を抽出して判定
3. **ログからの推測（毒）**
   * Apacheログから推測は手間・ズレが出る

#### 💡 2周目用：最短チェックリスト

| 監視したい対象 | 薬（正解） | 理由 |
| --- | --- | --- |
| プロジェクト全体の合計 | Budget Alerts | 最短 |
| 特定サービス/リソース | BigQuery Export + Function | 標準だけでは粒度不足 |

---

### Q18：VMがDownしたら自動再生成（Autohealing）

#### 🧠 Q18：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Configure Autohealing for Compute Engine instances to automatically re-create any instance that fails health checks.

#### 🛡️ 構造（シグナル）の見極め

1. **自己修復の主体は MIG（正解）**
   * MIG + Autohealing Health Check で削除・再生成
2. **LBの役割（誤り）**
   * 不健全への転送停止まで（再生成しない）
3. **Autoscaling の役割（誤り）**
   * 台数増減（再生成とは別）

#### 💡 2周目用：最短チェックリスト

| 実現したいこと | 解決策（正解） | 理由 |
| --- | --- | --- |
| インスタンスを再生成したい | MIG + Autohealing | ライフサイクル管理はMIG |
| 通信を止めたいだけ | Load Balancer | 交通整理 |
| 負荷で数を変えたい | Autoscaling | 需要に応じて増減 |

---

### Q19：GKEインフラを自動拡張

#### 🧠 Q19：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Scale a GKE cluster infrastructure automatically to accommodate new microservices (more pods) with minimal manual configuration.

#### 🛡️ 構造（シグナル）の見極め

1. **ノード（VM）を増やすのは Cluster Autoscaler（正解）**
   * Node pool に min/max を設定
2. **HPA はPodの数だけ（誤り）**
   * ノード不足だと Pending
3. **VPA はPodサイズだけ（誤り）**
4. **ノードプール分割の乱立は毒（誤り）**
   * 管理が増える

#### 💡 2周目用：最短チェックリスト

| 何をスケーリングしたい？ | 解決策（正解） | 役割 |
| --- | --- | --- |
| ノード（VM） | Cluster Autoscaler | 土台の拡張 |
| Podの数 | HPA | レプリカ増 |
| Podのサイズ | VPA | 個別最適化 |

---

### Q20：CLIでVM作成の前提条件

#### 🧠 Q20：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> What is the prerequisite step to create a Compute Engine instance using gcloud CLI in a newly created project?

#### 🛡️ 構造（シグナル）の見極め

1. **最初に必要なのは API 有効化（正解）**
   * `compute.googleapis.com` を enable
2. **ネットワークは default がある（誤り）**
   * 推奨だが必須ではない
3. **権限は作成者が Owner 前提（誤り）**
4. **監視は運用フェーズ（誤り）**

#### 💡 2周目用：最短チェックリスト

| 操作フェーズ | 必須アクション | 理由 |
| --- | --- | --- |
| 最初（ゼロ状態） | Enable API | サービスの蛇口を開く |
| 次（作成時） | VPC/Subnet 指定 | 未指定なら default |
| 後（運用時） | Monitoring/Logging | 可視化 |

---




## 📦 Storage & Database (Q21-Q30)

### Q21：App Engineで「予備」を常に待機

#### 🧠 Q21：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Maintain at least 4 idle (unoccupied) instances at all times in App Engine to handle sudden traffic spikes, while scaling automatically with demand.

#### 🛡️ 構造（シグナル）の見極め

1. **待機（Idle）を操るのは Automatic Scaling（正解）**
   * `min_idle_instances` で「暇なインスタンス」を最低何台維持するか指定
2. **Manual Scaling は固定台数（誤り）**
3. **Basic Scaling には idle 維持の概念がない（誤り）**

#### 💡 2周目用：最短チェックリスト

| 要件 | 薬（正解設定） | 特徴 |
| --- | --- | --- |
| スパイクに即応したい | `min_idle_instances` | 予備を確保（コスト増） |
| 0円運用（リクエストなしは0） | Automatic / Basic | Cold Start あり |
| 常に4台で固定 | Manual Scaling | 予測可能な負荷向け |

---

### Q22：30日経った画像を安く（消さない）

### 🧠 Q22：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Minimize costs for Cloud Storage objects by automatically handling files older than 30 days that are no longer frequently accessed.

#### 🛡️ 構造（シグナル）の見極め

1. **自動ならライフサイクル（正解）**
   * Object Lifecycle Management でクラス変更（例: Archive）を自動化
2. **自作スクリプトは運用負荷増（誤り）**
3. **Retention Policy は削除禁止（誤り）**
4. **Versioning は履歴保持でコスト増（誤り）**

#### 💡 2周目用：最短チェックリスト

| 要件 | 薬（正解） | 特徴 |
| --- | --- | --- |
| 時間が経ったら安く/消したい | Lifecycle Management | 設定して放置 |
| 消さないを強制したい | Retention Policy | コンプライアンス |
| 上書き前も残したい | Object Versioning | 履歴管理 |

---

### Q23：DBのポイントインタイムリカバリ（PITR）

### 🧠 Q23：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Select a cost-effective relational database for a small dataset in a single region that supports Point-in-Time Recovery (PITR).

#### 🛡️ 構造（シグナル）の見極め

1. **小規模・単一リージョンなら Cloud SQL（正解）**
   * PITR は **binary logging**（例: MySQL の binlog / PostgreSQL の WAL）を有効化して実現
2. **Failover replicas はHA（誤り）**
3. **Spanner は過剰（誤り）**

#### 💡 2周目用：最短チェックリスト

| 要件 | 薬（正解） | 理由 |
| --- | --- | --- |
| 小〜中規模 / リージョン内 / SQL | Cloud SQL | コスト効率 |
| 過去の時点に戻したい | PITR（ログ） | ログ再生 |
| 世界規模 / 強整合 / 無制限スケール | Spanner | 必要時のみ |

---

### Q24：Cassandra を最速導入

#### 🧠 Q24：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Provide multiple isolated dev environments for a specific software (Cassandra) quickly with minimal operational overhead.

#### 🛡️ 構造（シグナル）の見極め

1. **最短・最小の手間なら Marketplace（正解）**
   * 検証済みセットを即デプロイできる
2. **マニュアル配布は毒（誤り）**
3. **自作イメージ/スナップショット管理は毒（誤り）**

#### 💡 2周目用：最短チェックリスト

| 課題 | 薬（正解） | 特徴 |
| --- | --- | --- |
| 有名ソフトをすぐ使いたい | Cloud Marketplace | 即デプロイ |
| 独自のOS設定を配布したい | Custom Images | 社内標準の型 |
| 一時的に状態を保存したい | Snapshots | 保存と復元 |

---

### Q25：他チームと独立した環境で作りたい

#### 🧠 Q25：ACE論点への超圧縮（骨組み抽出）

**【実質的な問題文】**

> Create a separate environment for a new team (Design Team) that is independent of the existing project.

#### 🛡️ 構造（シグナル）の見極め

1. **独立なら新プロジェクト（正解）**
   * セキュリティ・課金・権限の分離単位は Project
2. **既存PJTへの権限追加は共有（誤り）**
3. **Project ID は全世界で一意（誤り）**

#### 💡 2周目用：最短チェックリスト

| 要件 | 薬（正解） | 理由 |
| --- | --- | --- |
| チームごとに独立させたい | New Project の作成 | 境界線を明確化 |
| 表示名を決めたい | Project Name（任意） | 人間向け |
| システム識別子 | Project ID（一意） | 全世界で唯一 |

---


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