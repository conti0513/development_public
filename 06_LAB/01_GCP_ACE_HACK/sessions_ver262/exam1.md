# GCP ACE 模試ノイズ除去版（一問一答）

## Q1

**問**
低CPU・高メモリのHTTPリバースプロキシを、最小コストで動かすには？

**答**
**Compute Engine の Custom machine type**

**論点**
メモリ偏重 = 標準マシンではなく **Custom machine**

**反射メモ**
in-memory cache = **RAM**
SSD追加では代用不可

---

## Q2

**問**
オンプレから、公開IPなし・インターネット禁止で Cloud Storage に安全接続するには？

**答**
**VPN/Interconnect + Cloud Router + restricted.googleapis.com + 199.36.153.4/30**

**論点**
オンプレから非公開Google APIs = **restricted.googleapis.com**

**反射メモ**
オンプレ秘密接続 =
**restricted.googleapis.com + 199.36.153.4/30**

---

## Q3

**問**
ローカルPCから、長期鍵を使わずにサービスアカウント権限で BigQuery 動作確認するには？

**答**
**Service account impersonation**

**論点**
ローカル検証で JSON key を作らない
= **impersonation**

**反射メモ**
長期鍵回避 = **SA impersonation**

---

## Q4

**問**
オンプレNAS上の大容量動画を、業務時間帯の帯域を圧迫せず Cloud Storage に移したい。何を使う？

**答**
**Storage Transfer Service**

**論点**
オンプレファイルストレージ → GCS の選択的・管理型転送
= **STS**

**反射メモ**
オンプレNAS移行 = **Storage Transfer Service**

---

## Q5

**問**
LLM微調整のような大規模・分散・GPU/TPU付き学習基盤は何を使う？

**答**
**GKE + hardware accelerators**

**論点**
大規模分散学習・柔軟なオーケストレーション
= **GKE**

**反射メモ**
学習基盤 = **GKE**
推論やHTTP処理 = Cloud Run と分ける

---

## Q6

**問**
買収先の多数のプロジェクトの請求を、明日から1枚の請求書にまとめたい。最短は？

**答**
**買収先プロジェクトを自社の Billing Account に付け替える**

**論点**
請求一本化 = 組織移行ではなく **Billing付け替え**

**反射メモ**
急ぎの請求統合 = **Billing Account変更**

---

## Q7

**問**
単一レプリカPodの CPU 割当を自動調整したい。複製は増やせない。何を使う？

**答**
**Vertical Pod Autoscaler (VPA)**

**論点**
単一Podのサイズ調整 = **VPA**

**反射メモ**
HPA = 数
VPA = サイズ
CA = ノード数

---

## Q8

**問**
GKE の rolling update 後に不具合。すぐ前バージョンへ戻すには？

**答**
**kubectl rollout undo**

**論点**
Deployment の即時ロールバック = **rollout undo**

**反射メモ**
restart では戻らない
**undo** が戻す

---

## Q9

**問**
Bash + gcloud をローカルでサービスアカウント権限として安全に試すには？

**答**
**gcloud で service account impersonation を使う**

**論点**
CLIローカル実行 + 長期鍵回避 = **impersonation**

**反射メモ**
ローカルCLIでSA = **impersonation**

---

## Q10

**問**
Deployment Manager で GKE の DaemonSet を最小サービス数で作るには？

**答**
**Kubernetes API を Type Provider として追加**

**論点**
Deployment Manager からK8sリソースを直接操作
= **Type Provider**

**反射メモ**
DMでK8s操作 = **Type Provider**

---

## Q11

**問**
コンテナ化Webアプリ、利用者少、HTTP endpoint、最安で出したい。何を選ぶ？

**答**
**Cloud Run**

**論点**
コンテナ + 低トラフィック + コスト最小
= **Cloud Run**

**反射メモ**
ユーザー少ないコンテナ = **Cloud Run**

---

## Q12

**問**
Compute Engine のログだけを BigQuery に低コストで送りたい。何を使う？

**答**
**Cloud Logging の Sink を BigQuery に作成**

**論点**
ログ分析基盤 = **Log Sink → BigQuery**

**反射メモ**
ログ転送は自作しない
**Sink**

---

## Q13

**問**
多数プロジェクトの監査ログを3年間、安く保管したい。どこへ出す？

**答**
**Coldline Storage へ Sink**

**論点**
長期保管・低頻度アクセス
= **Cloud Storage Coldline/Archive**

**反射メモ**
長期ログ保管 = **GCS Coldline**

---

## Q14

**問**
3層アプリを1プロジェクト内に、低コスト・低運用で強く分離したい。どう組む？

**答**
**1つの custom VPC /16 + 3つの subnet + subnetベースFirewall**

**論点**
同一PJT内3層分離 = **単一VPC + 複数subnet**

**反射メモ**
分けすぎるな
**VPC分割より subnet分離**

---

## Q15

**問**
Pub/Sub から Cloud Run に Google推奨でメッセージ処理させるには？

**答**
**Push subscription + Cloud Run Invoker 付き service account**

**論点**
Cloud Run に Pub/Sub 通知
= **Push**

**反射メモ**
Pub/Sub → Run = **Push + Invoker**

---

## Q16

**問**
複数サービスのコストを詳細分析し、自由なダッシュボードを作りたい。何を使う？

**答**
**Cloud Billing Export to BigQuery + Looker Studio**

**論点**
高度なコスト分析 = **Billing Export → BQ → Looker Studio**

**反射メモ**
請求の可視化 = **BQ + Looker Studio**

---

## Q17

