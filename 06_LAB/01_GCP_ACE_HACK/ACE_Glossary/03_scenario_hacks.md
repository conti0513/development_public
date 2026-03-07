# Appendix: GCP ACE Master Architecture Fix（最適化版）

---

# 🔴 LEVEL 0：超反射（試験当日用 1枚）

## 🧠 IAM

```
横断PJT操作？
→ リソース側でIAM付与

動かない？
→ API有効？IAM？Quota？
```

---

## 🌐 Network

```
Web + SSL終端 → HTTP(S) LB
内部のみ     → Internal LB
外向きのみ   → Cloud NAT
HTTP以外     → L4 (TCP/SSL Proxy)

VPC統制     → Shared VPC
VPC接続     → Peering（Transitive不可）
```

---

## ⚡ Serverless

```
HTTPコンテナ        → Cloud Run
イベント起動        → Eventarc
メッセージ保持      → Pub/Sub
確実実行・遅延      → Cloud Tasks
定期実行            → Scheduler
```

---

## ☸ GKE

```
Pod増やす → HPA
Node増やす → Cluster Autoscaler
Pending → 席不足（CPU/Memory）
入口固定 → Service
```

---

## 💾 Storage / DB

```
ファイル保管 → GCS
分析         → BigQuery
小規模RDB    → Cloud SQL
巨大RDB      → Spanner
キー値       → Bigtable
ドキュメント → Firestore
```

---

---

# 🟡 LEVEL 1：構造固定マップ（図で覚える層）

---

# 1️⃣ Load Balancer / Network 完全固定

## L7 vs L4

```
HTTP/HTTPS？
   YES → L7（HTTP(S) LB）
   NO  → L4（TCP / SSL Proxy）
```

---

## 外部Web（王道）

```
Client
   ↓
Global External IP
   ↓
HTTP(S) Load Balancer
   ↓
Backend Service
   ↓
MIG / GKE / Cloud Run
```

✔ SSL終端
✔ URL分岐
✔ Cloud Armor / CDN

---

## Internal LB

```
VM（VPC内）
   ↓
Internal LB
   ↓
Backend VM
```

---

## NAT（出口）

```
Private VM
   ↓
Cloud NAT
   ↓
Internet
```

✔ 受信不可
✔ Public IP不要

---

# 2️⃣ VPC / Peering / Shared VPC

## Peering

```
VPC-A <----> VPC-B
```

❌ Transitive不可

---

## Shared VPC

```
Host Project
   ↓
Shared VPC
   ↓
Service Projects
```

✔ 組織統制
✔ 中央NW管理

---

# 3️⃣ IAM 横断プロジェクト固定図

```
Project A (SA-A)
       │
       ▼
Project B (Resource)
```

✔ 権限は Project B 側で付与

---

## SA 実行構造

```
User
  ↓ (actAs)
Service Account
  ↓
Resource操作
```

---

# 4️⃣ Event 系統合

## Pub/Sub

```
Publisher
   ↓
Topic
   ↓
Subscription
   ↓
Subscriber
```

✔ メッセージ保持
✔ 再試行

---

## Eventarc

```
GCS / AuditLog
      ↓
   Eventarc
      ↓
Cloud Run / Functions(2nd gen)
```

✔ GCPイベント配線

---

# 5️⃣ Serverless 統合

```
HTTP → Cloud Run
GCP Event → Eventarc → Run/Functions
遅延・保証 → Cloud Tasks
定期 → Scheduler
```

---

# 6️⃣ GKE 固定図

```
Cluster
   ↓
NodePool
   ↓
Node
   ↓
Pod
```

---

## Autoscaler 三層

```
Cluster Autoscaler → Node数
HPA → Pod数
VPA → Podサイズ
```

略称	正式名称	イメージ
HPA	Horizontal Pod Autoscaler	**「横（Horizontal）」に増やす。負荷に合わせてPodの「台数」**を増減させる。
VPA	Vertical Pod Autoscaler	**「縦（Vertical）」に伸ばす。PodのCPU/メモリの「割り当て（サイズ）」**を最適化する。

---

## Pod / Service

```
Deployment → Pod × n
Service → 固定IP入口
```

---

# 7️⃣ Storage / DB 1枚マップ

```
File → GCS
Analytics → BigQuery
RDB小規模 → Cloud SQL
RDB大規模 → Spanner
Key-Value → Bigtable
Document → Firestore
```

---

---

# 🔵 LEVEL 2：詳細補足（深掘り層）

---

# 🔐 Cloud Run × Pub/Sub Push ベスト構成

## 構造

```
Pub/Sub (Push Subscription)
        ↓
Cloud Run（認証必須）
```

---

## 正しい設定

1. 専用 Service Account 作成
2. その SA に Cloud Run Invoker 付与
3. Pub/Sub Push に SA を指定

