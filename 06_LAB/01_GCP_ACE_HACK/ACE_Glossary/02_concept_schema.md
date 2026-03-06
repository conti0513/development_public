# GCP ACE 用語集（構造視覚版・公開向け）

---

# 🧠 0. ACEの土台

```
API有効？
   ↓
NO → 操作できない
YES → スタート
```

### API Enable

最初に確認する前提条件。

---

```
Region ＝ 地理エリア
Zone   ＝ データセンター区画
```

冗長化＝複数Zone
リージョン固定サービスあり（例：App Engine）

---

```
作成できない？
   ↓
Quota確認
```

Quota＝利用上限。

---

# 🏢 1. Resource Hierarchy（境界と継承）

```
Organization（会社）
   ↓
Folder（部門）
   ↓
Project（信頼境界）
   ↓
Resource（VM / Bucket）
```

## 重要原則

```
IAMは上位から下位へ継承
```

Projectが基本の分離単位。

---

# 🔐 2. IAM（ACEの中核）

## 基本構造

```
Principal × Role × Binding
誰が     何を      どこで
```

---

## ロールの考え方

```
Primitive（広い）
   ↓
Predefined（職務単位）
   ↓
Custom（最小権限）
```

原則：Predefinedから検討。

---

## Service Account 構造

```
人 → SAを利用（actAs）
SA → リソース操作
```

### よくある確認ポイント

```
SAに権限はある
   ↓
でも実行できない
   ↓
actAs不足の可能性
```

---

## 横断プロジェクト原則

```
権限は「操作される側」で付与
```

例：

```
PJT-AのSA
    ↓
PJT-Bのリソース操作
    ↓
PJT-B側でRole付与
```

鍵ファイル配布は避ける設計が推奨。

---

# 💰 3. Billing構造

```
Organization
    ↓
Billing Account
    ↓
Project
```

請求一本化＝Billing付け替え。

---

## コスト監視の粒度

```
プロジェクト合計 → Budget
特定サービス     → Billing Export → BigQuery
```

---

# 🌐 4. Network構造

## 全体像

```
VPC（Global）
   ↓
Subnet（Region）
   ↓
VM
```

---

## NATの位置

```
VM（外部IPなし）
     ↓
Cloud NAT
     ↓
Internet
```

NATは外向き通信のみ。

---

## Load Balancer 判断軸

### Step1

```
HTTP/HTTPS？
   YES → L7（HTTP(S) LB）
   NO  → L4（TCP/SSL Proxy）
```

---

### Step2

```
内部のみ？
   YES → Internal LB
   NO  → External LB
```

---

### まとめ

```
Web + SSL終端 → HTTP(S) LB
外向き通信    → NAT
内部向け      → Internal LB
```

---

## VPC Peering

```
VPC-A ─── VPC-B
```

A-B, B-Cでも
A-Cは直接接続されない。

---

## Shared VPC

```
Host Project
    ↓
Service Project
```

ネットワーク統制の標準設計。

---

# 💻 5. Compute構造

## MIG

```
Instance Template
        ↓
MIG
        ↓
Autohealing / Autoscaling
```

MIGが再生成を担当。

---

## Spot

```
低コスト
   ↓
停止の可能性あり
```

長時間・再実行困難な処理には不向き。

---

# ☁ 6. Serverless構造

## 分類

```
コンテナ実行 → Cloud Run
イベント処理 → Functions
定期実行     → Scheduler
確実実行     → Tasks
```

---

## Cloud Run

```
リクエスト時に起動
アイドル時は停止
```

トラフィックが少ない場合に有効。

---

# 📦 7. Event構造

```
Pub/Sub = メッセージ基盤
Eventarc = イベントルーティング
```

---

## 判断軸

```
大量メッセージ保持 → Pub/Sub
GCPイベント起動    → Eventarc
```

---

## 流れ例

```
GCS → Eventarc → Cloud Run
```

```
App → Pub/Sub → Subscriber
```

---

# 🐳 8. GKE構造

```
Cluster
   ↓
Node Pool
   ↓
Node
   ↓
Pod
```

---

## スケーリング整理

```
Pod数      → HPA
Podサイズ  → VPA
Node数     → Cluster Autoscaler
```

---

## Pendingの意味

```
Node不足
   or
CPU/メモリ不足
```

---

## Serviceの役割

```
Podは入れ替わる
入口はServiceで固定
```

---

# 🗄 9. Storage選定

```
頻繁アクセス → Standard
月1回       → Nearline
年1回       → Coldline
長期保管     → Archive
```

---

## 自動移行

```
30日後変更？
   ↓
Lifecycle Policy
```

---

# 🗃 10. DB選定

```
中小規模RDB → Cloud SQL
大規模水平   → Spanner
分析用途     → BigQuery
```

---

# 📊 11. Ops

```
Monitoring = 可視化
Logging    = 記録
```

---

## ログ転送

```
Log Sink
   ↓
GCS / BQ / PubSub
```

---

# 🎯 ACE反射フロー

```
Web公開 + SSL → HTTP(S) LB
外向き通信    → NAT
自動復旧      → MIG
別PJT操作     → リソース側IAM
少トラフィック→ Cloud Run
大量メッセージ→ Pub/Sub
GCPイベント   → Eventarc
Pending       → Node不足
```

---

# 学習メモ

文章 → 図へ
図 → 反射へ

構造で理解し、
その後スピードを上げる。

---