**問**
特定VM上の Apache の egress コストだけが月100ドル超えたら通知したい。どうする？

**答**
**Billing Export to BigQuery + Cloud Function + Cloud Scheduler**

**論点**
特定リソース単位の請求監視は Budget だけでは足りない
= **BQ分析**

**反射メモ**
細かい請求監視 = **BQ export**

---

## Q18

**問**
PostgreSQL互換を保ちつつ、巨大規模・高書き込み・グローバル拡張に対応したい。何へ移行？

**答**
**Spanner**

**論点**
超大規模・高整合・水平スケールRDB
= **Spanner**

**反射メモ**
small / single-region なら Cloud SQL/AlloyDB寄り
超大規模なら **Spanner**

---

## Q19

**問**
GKEクラスターを、新機能追加時にもノード自動増減できるようにしたい。何を設定？

**答**
**Node pool autoscaling（Cluster Autoscaler）**

**論点**
インフラ側の自動拡張 = **Cluster Autoscaler**

**反射メモ**
HPAはPod数
CAはNode数

---

## Q20

**問**
新規プロジェクトで gcloud から Compute Engine VM を作る前の必須前提は？

**答**
**compute.googleapis.com API を有効化**

**論点**
まずAPI Enable

**反射メモ**
新規PJTで最初に疑う
= **API Enable**

---

## Q21

**問**
Cloud Run から、公開せずに GKE の内部エンドポイントへ Google推奨で接続するには？

**答**
**Internal Application Load Balancer + Cloud DNS + Serverless VPC Access**

**論点**
Cloud Run → private GKE
= **内部LB + VPC Access**

**反射メモ**
Cloud Run から内部サービス = **Serverless VPC Access**

---

## Q22

**問**
Cloud Storage の Standard オブジェクトで、30日より古い画像を自動で安くしたい。どうする？

**答**
**Lifecycle rule で Archive へ移行**

**論点**
古いオブジェクトの自動コスト最適化 = **Lifecycle**

**反射メモ**
時間経過で自動処理 = **Lifecycle policy**

---

## Q23

**問**
自社ドメインのGoogleアカウントだけを許可し、部門ごとにリソース分離もしたい。最小運用は？

**答**
**Google Groups + IAM + Organization Policy でドメイン制限**

**論点**
部門権限 = **Group**
社外禁止 = **Org Policy**

**反射メモ**
人に付与しない
**Groupに付与**

---

## Q24

**問**
Cassandra の開発環境を各チームへ最速・最小サポートで配りたい。どうする？

**答**
**Cloud Marketplace の Cassandra イメージを使う**

**論点**
既製ソフトを早く配る
= **Marketplace**

**反射メモ**
すぐ使いたい既成ソフト = **Marketplace**

---

## Q25

**問**
既存チームと独立した環境を、新しいチーム用に作りたい。何をする？

**答**
**新しい Project を作る**

**論点**
独立した境界 = **Project**

**反射メモ**
独立管理 = **New Project**

---

## Q26

**問**
VM の CPU が 90% を超えたらメール通知したい。標準的な方法は？

**答**
**Cloud Monitoring Alert Policy + Email notification**

**論点**
CPU監視 = **Cloud Monitoring**

**反射メモ**
監視スクリプト自作しない
**Monitoring**

---

## Q27

**問**
Cloud Spanner の中身は見せず、運用チームに監視だけさせたい。何のロール？

**答**
**roles/monitoring.viewer**

**論点**
環境監視だけ = **monitoring.viewer**

**反射メモ**
DB見るな、監視だけ
= **Monitoring Viewer**

---

## Q28

**問**
Cloud Spanner のノード数をトラフィックに応じて自動で増減したい。どう組む？

**答**
**Cloud Monitoring alert → webhook → Cloud Function → Spanner resize**

**論点**
Spanner 自動スケーリングは、標準で完全自動ではなく
**監視 + Function** で組む

**反射メモ**
Spanner自動増減 = **Alert + Function**

---

## Q29

**問**
社員の個人Googleアカウントと会社アカウントが衝突しそう。Google推奨は？

**答**
**既存Googleアカウントの transfer を案内する**

**論点**
アカウント競合時は **account transfer**

**反射メモ**
競合アカウント = **transfer**

---

## Q30

**問**
別プロジェクトの BigQuery dataset を、App Engine の default SA で読みたい。何を頼む？

**答**
**相手プロジェクト側で、App Engine default SA に BigQuery Data Viewer を付与**

**論点**
別PJTアクセス = **リソース側で付与**

**反射メモ**
横断PJT IAM = **相手側で付与**

---

## Q31

**問**
オンプレアプリから GCP API に接続するため、サービスアカウントを使って認証したい。どうする？

**答**
**サービスアカウントの key file を作成して使う**

**論点**
この問題文では古典的な **SA key** を求めている

**反射メモ**
ただし実務では、これは今はやや古く、鍵レス方式の方が推奨されやすい

---

## Q32

**問**
Flaskダッシュボード + API + 定期処理を、サーバーレスで最小運用にしたい。どう分ける？

**答**
**App Engine + Cloud Run + Cloud Tasks → Cloud Run**

**論点**
Webフロント = App Engine
API = Cloud Run
定期処理 = serverless 実行基盤へ

**反射メモ**
全部サーバーレスに寄せる

---

## Q33

**問**
GKEノードを公開せず、ノード整合性も確保し、運用負荷も減らしたい。何を作る？

**答**
**Private Autopilot cluster**

**論点**
非公開ノード + 低運用
= **Private Autopilot**

**反射メモ**
安全で楽 = **Private Autopilot**

---

## Q34

