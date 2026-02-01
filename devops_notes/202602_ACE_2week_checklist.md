# 🚀 Google Cloud ACE 完全攻略チートシート（実戦版）

## 1. 【速攻判断】10秒で切るための条件反射リスト

### 🌐 ネットワーク

* **オンプレからGCP API利用（インターネット禁止）**
* 👉 `VPN / Interconnect` + `Cloud Router` + `restricted.googleapis.com` (DNS CNAME)


* **IPアドレスが足りない**
* 👉 `expand-ip-range` コマンドでサブネットのマスク（例：/25 → /24）を広げる。


* **VPCの最大IPレンジが必要**
* 👉 `10.0.0.0/8` を選ぶ。



### 🔐 IAM & セキュリティ

* **VMへのSSH管理（チーム対応）**
* 👉 `OS Login` (`compute.osAdminLogin`) をGoogleグループに付与。
    VMへのSSHログイン管理
    キーワード：Individual tracking (個別追跡), Efficient (効率的)
    正解：OS Login (compute.osAdminLogin) を使う。
    ひっかけ： 鍵の共有や手動配布はすべて「不正解」として切る。


* **特定のプロジェクトのロールを別プロジェクトへコピー**
* 👉 `gcloud iam roles copy --destination-project...`


* **オンプレアプリからGCP APIへの認証**
* 👉 `gcloud` で **Service Account Key (JSON)** を作成し、オンプレ側に配置。


* **サービスアカウントキーの寿命制限（一時対策）**
* 👉 **Organization Policy** で `Key Lifetime` を24時間に制限。



### 💻 Compute & Scaling

* **低トラフィック / コスト最小 / 運用ゼロ**
* 👉 `Cloud Run` (Scale to Zero が決め手)。


* **GKEの「中身（Pod）」を増やす**
* 👉 `HPA (Horizontal Pod Autoscaler)`。


* **GKEの「器（Node）」を増やす**
* 👉 `Cluster Autoscaler`。

    GKE/K8s環境の切り替え
    キーワード：Kubernetes configuration ＋ Minimal steps
    正解：kubectl config use-context ➔ kubectl config view
    鉄則： GCP自体の設定（Project等）は gcloud、K8sの中身（Context等）は kubectl。


* **GKE運用を楽にしたい / セキュリティ重視**
* 👉 `GKE Autopilot` (Shielded Nodes がデフォルト)。


* **VMの自動復旧（Autohealing）**
* 👉 `MIG (Managed Instance Group)` + `HTTP Health Check`。



### 📦 Storage & Database

* **DBのポイントインタイムリカバリ (PITR)**
* 👉 Cloud SQL で `Binary Logging` を有効化。


* **Cassandraなどのサードパーティ製DBを最速で移行**
* 👉 **Cloud Marketplace** のプリセットイメージを使用。


* **特定のメモリ量が必要（CPUは不要）**
* 👉 Compute Engine の `Custom Machine Type` でメモリだけを増設。

    【コスト最適化：マシンタイプの選択】
    特定のメモリ量が必要（CPUは不要 / 最小にしたい）
    👉 Compute Engine の Custom Machine Type を選択。
    理由： 既定のプリセット（Standard等）だと、メモリを増やすと勝手にCPU数も増えて高くなるため。**「メモリとCPUの比率が歪（いびつ）」**ならカスタム一択。
    キーワード： Minimize cost（コスト最小化）、Almost no CPU usage（CPUはほぼ使わない）、In-memory cache（メモリキャッシュ用途）。

---

## ⚖️ 【境界線】どっちを選ぶ？の判断軸

### ストレージ：アクセス頻度（コスト最適化）

* **毎日〜月1回未満** 👉 `Standard`
* **30日以上触らない（バックアップ）** 👉 `Nearline`
* **90日以上触らない（アーカイブ）** 👉 `Coldline`
* **365日以上触らない（法規制・監査用）** 👉 `Archive`

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

# 📚 GCP ACE 試験対策：初日まとめ

## 1. 英語・重要フレーズ (English for ACE)

試験問題の「悪い現状」と「理想のゴール」を読み解くためのキーワードです。

| 英単語・フレーズ | 意味 | 試験での文脈 |
| --- | --- | --- |
| **Operates a ride-hailing app** | 配車アプリを運営している | 会社の事業背景（SnapRideなど） |
| **Personal credit cards** | 個人のクレジットカード | **NGな現状。** 統制が取れていない状態。 |
| **Cover costs** | 費用を（一時的に）負担する | 従業員が立て替えている状態。 |
| **Reimburses** | 払い戻す（精算する） | **重要：** 経費精算の手間が発生している。 |
| **Streamline billing** | 請求を効率化する | **ゴール：** バラバラな支払いを一つにまとめたい。 |
| **Consolidating projects** | プロジェクトを統合する | 複数のプロジェクトを1つの請求先に紐付けること。 |
| **Inactive environments** | 非アクティブな（今使っていない）環境 | 別のクラスター設定を確認する際に出てくる。 |
| **Minimal steps** | 最小の手間で | **正解へのヒント：** 最も効率的な標準機能を選べ。 |

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


