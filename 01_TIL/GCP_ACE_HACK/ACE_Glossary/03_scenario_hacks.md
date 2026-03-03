# Appendix: GCP ACE Cheat Sheet（AA Deep Dive版）

---

# 1. Load Balancer / Network

## 1.1 L7 vs L4（入口の層）

```
L7 = HTTP / HTTPS（URL・Hostで制御）
L4 = TCP / UDP（ポート単位）
```

---

## 1.2 HTTP(S) Load Balancer（Webの基本解）

```
Client
   |
 HTTPS
   v
+----------------------+
|  HTTP(S) LoadBalancer|
|  (L7)                |
+----------+-----------+
           |
           v
 Backend (MIG / GKE / Cloud Run)
```

特徴：

* グローバル
* SSL終端可能
* URLルーティング可能
* Cloud Armor連携
* CDN連携可能

選択シグナル：

* Web公開
* SSL終端
* WAF
* URLベース振り分け

---

## 1.3 TCP / SSL Proxy（非HTTP用途）

```
Client -- TCP/SSL --> [ TCP Proxy LB ] --> Backend
```

用途：

* 非HTTP通信
* TCPアプリ
* SSL終端のみ必要

※Web用途の基本解ではない

---

## 1.4 Internal Load Balancer（内部専用）

```
[VPC内 Client] --> [ Internal LB ] --> [内部Backend]
```

用途：

* マイクロサービス間
* 内部アプリ
* 外部公開しない

---

## 1.5 Cloud NAT（受信不可）

```
Private VM
   |
   v
+-----------+
| Cloud NAT |
+-----------+
   |
   v
Internet
```

特徴：

* アウトバウンド専用
* 受信不可
* Public IP不要

混同防止：

* Web公開 = LB
* 外へ出るだけ = NAT

---

## 1.6 VPC Peering

```
VPC-A <------> VPC-B
```

特徴：

* プライベートIP接続
* Transitive不可

罠：
A-B + B-C でも A-C 不可

---

## 1.7 Shared VPC（組織統制）

```
[Host Project]
     |
     +-- Shared VPC
           |
   -----------------------
   |                     |
[Service PJT A]     [Service PJT B]
```

用途シグナル：

* 複数プロジェクト統一
* 中央NWチーム
* ガバナンス

---

# 2. Pub/Sub / Eventarc

## 2.1 概念分離

```
Pub/Sub  = キュー（保持 / 再試行 / バッファ）
Eventarc = イベント配線（ルーティング）
```

---

## 2.2 Pub/Sub

```
Event Source
     |
     v
+-------------+
|   Pub/Sub   |
+-------------+
     |
     v
Subscriber
     |
     v
Cloud Run / Functions / Dataflow
```

用途：

* 大量データ
* 再試行保証
* バッファリング
* Pull/Push制御

判断軸：
「キュー？保持？再試行？」→ Pub/Sub

---

## 2.3 Eventarc

```
Event Source
     |
     v
+-------------+
|   Eventarc  |
+-------------+
     |
     v
Cloud Run / Functions (2nd gen)
```

用途：

* GCSイベント
* Firestore更新
* Audit Logトリガー

判断軸：
「GCPイベントでRun起動？」→ Eventarc

---

# 3. GKE

## 3.1 構造（立体固定）

```
+----------------------+
|       Cluster        |
|  (Control Plane)     |
+-----------+----------+
            |
      +-----+-----+
      | NodePool  |
      +--+-----+---+
         |     |
       Node   Node
         |
        Pod
```

* Cluster = 制御
* NodePool = 同型ノード群
* Node = 席
* Pod = 実体

---

## 3.2 Pod / Deployment / Service

```
Deployment
   |
   +-- Pod
   +-- Pod
   +-- Pod

Service (固定IP)
   |
   +-- Pod群
```

原則：

* Podは死ぬ前提
* 入口はServiceで固定

---

## 3.3 Pendingの正体

```
Node1 CPU 100%
Node2 CPU 100%

Pod3 -> Pending（席不足）
```

解決：

* Cluster Autoscaler
* Node Auto-Provisioning

---

## 3.4 HPA / VPA / CA（3階層）

```
[Cluster]  Node数  <- CA
    |
[Pods]     Pod数   <- HPA
    |
[Pod]      サイズ  <- VPA
```

覚え方：

* HPA = 数
* VPA = サイズ
* CA  = 席

---

## 3.5 DaemonSet / StatefulSet

DaemonSet（全員配布）

```
Node1 -> Pod
Node2 -> Pod
Node3 -> Pod
```

StatefulSet（個体固定）

```
db-0 -> disk-0
db-1 -> disk-1
db-2 -> disk-2
```

---

## 3.6 Namespace / gVisor

Namespace

```
Cluster
 ├ dev
 ├ prod
 └ test
```

gVisor

```
Pod -> Sandbox -> Host
```

用途：

* 信頼できないコード
* 最大隔離

---

# 4. Cloud DNS（ハイブリッド）

## 4.1 Private Zone（疎結合）

```
App -> db.internal
          |
          v
Cloud DNS Private Zone
          |
          v
On-prem IP
```

原則：

* アプリはIPを知らない
* DNS更新のみで追従

---

## 4.2 DNS Forwarding

```
GCP -> Onprem   = Outbound
Onprem -> GCP   = Inbound
```

---

## 4.3 DNS Peering

```
VPC-A の Private Zone
        |
        v
VPC-B から参照
```

※VPC PeeringだけではDNS共有されない

---

# 5. Compute Engine

## 5.1 VMリサイズ