**問**
単一リージョンの Cloud Spanner で、最短で性能改善したい。何をする？

**答**
**65% high-priority CPU を目安に alert を作り、超えたら node を増やす**

**論点**
Spanner の最短性能改善 = **node追加**

**反射メモ**
まず即効性
= **scale out**

---

## Q35

**問**
新インフラの月額費用を正確に見積もる最短手段は？

**答**
**Pricing page を確認し、Google Cloud Pricing Calculator を使う**

**論点**
費用試算 = **Pricing Calculator**

**反射メモ**
まず計算機

---

## Q36

**問**
請求書データを5年保持・最大5世代保存・1年後に安い層へ移したい。GCSでどう組む？

**答**
**Object versioning + Lifecycle conditions**

**論点**
世代保持 = **Versioning**
自動移行/削除 = **Lifecycle**

**反射メモ**
Versioning と Lifecycle は別役割

---

## Q37

**問**
Dataproc と同じ subnet の IP が足りない。最小手数で VM 用IPを増やすには？

**答**
**既存 subnet を /25 から /24 に拡張**

**論点**
IP枯渇 = **expand-ip-range**

**反射メモ**
新VPCを作る前に
**subnet拡張**

---

## Q38

**問**
gcloud CLI で、今後の GKE 対象クラスタを chat-prod に固定したい。何を打つ？

**答**
**gcloud config set container/cluster chat-prod**

**論点**
GKEデフォルトクラスタ設定

**反射メモ**
cluster固定 = **gcloud config set**

---

## Q39

**問**
大量画像の読み取りで、zonal SSD persistent disk がスロットルされる。最大読取性能を安く得るには？

**答**
**Local SSD に移行**

**論点**
最高スループット = **Local SSD**

**反射メモ**
最速I/O = **Local SSD**
ただし永続性注意

---

# ここまでの頻出反射まとめ

```text
メモリ偏重             → Custom machine
オンプレ秘密接続       → restricted.googleapis.com
長期鍵回避ローカル検証 → SA impersonation
オンプレNAS移行        → Storage Transfer Service
大規模学習基盤         → GKE + GPU/TPU
請求一本化             → Billing Account付け替え
単一Podサイズ調整      → VPA
GKE即ロールバック      → kubectl rollout undo
ログ分析               → Log Sink → BigQuery
長期ログ保管           → GCS Coldline/Archive
Cloud RunへPub/Sub     → Push subscription
別PJTアクセス          → 相手側でIAM付与
IP不足                 → subnet expand-ip-range
最高I/O                → Local SSD
```

---

# 問題40

## ノイズ除去

```
GKE workload
CPU / Memory不明
コスト最適化
```

## 論点

```
resource recommendation
```

## 一問一答

Q
PodのCPU / memoryの最適値を提案する仕組みは？

A

```
Vertical Pod Autoscaler (recommendation mode)
```

## 覚える形

```
Pod resource suggestion
→ VPA
```

追加

```
HPA = replica scaling
VPA = resource tuning
```

---

# 問題41

## ノイズ除去

```
VM
Cloud Storage file
他VMアクセス禁止
```

## 論点

```
instance-specific access
```

## 一問一答

Q

```
1 VMだけGCSアクセス
```

A

```
専用Service Account
```

## 覚える形

```
VMごと権限
→ 専用Service Account
```

---

# 問題42

## ノイズ除去

```
VM + Cloud SQL
コスト見積
```

## 論点

```
cost estimation
```

## 一問一答

Q

```
GCP cost estimate
```

A

```
Pricing Calculator
```

## 覚える形

```
コスト見積
→ Pricing Calculator
```

---

# 問題43

## ノイズ除去

```
大量データ
頻繁アクセス
Boston
低コスト
```

## 論点

```
storage class
```

## 一問一答

Q

```
頻繁アクセス storage
```

A

```
Standard Storage
```

## 覚える形

```
頻繁アクセス
→ Standard
```

参考

```
Nearline = 月1
Coldline = 年1
Archive = 長期保存
```

---

# 問題44

## ノイズ除去

```
新機能
一部ユーザーだけ
```

## 論点

```
canary release
```

## 一問一答

Q

```
App Engine traffic split
```

A

```
version + traffic splitting
```

## 覚える形

```
canary
→ App Engine traffic split
```

---

# 問題45

## ノイズ除去

```
Bigtable
PII
全操作ログ
SIEM
```

## 論点

```
audit logging export
```

## 一問一答

Q

```
Audit logs → external SIEM
```

A

```
Cloud Logging sink → Pub/Sub
```

## 覚える形

```
log export
→ Pub/Sub sink
```

---

# 問題46

## ノイズ除去

```
PostgreSQL
ACID
最小変更
```

## 論点

```
PostgreSQL migration
```

## 一問一答

Q

```
Postgres → GCP
```

A

```
Cloud SQL
```

## 覚える形

```
Postgres
→ Cloud SQL
```

---

# 問題47

## ノイズ除去

```
kubectl get nodes
別cluster見たい
```

## 論点

```
cluster context
```

## 一問一答

Q

```
別GKE cluster操作
```

A

```
gcloud container clusters get-credentials
```

## 覚える形

```
kubectl cluster切替
→ get-credentials
```

---

# 問題48

## ノイズ除去

```
service account key
1日有効
中央管理
```

## 論点

```
org policy
```

## 一問一答

Q

```
SA key lifetime制御
```

A

```
Organization Policy
```

## 覚える形

```
SA key policy
→ Org Policy
```

---

# 問題49

## ノイズ除去

```
CI/CD
IaC
最小権限
```

## 論点

