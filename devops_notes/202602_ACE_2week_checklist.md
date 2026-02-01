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
