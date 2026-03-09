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