```
pipeline IAM
```

## 一問一答

Q

```
CI/CD IAM best practice
```

A

```
pipelineごと service account
```

## 覚える形

```
CI/CD
→ SA per pipeline
```

---

# 問題50

## ノイズ除去

```
SSL TCP
443
global users
低遅延
```

## 論点

```
global TCP load balancer
```

## 一問一答

Q

```
SSL TCP load balancing
```

A

```
SSL Proxy Load Balancer
```

## 覚える形

```
SSL TCP
→ SSL Proxy LB
```

---

# 実はこの模試の50問

論点は **たった11個**しかありません。

この模試の核心：

```
Compute Engine
IAM
GKE autoscaling
Cloud Storage lifecycle
Logging export
Load balancing
Pricing
Serverless
Database選択
Networking
Org policy
```


ーーー

## GKE
### 🏗️ GKE 構造図：階層構造のコンセプト

```text
 [ GKE Cluster (全体) ]
  |
  +-- [ Node Pool (土台の集まり) ]  <--- 【Cluster Autoscaler (CA)】が「Nodeの数」を増減
       |
       +-- [ Node (VM/サーバー) ]  # CPU: 4, RAM: 16GB などの物理枠
            |
            +-- [ Pod (アプリの箱) ] <--- 【HPA】が「Podの数」を増やす
            |    |                     【VPA】が「Podのサイズ」を太らせる
            |    +-- [ Container ] (実体のプログラム)
            |
            +-- [ Pod ]
            |
            +-- ( 空きスペース ) <--- ここがなくなると新機能(Pod)が置けない！

```

---

### ⚙️ 3大スケーラー：コンセプト比較

試験で迷ったときは、このAAの「どこが動いているか」を思い出してください。

#### **1. HPA (Horizontal Pod Autoscaler)**

「アクセスが多いから、中身（おかず）を増やそう！」

```text
[ Node ]
  [Pod] ➔ [Pod][Pod][Pod]  (横に増殖)

```
#### **2. VPA (Vertical Pod Autoscaler)**

「中身（おかず）がデカすぎて入らない、設定を変えよう！」

```text
[ Node ]
  [pod] ➔ [ POD ]  (縦・サイズに膨張)

```

#### **3. CA (Cluster Autoscaler / Node Pool Autoscaling)**

「もうお弁当箱（Node）がいっぱいだ！箱を追加しろ！」

```text
[ Node ] [ Node ] ➔ [ Node ][ Node ] + [ Node ]  (箱そのものを追加)

```

---

### 💡 コンセプト・チェック（反射メモ）

* **Node (ノード)** = **「不動産（土地）」**。足りなくなったら **Cluster Autoscaler**。
* **Pod (ポッド)** = **「住人（アプリ）」**。数が増えるなら **HPA**、サイズが変わるなら **VPA**。


---


GKE（Kubernetes）における「運用スタイル（Autopilot vs Standard）」と「露出（Private vs Public）」の論点を、エンジニアの直感に刺さるAAで汎用的に整理します。

---


## コンセプト図：VPAの3つのモード

VPAには「どう適用するか」によって論点が分かれます。試験では特に「提案（Suggestion/Recommendation）」がキーワードになります。

```text
 [ 実際の使用量 ]  <--- 常に監視
      |
 [ VPA (Vertical Pod Autoscaler) ]
      |
      +-- (1) 【Off / Recommendation mode】 ★Q40の正解
      |    ➔ 「これくらいが最適ですよ」とアドバイスだけ出す。
      |       (アプリは止まらない。一番安全。)
      |
      +-- (2) 【Initial mode】
      |    ➔ Podが新しく作られる時だけ、最適値をセットする。
      |
      +-- (3) 【Auto mode】
           ➔ 稼働中のPodを「再起動」させて、無理やりサイズを変える。
              (ダウンタイムが発生する可能性があるため、注意が必要。)

```

---

### 🧠 深掘り論点：なぜ HPA ではなく VPA なのか？

ここが試験で最も混同しやすいポイントです。

* **HPA (Horizontal)**:
* **論点:** 「行列が長いから、**レジ（Pod）の数**を増やそう」
* **キーワード:** `CPU utilization is high`, `Increase replicas`.


* **VPA (Vertical)**:
* **論点:** 「レジ1台の処理能力が不明、または**レジ（Pod）自体のスペック**が合っていない」
* **キーワード:** `Unknown resource requirements`, `Optimize resource limits`, `Recommendation`.



---

### 💡 コンセプト・ハック（汎用論点）

| 状況 | 推奨される機能 |
| --- | --- |
| **適切なCPU/メモリ量がわからない** | **VPA (Recommendation)** |
| **トラフィックに応じてPodを増やしたい** | **HPA** |
| **Podを載せるサーバーが足りない** | **Cluster Autoscaler (CA)** |
| **コストを最適化したい（提案が欲しい）** | **VPA** |

---

### 💡 試験での「反射メモ」

* **Resource Recommendation / Suggestion** ➔ **VPA**
* **Without disrupting workloads** ➔ **VPA (Off/Recommendation mode)**
* ※Auto modeだとPodが再起動して「disruption（中断）」が発生するため。



#### **🗣️ 音読用：脳内同期スクリプト**

> 「Podの **サイズ（CPU/メモリ）** に迷ったら **VPA**。
> **おすすめ（Recommendation）** を聞いて、無駄を削れ。
> 数を増やすのが **HPA**。
> 中身を太らせる（または絞る）のが **VPA**。
> **リソースの最適値 ＝ VPA**。このドットを繋げろ。」

