# 🚀 Google Cloud ACE 試験対策：2週間合格ハックシート

## 1. 🌐 ネットワーク (Networking)

> **判断基準:** 「広げる」「繋ぐ」「最大」を見極める。

* **オンプレからGCP API利用（インターネット禁止）**
* 👉 `VPN / Interconnect` + `Cloud Router` + **`restricted.googleapis.com`** (DNS CNAME)


* **IPアドレスが足りなくなった**
* 👉 **`expand-ip-range`** コマンドでサブネットマスクを広げる（例：/25 → /24）。


* **VPCの最大IPレンジが必要**
* 👉 **`10.0.0.0/8`**
* **ハック：** 数字が小さいほどデカい（/8 > /24）。`10.0.0.0` 系列がプライベートIPの王者。



---

## 2. 🔐 IAM & セキュリティ (Security)

> **判断基準:** 「最小権限」と「管理コストの削減」。

* **VMへのSSH管理（チーム対応・個別追跡）**
* 👉 **`OS Login`** (`compute.osAdminLogin`) をGoogleグループに付与。
* **ハック：** `Individual tracking` (個別追跡) や `Efficient` とあればこれ。鍵の手動配布は**即切り**。


* **カスタムロールの複製（プロジェクト間）**
* 👉 **`gcloud iam roles copy`**
* **ハック：** `Fewest steps` で「他でも使いたい」なら **`copy`**。`create` は手間が多いのでハズレ。


* **オンプレアプリからGCP APIへの認証**
* 👉 `Service Account Key` (JSON) を作成し、オンプレ側に配置。


* **SAキーの寿命制限（一時対策）**
* 👉 **Organization Policy** で `Key Lifetime` を制限。



---

## 3. 💻 Compute & Scaling (Workloads)

> **判断基準:** 「何（Pod/Node）を増やすか」「どこ（gcloud/kubectl）をいじるか」。

* **コンテナ / 低トラフィック / コスト最小**
* 👉 **`Cloud Run`** (Scale to Zero が決め手)。

    1-Q11 ハック：サーバーレスコンテナの選択
    キーワード： Container image + HTTP endpoint + Very few users (または Low traffic)
    正解： Cloud Run
    英語ハック：
    Pay-as-you-go：使った分だけ払う。
    Incurs costs only when...：～のときだけ費用が発生する。
    Idle：アイドル状態（暇な時間）。Cloud Runなら暇な時間のコストは0。


* **GKEのオートスケーリング**
* 👉 中身（Pod）を増やす ➔ **`HPA`** (Horizontal Pod Autoscaler)
* 👉 器（Node）を増やす ➔ **`Cluster Autoscaler`**


* **GKE環境の切り替え（コンテキスト操作）**
* 👉 **`kubectl config use-context`** ➔ **`kubectl config view`**
* **鉄則：** GCP設定（プロジェクト等）は `gcloud`、K8s内部（コンテキスト等）は `kubectl`。


* **Deployment ManagerからK8sを操作**
* 👉 **`Type Provider`** を追加。
* **ハック：** 「GCPツールでK8sリソースを直接いじりたい」ならこの単語を探す。


* **VMの自動復旧（Autohealing）**
* 👉 **`MIG`** + **`HTTP Health Check`**。



---

## 4. 💰 課金とコスト最適化 (Billing & Optimization)

> **判断基準:** 「明日まで（最速）」か「歪なスペック（カスタム）」か。

* **急ぎの課金統合 (Rapid Consolidation)**
* 👉 新しい **`Billing Account`** にプロジェクトを **`Link`** する。
* **ハック：** `as of tomorrow`（明日まで）のような急ぎの場合、プロジェクトの「移動（Migrate）」は時間がかかるので**即切り**。


* **特定のメモリ量が必要（CPU不要 / コスト最小）**
* 👉 **`Custom Machine Type`** でメモリだけを増設。
* **キーワード：** `Minimize cost`, `Almost no CPU usage`。比率が歪ならカスタム一択。


** clout logging **
    1-Q12: ログの分析用転送 (Logs Export to BigQuery)
    キーワード：Logs to BigQuery, Analysis, Cost efficiency
    正解：Cloud Logging Sink (Filter ➔ Create Export ➔ BigQuery)
    ハック：**「ログをどこかへ送る」**なら、余計なサービスを挟まずに Sink（シンク） を使うのが常に最短・最安。

    1-Q13: ログの長期保管 (Log Retention for 3 Years)
    キーワード：3 years, Store logs, Cost-effective
    正解：Cloud Storage (Coldline) への Sink。
    ハック
    BigQuery = 高機能・高コスト（分析用）。
    GCS (Coldline) = 低機能・低コスト（保存用）。
    「3年間」のような長期保存は、GCSのコールド系ストレージが鉄板。

