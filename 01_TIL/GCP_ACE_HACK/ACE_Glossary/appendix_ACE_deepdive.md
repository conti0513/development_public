---

# 8. Load Balancer / Network Deep Dive

## L7 vs L4

L7 ＝ HTTP/HTTPS
L4 ＝ TCP/UDP

### HTTP(S) Load Balancer

Client
  │
HTTPS
  │
[ HTTP(S) LB ]
  │
Backend (MIG / GKE / Cloud Run)

- グローバル
- SSL終端可
- URLルーティング
- Cloud Armor連携可

選択キーワード：
Web / SSL終端 / WAF / CDN

---

### TCP / SSL Proxy LB

- TCPアプリ用
- 非HTTP通信
- SSL終端のみ必要な場合

---

### Internal Load Balancer

- VPC内部専用
- マイクロサービス間通信

---

### NATとの違い（超重要）

Private VM
   │
   ▼
Cloud NAT
   │
Internet

- NATはアウトバウンド専用
- 受信不可
- Public IP不要

混同防止：
Web公開＝LB
外へ出るだけ＝NAT

---

## VPC Peering

VPC-A  ←→  VPC-B

- プライベートIP接続
- Transitive不可

罠：
A-B, B-C接続してもA-C不可

---

## Shared VPC

Host Project
   └─ VPC

Service Project A
Service Project B

- ネットワーク中央管理
- 組織統制向き

選択文脈：
大企業 / 中央NWチーム / 複数PJT統一

---

# 9. Pub/Sub / Eventarc Deep Dive

## 概念分離

Pub/Sub ＝ メッセージキュー
Eventarc ＝ イベント配線ルーター

---

## Pub/Sub構造

Event Source
   │
   ▼
Pub/Sub
   │
Subscriber
   │
Cloud Function / Run

用途：
- 大量データ
- 再試行保証
- バッファリング

---

## Eventarc構造

Event Source
   │
   ▼
Eventarc
   │
   ▼
Cloud Run / Functions

用途：
- GCSイベント
- Firestore更新
- Audit Logトリガー

試験判断軸：
キュー？ → Pub/Sub
GCPイベントでRun起動？ → Eventarc

---

## 混乱ポイント

Functions 1st gen：
GCS → Pub/Sub → Function

Functions 2nd gen / Cloud Run：
Eventarc経由

---

# 10. GKE Deep Dive

## Cluster / Node Pool 構造

            ┌───────────────────┐
            │     GKE Cluster   │
            └─────────┬─────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
   NodePool-A    NodePool-B    NodePool-C
        │             │             │
       Node          Node          Node

- Cluster = 制御プレーン
- NodePool = 同型ノード群
- Node = Podが乗る物理席

---

## Pod / Deployment / Service

Deployment
   │
   ├── Pod
   ├── Pod
   └── Pod

Podは死ぬ前提

Service (固定IP)
      │
   Pod Pod Pod

- Pod直接接続はNG
- 入口はServiceで固定

---

## Pendingの正体

Node1 CPU 100%
Node2 CPU 100%

Pod3 → Pending（席不足）

確認：
kubectl describe pod
Eventsを見る

---

## HPA / VPA / Cluster Autoscaler

Cluster（Node数） ← CA
   │
Pod群（Pod数） ← HPA
   │
Podサイズ ← VPA

整理：
HPA = 数
VPA = サイズ
CA  = 席数

---

## DaemonSet

Node1 → Pod
Node2 → Pod
Node3 → Pod

全ノード1つ

用途：
監視エージェント

---

## StatefulSet

db-0 → disk-0
db-1 → disk-1
db-2 → disk-2

- 名前固定
- 順序保持
- ディスク保持

用途：
DB

---

## Namespace

Cluster
 ├─ dev
 ├─ prod
 └─ test

- 論理区画
- 完全隔離ではない

---

## gVisor

通常：
Pod → Container → Host Kernel共有

gVisor：
Pod → Sandbox → 仮想カーネル層 → Host

- 最大隔離
- 信頼できないコード実行時