「コスト最適化 ＋ 適切なリソース量が不明」というセットが来たら、迷わずVPA（特にRecommendation）を選んでください。
---


## 🏗️ GKE 構成の汎用マトリックス（AA版）

```text
【 運用の手間（Management Overhead） 】

     (楽)  ▲
          |
Autopilot |  [ 📦 A: 安全な要塞 ]      [ ⚠️ B: 露出した箱 ]
          |  (Private Autopilot)      (Public Autopilot)
          |   ※試験の「正解」率 80%    ※中途半端な設定
          |
----------+--------------------------+--------------------------▶
          |
 Standard |  [ 🛠️ C: 職人の工房 ]      [ 💣 D: 危険な戦場 ]
          |  (Private Standard)       (Public Standard)
          |   ※細かい制御が必要な時     ※最も避けるべき設定
          |
     (苦)  ▼
          +------------------------------------------------------
             (内) Private <---------- (外) Public  【 露出度 】

```

---

### 🧠 コンセプト・ハック（汎用論点）

試験で「GKE」という単語が出たら、この2軸のどこに該当するかを瞬時に判断してください。

#### **1. 運用軸：どっちで楽をするか？**

* **Autopilot (推奨)**:
* コンセプト：**「サーバーレス感覚のK8s」**。
* ノードの管理、OSのパッチ、セキュリティ設定（Shielded Nodes）は全部Google任せ。
* キーワード：`Minimal overhead`, `Operational efficiency`, `Best practices`.


* **Standard (例外)**:
* コンセプト：**「自作PC・職人魂」**。
* 特殊なOS、特定のGPU、ノードサイズの細かい指定が必要な場合のみ選択。
* キーワード：`Granular control`, `Specific node configuration`, `Custom OS`.



#### **2. ネットワーク軸：どこまで隠すか？**

* **Private (推奨)**:
* コンセプト：**「地下シェルター」**。
* ノードにパブリックIPを持たせない。外からは見えない。
* キーワード：`Not accessible from internet`, `Security`, `Internal only`.


* **Public (回避)**:
* コンセプト：**「路上の屋台」**。
* ノードが外に晒されている。踏み台（Bastion）やVPNなしで触れるが危険。



---

### 💡 試験での「反射メモ」

| 求められていること | 選ぶべき正解 |
| --- | --- |
| **「安全で楽（Best Practice）」** | **Private Autopilot** |
| **「細かく制御したい」** | **Standard** |
| **「コストを極限まで削りたい（中断可能VM等）」** | **Standard** |
| **「インターネットから隠したい」** | **Private** |

#### **⚠️ 逆パターン（毒）の見分け方**

* 問題に「Security」や「Managed」と書いてあるのに、選択肢に **"Public"** や **"Standard"** が混じっていたら、それは「毒」です。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「楽をしたいなら **Auto**。
> いじり倒したいなら **Standard**。
> 外に出すのは **Public**（危険）。
> 中に隠すのは **Private**（安全）。
> 最強の組み合わせは **Private Autopilot**。
> これがGoogleの『正解』という名の型だ。」

---




## Cloud Run から VPC 内部への道

```text
 [ Cloud Run (外側の世界) ]  # サーバーレス
          |
  [ Serverless VPC Access ]  <--- 【Connector/架け橋】
          |
 [ VPC Network (内側の世界) ] # 閉じた社内LAN
          |
  [ Internal HTTP(S) LB ]    <--- 【入り口/受付】
          |
 [ GKE Service (内部Pod) ]   <--- 【ゴール】

```

---

### 🧠 コンセプト・チェック：なぜこの組み合わせ？

1. **Serverless VPC Access (Connector)**:
* **コンセプト**: Cloud Run は本来、Google の共有ネットワークにいます。あなたの会社の VPC（GKE がある場所）には直接入れません。
* **役割**: この「コネクタ」が、Cloud Run から VPC 内部へ安全に潜り込むための**専用トンネル**になります。


2. **Internal Application Load Balancer**:
* **コンセプト**: GKE の中にあるサービスに、VPC 内部からアクセスするための「固定の窓口」です。
* **役割**: 公開（External）ではなく、**内部（Internal）**にすることでインターネットには一切出しません。


3. **Cloud DNS**:
* **コンセプト**: IP アドレス（`10.x.x.x`）ではなく、名前（`api.internal`）で呼び出せるようにします。
* **役割**: 運用を楽にするための「住所録」です。



---

### 💡 コンセプト重視の「反射メモ」

* **Cloud Run / Functions** から **VPC 内部（GCE/GKE/SQL）** に触りたい ➔ **Serverless VPC Access** が必須。
* **公開したくない** ➔ **Internal（内部）** ロードバランサ。

#### **⚠️ 毒（誤答）の見分け方**

* 「Cloud Armor で守って公開する」➔ **「Not expose to public（公開しない）」** という条件に反するので「毒」。
* 「VPC Peering」➔ Cloud Run は VPC ではないので、Peering はできません。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「Cloud Run から **中（VPC）** に入りたい？
> ならば **Serverless VPC Access** というトンネルを掘れ。
> 行き先は **Internal（内部）LB**。
> これで外には一歩も出さない。
> **Cloud Run ➔ VPC 内 ＝ Connector**。このドットを繋げろ。」
---



## 🍱 Lifecycle vs. Retention：コンセプト図