---

## Push vs Pull

```
Pull → 常時起動必要（非効率）
Push → 必要時のみ起動（効率的）
```

---

# 🛡 Cloud Run Invoker の正体

✔ 実行権限のみ付与
✔ Adminは不要
✔ 最小権限原則

---

# 🧊 GCS Storage Class

```
Standard → 頻繁
Nearline → 月1
Coldline → 年1
Archive → 超長期
```

✔ 最低保持期間あり

---

## Lifecycle

```
30日 → Nearline
90日 → Coldline
365日 → Archive
```

---

# 📜 Cloud SQL PITR

✔ Binary Log 有効化が必要

---

# 🌐 DNS

## Private Zone

```
App → db.internal → Cloud DNS → IP
```

✔ IP隠蔽

---

## Forwarding

```
GCP → OnPrem = Outbound
OnPrem → GCP = Inbound
```

---

---

# 🧠 最終固定まとめ

```
LBは入口
NATは出口
IAM横断はリソース側付与
Pub/Subは保持
Eventarcは配線
RunはHTTP
Tasksは保証
HPAは数
CAは席
```

---

# 🔚 この構造の利点

✔ 反射（LEVEL 0）
✔ 図で固定（LEVEL 1）
✔ 深掘り（LEVEL 2）

混ざらない。
検索しやすい。
公開にも耐える。

---

# Appendix：Architecture Visual Fix（図で固定する）

---

# 🔥 1. Load Balancer 完全固定図

## 🧠 まず分岐はこれだけ

```id="q9g7ea"
HTTP/HTTPS？
   YES → L7（HTTP(S) LB）
   NO  → L4（TCP / SSL Proxy）
```

---

## 🌍 外部向け Web（王道パターン）

```id="c3k1xp"
Client
   ↓
Global External IP
   ↓
HTTP(S) Load Balancer（L7）
   ↓
Backend Service
   ↓
MIG / GKE / Cloud Run
```

### 特徴

* SSL終端できる
* URLパス分岐できる
* Cloud Armor / CDN 使える
* グローバル

👉 「Web + SSL終端」ならこれ。

---

## 🧱 L4（非HTTP）

```id="v6h2zt"
Client
   ↓
TCP/SSL Proxy LB
   ↓
Backend VM
```

* HTTP以外のTCPアプリ
* SSL終端だけしたい

---

## 🏢 Internal Load Balancer

```id="bz8y3l"
VM（VPC内）
   ↓
Internal LB
   ↓
Backend VM群
```

* 外部公開しない
* VPC内専用

---

## 🚪 NATとの違い（混同禁止）

```id="ls8xg2"
VM（外部IPなし）
    ↓
Cloud NAT
    ↓
Internet
```

* NATは出口専用
* 受信不可
* LBではない

---

## 🎯 LB 最短判断

```id="2e4r5t"
Web公開 + SSL終端 → HTTP(S) LB
内部だけ          → Internal LB
外向き通信のみ    → NAT
HTTP以外          → L4
```

---

# 🔥 2. IAM 横断プロジェクト 1枚固定図

## 🧠 原則

```
権限は「操作される側」で付与
```

---

## 🎯 ケース図

### PJT-A の SA が PJT-B を操作

```id="q8j1mh"
[ Project A ]
    SA-A
      │
      │（API呼び出し）
      ▼
[ Project B ]
   Resource
```

### 正しい設定

```id="l4nmks"
Project B 側で
   SA-A に Role付与
```

---

## ❌ やりがちな誤り

```id="o3k2nx"
Project A 側でRole付与
   ↓
意味なし
```

---

## 🔑 Service Account 操作構造

```id="d9k1sl"
User
  ↓（actAs）
Service Account
  ↓
Resource操作
```

### 動かないときのチェック

```
1. SAにRoleある？
2. 実行者にactAsある？
```

---

## 🎯 IAM横断の超圧縮

```id="9lm3zs"
別PJT操作？
   ↓
リソース側でIAM付与
```

---

# 🔥 3. Event系 1枚統合図

## 🧠 まず役割分離

```id="t5m9kx"
Pub/Sub ＝ メッセージ保存バス
Eventarc＝ イベント配線
```

---

## 📦 Pub/Sub構造

```id="k1f9da"
Publisher
   ↓
Topic
   ↓
Subscription
   ↓
Subscriber
```

* メッセージ保持
* 再試行
* バッファリング

👉 「大量」「保持」「非同期」ならPub/Sub

---

## ⚡ Eventarc構造

```id="m4g7qp"
GCS / AuditLog / GCP Event
        ↓
     Eventarc
        ↓
Cloud Run / Functions(2nd gen)
```

* GCPイベントを拾う
* ルーティング専門
* 基本保持しない