---

## 5. 📦 Storage & Database (Data Handling)

> **判断基準:** 「きっかけ（Trigger）」と「窓口（Proxy）」。

* **画像変換のトリガー（イベント駆動）**
* 👉 **`GCS`** ➔ **`Cloud Functions`** ➔ **`GCS`**
* **ハック：** 「ファイルが置かれたら ➔ 何かする」はGCPの鉄板。


* **HTTPリバースプロキシ（キャッシュ用）**
* 👉 **`Compute Engine (VM)`** に Nginx等を入れる。
* **ハック：** `Memorystore (Redis)` は「倉庫」であり「窓口（プロキシ）」になれないため、この文脈では**即切り**。


* **DBのポイントインタイムリカバリ (PITR)**
* 👉 Cloud SQL で **`Binary Logging`** を有効化。


* **サードパーティDB（Cassandra等）の最速移行**
* 👉 **`Cloud Marketplace`** のプリセットイメージ。



---





## ⚖️ 【境界線】どっちを選ぶ？の判断軸

### ストレージ：アクセス頻度（コスト最適化）

　　１−１４

    📦 GCS ストレージクラス・運用ハック
    【クラス選択の境界線】
    Standard: 毎日〜月1回。Web画像など。
    Nearline: 月1回以上。バックアップ用。
    Coldline: 年1回以上 (DR / 災害復旧用)。※Q14の正解。
    Archive: 数年に1回。監査・法規制データ用。

    【運用・コスト最適化】
    原則: 用途（アクセス頻度）ごとに バケットを分ける。
    自動化 (Lifecycle Management):
    「最初は頻繁に、後は長期保存」なら迷わずこれ。
    経過日数（Age）に応じて、自動で安いクラスへ移動させる。

    プラン変更の注意点:
    バケットのデフォルトクラスを変更しても、既存ファイルには適用されない。
    既存分も一括変更したいなら、Lifecycle Management か gsutil rewrite を使う。

    【試験スキャン単語】
    Disaster Recovery (DR) ➔ Coldline
    Long-term retention ➔ Coldline / Archive
    Minimal steps / Automatically ➔ Lifecycle Management


### データベース：用途と規模

* **普通のSQL（MySQL / PostgreSQL）** 👉 `Cloud SQL`
* **グローバル規模のSQL / 強一貫性** 👉 `Cloud Spanner`
* **大量のNoSQL / ミリ秒単位の低遅延** 👉 `Bigtable`
* **大量データの集計・分析（OLAP）** 👉 `BigQuery`

### ネットワーク：ハイブリッド接続

* **最高速度・最高安定・最高コスト** 👉 `Dedicated Interconnect`
* **専用線だが、コストや場所を妥協** 👉 `Partner Interconnect`
* **ネット経由・暗号化（IPsec）必須** 👉 `Cloud VPN`

---

## 🛠️ 【鉄板コマンド】gcloud / kubectl

* **プロジェクト設定**: `gcloud config set project [PROJECT_ID]`
* **ログイン確認**: `gcloud auth list`
* **GKE接続設定**: `gcloud container clusters get-credentials [NAME]`
* **ロール複製**: `gcloud iam roles copy`
* **ノード確認**: `kubectl get nodes`

---

## 🔑 【実戦】重要キーワード辞典

| キーワード | 試験での意図（正解へのヒント） |
| --- | --- |
| **Operational Overhead** | これを「減らせ」と言われたら `Managed` / `Serverless` を選ぶ。 |
| **Least Privilege** | 「最小権限」。`Owner` / `Editor` は避け、具体的なロールを選ぶ。 |
| **Preemptible / Spot** | 24時間以内に消える。バッチ処理やコスト削減の正解。 |
| **Pricing Calculator** | 見積もり計算の唯一の公式ツール。 |
| **Traffic Splitting** | `App Engine` や `Cloud Run` で新版をテスト（ABテスト）する際の手法。 |
| **Impersonation** | SAキーを直接使わず、一時的に権限を借りる安全な方法。 |

---

## 💡 【英語ひっかけ】除外ワード・鉄則

1. **"Shared credentials / keys"** 👉 **即除外**（セキュリティ違反）。
2. **"Manual"** 👉 **ほぼ除外**（`Automatic` / `Managed` が正義）。
3. **"Migrate"** 👉 「接続したいだけ」の状況では**極端すぎて除外**。
4. **"Project-wide SSH keys"** 👉 `OS Login` がある場合はそちらが優先。
5. **"Download JSON key"** 👉 サービス間の連携なら「Role付与」が正攻法。

---


## 📖 ACE試験：最重要英単語・フレーズ集