```text
 [ Cloud Storage Bucket ]
  |
  +-- 【Lifecycle Policy (一生の世話)】 ➔ 「節約・整理」
  |    |  (30日経った？) ➔ 「安い部屋(Archive)へ引っ越しなさい」
  |    |  (1年経った？)  ➔ 「もう不要だから捨てなさい(Delete)」
  |    |
  +-- 【Retention Policy (監禁・保護)】 ➔ 「防衛・コンプライアンス」
       |  (設定：3年)    ➔ 「何があっても、3年間は絶対に捨てさせない！」
       |                   (管理者ですら消せなくなる「Lock」が可能)

```

---

### 🧠 コンセプトの違い：比較表

| 特徴 | **Lifecycle (ライフサイクル)** | **Retention (リテンション)** |
| --- | --- | --- |
| **目的** | **コスト削減**・自動整理 | **データの保護**・法規制遵守 |
| **主なアクション** | **Archive（移動）** または Delete | **Delete禁止（ロック）** |
| **ACEのキーワード** | `Minimize costs`, `Older than X days` | `Compliance`, `Must be retained for X years` |
| **イメージ** | **「お掃除ロボット」** | **「金庫のタイマー」** |

---

### 🔍 なぜ Q22 は Lifecycle なのか？

問題文に **「minimize costs by automatically managing older images」** とあります。

1. **目的:** コストを最小化したい（＝安いクラスへ移動）。
2. **手段:** 30日経ったら自動でやってほしい。
3. **解決策:** **Lifecycle Policy** で `SetStorageClass` を `ARCHIVE` にする。

---

### ⚠️ 毒（誤答）の見分け方

* **「Retention Policy を設定する」** ➔ これは「消さないこと」を保証するだけなので、**安く（Archiveへ移動）はしてくれません。** むしろ高い Standard のまま課金が続くので「毒」です。
* **「Cloud Functions で消す」** ➔ 標準機能（Lifecycle）があるのに、わざわざコードを書くのは「運用負荷（Operational overhead）」が高いので「毒」。

---

### 🗣️ 音論用：脳内同期スクリプト

> 「時間が経ったら **安く** したい？
> ならば **Lifecycle（ライフサイクル）** の出番だ。
> クラスを **Standard ➔ Archive** へ自動で落とせ。
> **時間経過 ＋ 節約 ＝ Lifecycle**。このドットを繋げろ。」
---



その違和感、鋭いです！問題文の **「in a separate project」** という表現を見逃すと、ただの自プロジェクト内の権限設定だと思ってしまいます。

もう一度、問題文の「別プロジェクト」を指し示している「犯行現場（キーワード）」を特定しましょう。

---

### 🔍 Q30：別プロジェクトを見分ける「英語の罠」

> 「The dataset you need to visualize is stored **in a separate project**, which is **controlled by a different team**.」

* **in a separate project**: 「別の（隔離された）プロジェクト」
* **controlled by a different team**: 「別のチームが管理している（＝自分にオーナー権限がない）」

この2フレーズが出てきたら、**「あ、隣の家のドアを開けなきゃいけないんだな」**と脳内を切り替えてください。

---

## コンセプト図：クロスプロジェクトIAM

```text
 [ あなたのプロジェクト (Project A) ]         [ 相手のプロジェクト (Project B) ]
  |                                          |
  +-- [ App Engine ]                         +-- [ BigQuery Dataset ]
        | (実行中)                             |
        +-- [ Default SA ] ------------------→ [ 権限の門 ] 
                                             |
                                             ★ ここで許可が必要！
                                               (BigQuery Data Viewer)

```

---

### 🧠 なぜ「相手側」で設定するのか？（コンセプト重視）

GCPのセキュリティ（IAM）は、**「リソースを持っている主人が、誰を家に入れるか決める」**という原則があります。

* **自分のプロジェクト設定を変える（選択肢C）**: 自分の家のルールを変えても、隣の家のドアは開きません。
* **相手に頼んで設定してもらう（選択肢B）**: 隣の家の主人（相手チーム）に、「うちのSA（メールアドレス）を通行証として登録してくれ」と頼むのが正解です。

---

### 💡 コンップト重視の「反射メモ（修正版）」

* **Separate project / External project** ➔ **「相手側の IAM 画面」**でポチる。
* **Controlled by different team** ➔ 自分じゃできないから**「相手に頼む（Ask them to grant）」**。

「別PJTだと気づけるかどうか」が、この問題の唯一の難所です。
**"separate"** または **"different project"** という単語を、スキャナーのように探し出す訓練をしましょう！
---

その迷い、実は非常にハイレベルな視点です。**「Host（置く）」**と**「Migrate（移設する）」**は、試験においては「どこに最終着地させるか（基盤の選定）」という意味では似ていますが、Q32のポイントは**「それぞれのサービスの得意分野（ワークロード特性）」**を見抜けるかどうかにあります。

---

## コンセプト図：サーバーレス三銃士の使い分け

```text
 [ ユーザー ] 
    |
    +-- (1) Webフロント (Flask) ➔ [ App Engine ] 
    |    # 特徴: セッション維持やWeb特有の管理が得意。「Webサイト」ならこれ。
    |
    +-- (2) モバイルAPI ➔ [ Cloud Run ]
    |    # 特徴: 高速、軽量、コンテナ。ステートレスな「API」のデフォ。
    |
 [ スケジューラー ]
    |
    +-- (3) 定期処理 ➔ [ Cloud Tasks ] ➔ [ Cloud Run ]
         # 特徴: 時間になったら Cloud Run を叩き起こして処理させる。

```

---

### 🧠 なぜ「App Engine」と「Cloud Run」を分けるのか？（コンセプト重視）

「全部 Cloud Run でも動くじゃないか」と思うかもしれませんが、Google 認定試験（ACE）には**推奨の「住み分け」**があります。