👉 「GCPイベント起動」ならEventarc

---

## 🎯 Functions世代差

```id="x7k4vr"
1st gen → 内部的にPub/Sub寄り
2nd gen → Eventarc経由
```

---

## 🧠 使い分け超圧縮

```id="p9n2sh"
大量メッセージ処理 → Pub/Sub
GCPイベント連携     → Eventarc
```

---

# 🔥 まとめ：3大混乱ゾーン固定

```id="v8l3wr"
LBは入口
NATは出口
IAM横断はリソース側付与
Pub/Subはバス
Eventarcは配線
```

---

これで、

* LB
* IAM横断
* Event

の3大混乱ゾーンは視覚固定できる。

---

次やるなら：

了解。アペンディックスにそのまま貼れる形で、2枚だけ再提示します（マイルド語彙・1枚固定AA）。

---

# 🔥 VPC / NAT / Peering / Shared VPC：1枚統合マップ

```text
                    ┌──────────────────────────────┐
                    │            VPC               │
                    │   (Global: 社内LANの器)      │
                    └───────────┬──────────────────┘
                                │
                ┌───────────────┼───────────────────────────┐
                │               │                           │
        ┌───────▼───────┐  ┌────▼─────┐              ┌─────▼─────┐
        │   Subnet       │  │ Firewall  │              │   Routes   │
        │ (Regional住所)  │  │ (門番)     │              │ (道案内)    │
        └───────┬───────┘  └───────────┘              └────────────┘
                │
                │ (外に出たい：送信のみ)
                ▼
         ┌────────────────┐
         │   Cloud NAT     │  ← 受信はしない（出口専用）
         └───────┬────────┘
                 │
                 ▼
              Internet


VPCとVPCをつなぐ（プライベート直結）
    ┌──────────────┐        ┌──────────────┐
    │    VPC-A      │<------>│    VPC-B      │
    └──────────────┘  Peering└──────────────┘
         ※ Transitive不可（A-B, B-CでもA-Cは直結しない）


複数プロジェクトでネットワーク統制（中央集権）
               ┌────────────────────────┐
               │       Host Project      │
               │  (NW本部: VPCを持つ)     │
               └───────────┬────────────┘
                           │ Shared VPC
           ┌───────────────┼────────────────┐
           │               │                │
   ┌───────▼────────┐ ┌────▼─────────┐ ┌────▼─────────┐
   │ Service PJT-A    │ │ Service PJT-B │ │ Service PJT-C │
   │ (アプリPJT)      │ │ (アプリPJT)   │ │ (アプリPJT)   │
   └─────────────────┘ └──────────────┘ └──────────────┘
```

## 反射メモ（1行）

* 外向き送信だけ → NAT
* VPC同士直結 → Peering（Transitive不可）
* 複数PJTのNW統制 → Shared VPC（Hostが握る）

---

# 🔥 GKE 完全1枚固定（Cluster → Pod → Autoscaler）

```text
                     ┌──────────────────────────────┐
                     │            GKE Cluster        │
                     │      (Control Plane/制御)     │
                     └──────────────┬───────────────┘
                                    │
                                    │ 管理（API/スケジューリング）
                                    ▼
                         ┌───────────────────────┐
                         │       Node Pool       │  ← 同型ノード群
                         │ (min/max などを設定)   │
                         └───────────┬───────────┘
                                     │
                   ┌─────────────────┼─────────────────┐
                   │                 │                 │
             ┌─────▼─────┐     ┌────▼─────┐     ┌─────▼─────┐
             │   Node     │     │   Node    │     │   Node     │  ← = 席（VM）
             └─────┬─────┘     └────┬─────┘     └─────┬─────┘
                   │                │                 │
                   ▼                ▼                 ▼
             ┌─────────┐      ┌─────────┐       ┌─────────┐
             │   Pod    │      │   Pod    │       │   Pod    │  ← = 実体（アプリ）
             └─────────┘      └─────────┘       └─────────┘

入口を固定する（Podが入れ替わってもOK）
         ┌───────────────────────────────────┐
Client → │ Service（固定IP/名前：入口）        │ → Pod群へ
         └───────────────────────────────────┘


よくある詰まり（Pending）
  Podが起動できない → Nodeに空きがない（CPU/Memory不足） → 「席不足」
```

## Autoscaler 3点セット（ここだけ反射）

```text
HPA  = Pod数を増減（負荷でレプリカ調整）
VPA  = Podサイズを調整（CPU/Memory要求）
CA   = Node数を増減（席を増やす：Cluster Autoscaler）
```

## 反射メモ（1行）

* Podを増やす → HPA
* Node（席）を増やす → Cluster Autoscaler
* Pending → 席不足（Node側のキャパ不足）
* 入口固定 → Service

---