```
STOP
  ↓
変更
  ↓
START
```

Live Migration ≠ リサイズ

---

## 5.2 VM購入オプション

| 種類        | 用途      |
| --------- | ------- |
| On-demand | 常時稼働    |
| Spot      | 中断可能バッチ |
| CUD       | 長期利用    |

---

# 6. GCS

## 6.1 Storage Class

| クラス      | 用途    |
| -------- | ----- |
| Standard | 頻繁    |
| Nearline | 月1回   |
| Coldline | 数ヶ月   |
| Archive  | 年1回未満 |

最低保持期間あり（早期削除料金）

---

## 6.2 Lifecycle

```
30日後 -> Nearline
90日後 -> Coldline
365日後 -> Archive
```

自動移行

---

## 6.3 Content-Type

```
application/pdf → ブラウザ表示
octet-stream    → ダウンロード
```

---

# 7. 最終判断フロー（ACE即答用）

```
Web公開 + SSL?        → HTTP(S) LB
内部のみ?             → Internal LB
外へ出るだけ?         → NAT

キュー必要?           → Pub/Sub
GCPイベントで起動?     → Eventarc

Pod Pending?          → 席不足 → CA/NAP

IP変更を隠したい?     → Private DNS

組織でNW統制?         → Shared VPC
```

---
20260303以降のついき

### 🧠 Q15：Cloud Run と Pub/Sub のベストな連携（Push型）

* **キーワード：** `Cloud Run`, `Pub/Sub topic`, `Activity messages`, `Best practices`.
* **論点：** サーバーレスな Cloud Run に対して、メッセージをどう効率的かつ安全に届けるか。
* **正解（ベストプラクティス）：** **Pub/Sub の「プッシュ（Push）サブスクリプション」** を使い、Cloud Run の URL をエンドポイントに指定する。

#### 💡 客観的な技術評価

1. **Push vs Pull の選択**:
* **Pull（選択肢Bの毒）**: Cloud Run はリクエストがない時は「0」にスケールする性質上、メッセージを待ち受けて「自分から取りに行く（Pull）」動作には向かない（常に起動しておく必要があり、コスト増）。
* **Push（薬）**: メッセージが来た時だけ Pub/Sub が Cloud Run を「叩き起こす（HTTP Post）」ため、リソース効率が最大化される。


2. **認証の重要性（Invoker ロール）**:
インターネットに公開されている Cloud Run エンドポイントを、誰でも叩ける状態にするのは「毒」。Pub/Sub サービスエージェントに **`Cloud Run Invoker`** ロールを与えたサービスアカウントを紐付けることで、正当な通知だけを受け付けるセキュアな経路が完成する。
3. **アーキテクチャの簡素化（A, Dの毒）**:
Cloud Functions を中継させたり（A）、GKE 上に自前でプロキシを立てたり（D）するのは、管理ポイントを増やすだけでメリットがない。

---

### 🎙️ 脳に刻むための「音読用スクリプト」

> 「問題は、**Cloud Run** で **Pub/Sub** のメッセージを処理することだ。
> **Pull 型** は、サーバーを動かし続ける必要があり、サーバーレスの利点を殺す『毒』。
> **Cloud Functions** を挟むのは、無駄な中継地点を増やすだけで、コストも遅延も増える。
> 正解は、**Push 型サブスクリプション** だ。
> 1. 専用の **サービスアカウント** を作る。
> 2. そのアカウントに **Cloud Run Invoker** 権限を渡す。
> 3. Pub/Sub の **Push エンドポイント** に Cloud Run を指定する。
> 
> 
> メッセージが来た瞬間、Pub/Sub が Cloud Run を叩き起こす。
> **『認証付きの Push』**。これが Google 推奨の黄金パターンだ。」

---

### 🚀 整理の進捗

* **論点**: Cloud Run への通知 ＝ **Push サブスクリプション**。
* **セキュリティ**: サービスアカウントによる **Invoker 権限** の付与。



### 🧠 Cloud Run Invoker ロールの正体

Cloud Run はデフォルトで **「認証が必要（Allow unauthenticated: No）」** な設定にすることが推奨されます。このとき、リクエストを投げる側には「お前は誰だ？」という証明（IDトークン）が求められます。

* **役割:** 指定したサービスアカウントに対して、Cloud Run のエンドポイントを叩く（Invokeする）許可を与える。
* **なぜ Pub/Sub 設定時に必要なのか:** 1. Pub/Sub が Cloud Run にメッセージを **Push** する。
2. Cloud Run 側は「誰だかわからない通信は拒否する」と構えている。
3. Pub/Sub に「このサービスアカウントのフリをして叩け」と指示を出す。
4. そのサービスアカウントに **`Cloud Run Invoker`** が付与されていれば、Cloud Run は「あ、許可された人だ」と判断して門を開ける。

---

### 🛡️ 2周目用：ここが「毒」と「薬」の分かれ目

試験でこの構成が出た際、以下のチェックポイントを音読してください。

| 構成要素 | 薬（正解） | 毒（不正解） |
| --- | --- | --- |
| **アクセス制限** | **認証が必要** (Authenticated) | **一般公開** (Unauthenticated) |
| **叩く権限** | **`Cloud Run Invoker`** | `Cloud Run Admin` (権限強すぎ) |
| **紐付け先** | **Pub/Sub 側**にサービスアカウントをセット | Cloud Run 側の環境変数に書く |

> **ハック：** 「Invoker（起動者）」という名前の通り、**「動かす権利」**だけをピンポイントで渡すのが最小権限の原則（Least Privilege）です。

---