1. **App Engine (Standard)**:
* **コンセプト:** **「Web アプリのゆりかご」**。
* Flask や Django などのフルスタックな Web ダッシュボードは、App Engine の方が「バージョン管理」や「スプリットテスト」が標準機能で付いてくるので楽、という思想です。


2. **Cloud Run**:
* **コンセプト:** **「コンテナの瞬発力」**。
* API のように、リクエストが来たら一瞬で立ち上がって処理して消えるワークロードに最適です。


3. **Cloud Tasks**:
* **コンセプト:** **「キュー（待ち行列）とタイマー」**。
* これ単体で処理をするのではなく、**「Cloud Run を実行するトリガー」**として使います。



---

### 🔍 「Host」と「Migrate」の迷いについて

選択肢 C, D の **「Host the customer dashboard on a Cloud Storage bucket」** が「毒」である理由をコンセプトで叩き込みましょう。

* **Cloud Storage:** **「静的（Static）」**なファイル（HTML/CSS/画像）しか置けません。
* **Flask:** **「動的（Dynamic）」**なサーバーサイド処理が必要です。
* **結論:** Flask を Storage に Host することは**物理的に不可能**です（Python が動かないから）。なので、「Host on Storage」が見えた瞬間に除外して OK です！

---

### 💡 コンセプト重視の「反射メモ（修正版）」

* **Flask / Django (Webサイト)** ➔ **App Engine** (ゆりかご)
* **Microservices / API (コンテナ)** ➔ **Cloud Run** (瞬発力)
* **定期処理のスケジュール** ➔ **Cloud Tasks** (呼び出し鈴)
* **全部まとめて** ➔ **サーバーレス (運用コスト最小)**

#### **🗣️ 音読用：脳内同期スクリプト**

> 「Webサイトなら **App Engine**。
> APIなら **Cloud Run**。
> 定期実行は **Cloud Tasks** で Run を叩け。
> **VM (Compute Engine)** が混じってたら、運用コストが上がるから『毒』だと思え。」
---

Spanner の「65%」という数字には、Google が推奨する**「安全マージン（予備の余力）」**という明確なコンセプトがあります。

結論から言うと、**「何かあった時（ノード故障や急なスパイク）に、システムを落とさないためのデッドライン」**だからです。

---

## 🏗️ なぜ「65%」なのか？：コンセプト図 閾値

```text
 [ Spanner ノードの CPU 使用率 ]

 100% |----------------------------| 
      | [ 🔴 危険地帯 ]             |  ← ここに達するとクエリが目に見えて遅延・失敗する
  80% |----------------------------| 
      | [ 🟡 警戒地帯 ]             |  ← マルチリージョンの推奨値
  65% |----------------------------|  ★ シングルリージョンの「推奨上限」
      |                            |
      | [ 🟢 安全地帯 ]             |  ← ここをキープするのが運用の正解
   0% |----------------------------|

```

---

### 🧠 3つの技術的理由

1. **ノード故障への備え（可用性）**:
* シングルリージョンの Spanner は、内部で 3 つのゾーンに分散されています。
* もし 1 つのゾーンが死んでも、残りのノードで処理を引き継がなければなりません。
* **65% 以下に抑えておけば、1 つのゾーンが欠けても残りのリソースで 100% を超えずに耐えられる**という計算です。


2. **優先度の管理 (High-priority CPU)**:
* Spanner は「クエリ（読み書き）」と「バックグラウンド処理（データの整理）」を同じ CPU でやります。
* ユーザーのクエリ（High-priority）が 65% を超えると、バックグラウンド処理が追いつかなくなり、結果としてデータベース全体のパフォーマンスが急激に悪化します。


3. **最短（Shortest time）での解決策**:
* クエリの書き直しやインデックスの設計変更は、検証に時間がかかります。
* **「ノードを増やす（Scale out）」**のはボタン一つで即座に完了するため、試験で「最短で（Shortest time/Immediately）」と聞かれたら、この物理ボタンをポチるのが正解になります。



---

### 💡 試験での「反射メモ」

* **Spanner CPU 65%** ➔ **「シングルリージョン」**の限界値
* **Spanner CPU 45%** ➔ **「マルチリージョン」**の限界値（より厳しいのは、より広い範囲の故障に備えるため）
* **最短のパフォーマンス改善** ➔ **ノード追加（物理で殴る）**

#### **⚠️ 毒（誤答）の見分け方**

* 「80% や 90% で通知する」➔ 遅すぎます。Spanner の世界では 65% が「黄色信号」です。
* 「クエリを最適化する」➔ 正論ですが「最短（Shortest time）」ではないので、この問題では「毒」になります。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「Spanner が重い？
> ならば **65%** という数字を思い出せ。
> 余裕があるうちに **ノードを追加** して、物理で解決しろ。
> クエリを直すのは、その後の話だ。
> **最短 ＋ Spanner ＝ ノード追加（65%アラート）**。」
---


## 🏗️ コスト計算・管理のコンセプト図（AA版）

```text
 【 フェーズ 】          【 使うべきツール・手法 】
      |
  1. 導入前 (設計)  ----▶  [ 🧮 Pricing Calculator ]
      |                   ※ 正確な見積もり。自作スプレッドシートは「毒」。
      |
  2. 運用中 (監視)  ----▶  [ 📊 Billing Reports ] 
      |                   ※ 現在の支出を確認。
      |
  3. 分析 (役員報告) ----▶  [ 🔍 BigQuery Export + Looker Studio ]
      |                   ※ 詳細な分析、カスタムグラフ。
      |
  4. 防衛 (予算管理) ----▶  [ 🚨 Budgets & Alerts ]
                          ※ 予算超過の通知。

```