> **スキャン術:** 問題文の「毒（現状）」をこれらの単語で見抜き、「薬（正解）」を導き出す。

### 1. 🏢 組織・ビジネス背景（Scenario Context）

| 英単語・フレーズ | 意味 | 試験での「読み替え」ハック |
| --- | --- | --- |
| **Operates a ride-hailing app** | 配車アプリを運営している | 背景説明。SnapRideなどの会社名とセット。 |
| **Company A acquired Company B** | A社がB社を買収した | **フラグ：** 異なる組織や請求先を「統合」する問題の開始合図。 |
| **Streamline operations** | 運用を効率化する | **ゴール：** 無駄な手順を省く、マネージドサービスを使う。 |
| **To accommodate future scaling** | 将来の拡張に対応する | **ゴール：** IPアドレスを多めに取る、オートスケールを設定する。 |

### 2. 💰 請求・コスト管理（Billing & Cost）

| 英単語・フレーズ | 意味 | 試験での「読み替え」ハック |
| --- | --- | --- |
| **Personal credit cards** | 個人のクレジットカード | **毒（現状）：** 統制が取れていない「悪い状態」。 |
| **Cover costs** | 費用を負担（立て替え）する | **毒（現状）：** 従業員が自腹を切っている。 |
| **Reimburses** | 払い戻す（精算する） | **毒（現状）：** 会社が後から精算する手間。これが来たら「一括請求への統合」が正解。 |
| **Consolidate / Consolidation** | 統合する / 集約 | **薬（正解）：** 複数のプロジェクトを1つの請求先に紐付ける（Link）。 |
| **Streamline billing** | 請求を効率化する | **ゴール：** バラバラな支払いを「Single Billing Account」にまとめる。 |

### 3. 🛠️ 運用・効率化（Operations）

| 英単語・フレーズ | 意味 | 試験での「読み替え」ハック |
| --- | --- | --- |
| **Minimal steps / Fewest steps** | 最小の手間で | **鉄則：** 最短の標準機能を選べ。手動作成（create）よりコピー（copy）や既存機能。 |
| **Inactive environments** | 非アクティブな環境 | 設定だけ確認したい対象。`kubectl config` 系の出番。 |
| **Appropriate IAM roles** | 適切なIAMロール | **ゴール：** 最小権限（Least Privilege）を守れ。 |
| **Production project** | 本番環境プロジェクト | 開発（Dev）とは別の、権限管理が厳しい場所。 |


### 4. そのほか
that creates personalized stargazing apps　直訳： 個人向けの「星空観察アプリ」を作っている（会社）。
Virtual telescope　直訳： 仮想望遠鏡。
Adhere (アドヒア) 意味： （規則・方針などに）忠実に従う、固守する。
Retention (リテンション) 意味： 保持、保管。

---


### 💡 ACE単語ハック

* **`Consolidate`（固める）** と出たら、**`Link`（繋ぐ）** を探す。
* **`Reimburse`（精算）** と出たら、**`Personal card`（個人払い）をやめる** 選択肢を探す。
* **`Minimal steps`（最小の手間）** と出たら、**「Googleが用意した楽な道（Managed/Command）」** を探す。

---

## 2. 技術ポイント (Technical Deep Dive)

### 🚀 HTTP Reverse Proxy（リバースプロキシ）

* **役割：** インターネットからのアクセスを一番前で受け、裏側のサーバーへ中継・キャッシュする**「受付窓口」**。
* **代表例：** **Nginx** (エンジンエックス), **Apache** (アパッチ), **Varnish** (バーニッシュ)。
* **【試験ハック】：**
* 問題文に「HTTP Reverse Proxy」とあれば、正解は **Compute Engine (VM)**。
* **Memorystore (Redis)** は「高速な倉庫」に過ぎず、HTTP窓口にはなれないため、この文脈では**即切り**。



### ☸️ GKE / Kubernetes の管理

* **境界線：**
* **`gcloud`**：GCPという「プラットフォーム」の設定（プロジェクト、APIなど）。
* **`kubectl`**：Kubernetesという「OSの中」の設定（ポッド、コンテキストなど）。


* **【試験ハック】：**
* 「非アクティブな環境の設定を確認する」なら、**`kubectl config use-context`** で切り替えてから **`kubectl config view`** で見るのが最短。



---

## 3. 今日の「条件反射」チートシート追加分

* **[支払い]** `Personal cards` / `Reimburse` ➔ **New Billing Account を作成して Link する**。
* **[マシン]** `Memory 32GB` ＋ `Low CPU` ➔ **Custom Machine Type** でメモリだけ盛る。
* **[ネットワーク]** `On-prem` ➔ `GCS (Private)` ➔ **restricted.googleapis.com** ＋ **DNS CNAME**。

---