---

### 🧠 コスト計算系の「4大論点」まとめ

#### **1. 見積もり（導入前）**

* **論点:** 新規プロジェクトの月額費用を算出したい。
* **正解:** **Pricing Calculator** を使う。
* **毒:** 「1週間だけ動かして4倍する（Q35-C）」➔ スパイクや月額固定費を無視するのでNG。
* **毒:** 「自分で計算表を作る（Q35-B）」➔ 最新価格の反映漏れや計算ミスのリスクでNG。

#### **2. 詳細分析（運用中）**

* **論点:** 「どのラベルの、どのサーバーが、いくら使ったか」を詳細に視覚化したい。
* **正解:** **Billing Export to BigQuery + Looker Studio**。
* **理由:** 標準のコンソール画面では限界があるため、データをBQに投げてBIツール（Looker）で叩くのが公式の「型」。

#### **3. 予算超過の防止（防衛）**

* **論点:** $1,000を超えたら管理者にメールしたい。
* **正解:** **Budgets and Alerts**。
* **注意:** デフォルトでは「メールを飛ばすだけ」で、**リソースを自動停止はしません。**（停止させたいならPub/Sub+Functionsが必要）。

#### **4. 割引の適用（最適化）**

* **論点:** 1年〜3年使うことが決まっている。
* **正解:** **Committed Use Discounts (CUDs)**。
* **論点:** 24時間つけっぱなしにする。
* **正解:** **Sustained Use Discounts (SUDs)**（自動適用）。

---

### 💡 試験での「コスト反射メモ」

| 状況 | 選ぶべきキーワード |
| --- | --- |
| **見積もりたい** | **Pricing Calculator** |
| **詳細に分析・グラフ化したい** | **BQ Export + Looker Studio** |
| **予算を超えたら知りたい** | **Budget Alerts** |
| **特定サービスの通信費だけ知りたい** | **BQ Export + Functions** (Q17のパターン) |

---

### 🗣️ 音読用：脳内同期スクリプト

> 「費用が知りたい？
> ならば **Pricing Calculator** のページを開け。
> 分析したいなら **BigQuery** にエクスポートして **Looker** で見ろ。
> 自分の勘やスプレッドシートに頼るな。
> **公式ツールこそが唯一の正解だ。**」
---




## 🏗️ gcloud 設定管理の汎用マトリックス

```text
【 gcloud 操作の 3 階層 】

層 1: [ 🏠 Configuration (環境の切り替え) ]  <-- `gcloud config configurations`
      |   (例: "prod-env", "dev-env" というセット丸ごと切り替え)
      |
層 2: [ 🧠 Config Set (今の脳内の書き換え) ] <-- `gcloud config set` ★Q38はここ
      |   (例: 「これからは project=A、cluster=B を見ろ」と教え込む)
      |
層 3: [ 🛠️ Resource Update (実体の改造) ]    <-- `gcloud [service] update`
          (例: 「実際のGKEクラスタにノードを追加しろ」と命じる)

```

---

### 🧠 汎用論点：コマンドの使い分け

試験では以下の3つの動詞（Verb）を使い分けるだけで、ほぼ全ての `gcloud` 設定問題が解けます。

| 目的 | 動詞 (Verb) | 反射キーワード |
| --- | --- | --- |
| **デフォルト値を固定したい** | **`set`** | `gcloud config set ...` |
| **設定を丸ごと切り替えたい** | **`activate`** | `gcloud config configurations activate ...` |
| **今の設定値を忘れた・見たい** | **`list`** | `gcloud config list` |

---

### 💡 コンセプト・ハック（汎用論点）

#### **1. なぜ「ファイル自作」はダメなのか？**

`gcloud` はステート（状態）を特定のディレクトリ（`~/.config/gcloud`）で厳密に管理しています。

* **手動ファイル作成**: `gcloud` SDKにとって、それは「存在しないノイズ」と同じ。
* **`config set`**: SDKが管理している「ステートファイル」を、SDKにとって正しい作法で上書きする行為。

#### **2. 自動化における「正解」**

あなたが考えた「自動化フレンドリー」を試験の文脈で正解にするなら、以下の2つになります。

* **スクリプト内で `gcloud config set` を叩く**: これが最も標準的。
* **環境変数を使う**: `export CLOUDSDK_CORE_PROJECT=my-project`。
* `gcloud` は実行時に環境変数を最優先で読みに行くため、設定ファイルを汚さずに自動化できます。



---

### 💡 試験での「反射メモ（gcloud編）」

* **「今後、常に〜を使いたい」** ➔ **`gcloud config set`**
* **「プロジェクトを A から B に変えたい」** ➔ **`gcloud config set project`**
* **「本番用と開発用の設定を使い分けたい」** ➔ **`configurations activate`**

#### **⚠️ 毒（誤答）の見分け方**

* **`gcloud container clusters update`**: これはクラスタの「中身（設定）」を変えるもので、自分のPCの「向き先」を変えるものではない。
* **`gcloud container clusters get-credentials`**: これは `~/.kube/config`（kubectl用）を更新するもので、`gcloud` 自体のデフォルト値を固定するものではない。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「gcloud の向き先（デフォルト）を変えたい？
> ならば **gcloud config set** だ。
> **何を（Property）**、**何に（Value）**。
> `container/cluster` を `chat-prod` に。
> ファイルをいじるな、コマンドを打て。
> それが SDK との正しい対話だ。」

これで `gcloud` 設定系の問題は、どんなリソース（GCE, GKE, Cloud Run）が来ても迷わなくなります。
---