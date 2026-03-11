# GKE 試験対策（ACE 2026 / 実務整理版）

GKEは **6領域で整理**すると試験・実務ともに理解しやすい。

```mermaid
graph TD
A[GKE] --> B[Cluster]
A --> C[Workload]
A --> D[Scaling]
A --> E[Networking]
A --> F[Security]
A --> G[Operations]
```

---

# 1. Cluster

## 1.1 GKE基本構造

GKEはKubernetesクラスタをマネージドで提供するサービス。

### 構造

```
Cluster
 └ Node (VM)
     └ Pod
         └ Container
```

| 要素        | 説明                |
| --------- | ----------------- |
| Cluster   | Kubernetes環境      |
| Node      | Compute Engine VM |
| Pod       | コンテナ実行単位          |
| Container | アプリ               |

### ACE暗記

```
Pod = Kubernetes最小実行単位
```

---

## 1.2 Clusterタイプ

| タイプ       | 特徴               |
| --------- | ---------------- |
| Autopilot | Node管理をGoogleが実施 |
| Standard  | Node管理をユーザー      |

```mermaid
graph LR
User --> Autopilot
User --> Standard

Autopilot --> GoogleManage
Standard --> UserManage
```

### ACE判断

```
運用最小 → Autopilot
Node制御必要 → Standard
```

### 2026実務

Autopilot採用が増加。
SRE運用削減のため標準選択になるケースが多い。

---

## 1.3 Node Pool

GKEでは **Node pool分離が基本設計**

```
Cluster
 ├ NodePool-A (E2)
 ├ NodePool-B (C2)
 └ NodePool-C (M2)
```

| ノード               | 用途    |
| ----------------- | ----- |
| General-purpose   | Web   |
| Compute-optimized | CPU処理 |
| Memory-optimized  | DB    |

### ACE

```
ワークロード分離
→ Node pool
```

---

# 2. Workload

## 2.1 Pod管理

```mermaid
graph TD
Deployment --> Pod1
Deployment --> Pod2
Deployment --> Pod3
```

| 種類          | 用途        |
| ----------- | --------- |
| Deployment  | stateless |
| StatefulSet | database  |
| DaemonSet   | 全Node     |
| Job         | バッチ       |
| CronJob     | 定期        |

---

## 2.2 Deployment

最も一般的なPod管理。

| 機能             | 内容     |
| -------------- | ------ |
| Replica        | Pod数維持 |
| Rolling update | 無停止更新  |
| Self healing   | Pod復旧  |

### ACE

```
Pod安定管理
→ Deployment
```

---

## 2.3 StatefulSet

DB系ワークロード。

```
Pod-0 ↔ Disk-0
Pod-1 ↔ Disk-1
Pod-2 ↔ Disk-2
```

| 特徴      | 内容              |
| ------- | --------------- |
| 固定ID    | db-0            |
| ディスク紐付け | Persistent Disk |
| 起動順序    | あり              |

### ACE

```
DB
→ StatefulSet
```

---

## 2.4 DaemonSet

全NodeにPod配置。

```
Node1 → Pod
Node2 → Pod
Node3 → Pod
```

| 用途         | 例             |
| ---------- | ------------- |
| Logging    | fluentd       |
| Monitoring | node exporter |

### ACE

```
全node
→ DaemonSet
```

---

## 2.5 Job / CronJob

| 種類      | 用途   |
| ------- | ---- |
| Job     | 一回処理 |
| CronJob | 定期処理 |

---

# 3. Scaling

GKEのスケールは **3種類**

| 機能                 | 対象           |
| ------------------ | ------------ |
| HPA                | Pod          |
| VPA                | Pod resource |
| Cluster Autoscaler | Node         |

---

## 3.1 HPA

Pod数スケール

```
CPU → HPA → Pod増加
```

### ACE

```
Pod増やす
→ HPA
```

---

## 3.2 VPA

Podリソース調整

```
Pod CPU/Mem調整
```

### ACE

```
resource最適化
→ VPA
```

---

## 3.3 Cluster Autoscaler

Node増減

```
Pod増 → Node追加
```

### ACE

```
Node不足
→ Cluster Autoscaler
```

---

# 4. Networking

## 4.1 通信構造

```mermaid
graph TD
Internet --> LoadBalancer
LoadBalancer --> Service
Service --> Pods
```

---

## 4.2 Service

Pod公開。

| タイプ          | 用途     |
| ------------ | ------ |
| ClusterIP    | 内部通信   |
| NodePort     | Node公開 |
| LoadBalancer | 外部公開   |

### ACE

```
GKE外部公開
→ Service LoadBalancer
```

---

## 4.3 Ingress

HTTPルーティング

```
/api → ServiceA
/web → ServiceB
```

```mermaid
graph TD
Internet --> Ingress
Ingress --> ServiceA
Ingress --> ServiceB
```

### ACE

```
URL routing
→ Ingress
```

---

## 4.4 Gateway API（2026）

Ingressの後継。

| 機能        | 内容        |
| --------- | --------- |
| Gateway   | L7 router |
| HTTPRoute | routing   |

### 実務

```
Ingress → Gateway API移行中
```

---

# 5. Security

## 5.1 Workload Identity

PodからGCP APIアクセス。

```
Pod → Workload Identity → GCP API
```

理由

* JSONキー不要
* IAM統合

### ACE

```
Pod→GCP
→ Workload Identity
```

---

## 5.2 Private Cluster

Nodeを非公開化。

| 項目            | 内容         |
| ------------- | ---------- |
| Node          | private IP |
| control plane | Google管理   |

### ACE

```
安全なGKE
→ Private cluster
```

---

## 5.3 Binary Authorization

コンテナ署名検証。

| 機能      | 内容    |
| ------- | ----- |
| Image検証 | 未署名拒否 |

実務用途

```
Supply chain security
```

---

# 6. Operations

## 6.1 Rolling Update

Deployment更新。

```
OldPod → NewPod
```

### ACE

```
無停止更新
→ rolling update
```

---

## 6.2 Rollback

```
kubectl rollout undo
```

### ACE

```
更新失敗
→ rollback
```

---

## 6.3 Cluster接続

```
gcloud container clusters get-credentials CLUSTER
```

### ACE

```
kubectl接続
→ get-credentials
```

---

## 6.4 kubectl基本

| コマンド                 | 用途       |
| -------------------- | -------- |
| kubectl get pods     | Pod確認    |
| kubectl get nodes    | Node確認   |
| kubectl describe pod | Pod詳細    |
| kubectl logs         | Podログ    |
| kubectl rollout undo | rollback |

---

# 7. Artifact Registry

コンテナ保存。

```
Build
 ↓
Artifact Registry
 ↓
GKE pull
```

### ACE

```
Container registry
→ Artifact Registry
```

---

# 8. GKE Storage

| 種類              | 用途  |
| --------------- | --- |
| Persistent Disk | 永続  |
| Local SSD       | 高IO |
| Filestore       | NFS |

### ACE

```
高IO
→ Local SSD
```

---

# 9. StorageClass

動的ボリューム作成。

```
PVC → PV
```

実務

```
CSI driver
```

---

# 10. ACEで最も出るGKE

```
Autopilot vs Standard
HPA
Cluster Autoscaler
Service LoadBalancer
Ingress
Workload Identity
rollout undo
get-credentials
```

---

# 11. 最終チート

```
運用減らす → Autopilot
Pod増 → HPA
Node不足 → Cluster Autoscaler
外部公開 → Service LoadBalancer
HTTP routing → Ingress
Pod→GCP → Workload Identity
rollback → rollout undo
接続 → get-credentials
```

---

# 12. 2026 GKE実務トレンド

| 技術                   | 状況                    |
| -------------------- | --------------------- |
| Autopilot            | 普及                    |
| Gateway API          | Ingress後継             |
| Workload Identity    | 標準                    |
| Artifact Registry    | Container Registry置換  |
| Binary Authorization | supply chain security |

---

# 13. GKE構造

```mermaid
graph TD
Cluster --> Node
Node --> Pod
Pod --> Container

Cluster --> Scaling
Cluster --> Networking
Cluster --> Security
Cluster --> Operations
```

---

# 14. ACE頻出用語集（GKE / 2026）

| 用語                                | フルスペル                       | 定義                           | 簡単説明                              |
| --------------------------------- | --------------------------- | ---------------------------- | --------------------------------- |
| **GKE**                           | Google Kubernetes Engine    | Google CloudのマネージドKubernetes | Kubernetesクラスタの構築・運用を自動化するサービス    |
| **Cluster**                       | Kubernetes Cluster          | Kubernetes環境の単位              | Control PlaneとNode群で構成される         |
| **Control Plane**                 | Kubernetes Control Plane    | クラスタ管理コンポーネント                | API Server・Scheduler・Controllerなど |
| **Node**                          | Worker Node                 | Podを実行するVM                   | GKEではCompute Engine VM            |
| **Node Pool**                     | Node Pool                   | 同一構成Nodeのグループ                | OS / Machine type / Diskなどが同一     |
| **Pod**                           | Kubernetes Pod              | Kubernetesの最小実行単位            | 1つ以上のコンテナを含む                      |
| **Container**                     | Container Runtime           | アプリ実行環境                      | Pod内で実行されるコンテナ                    |
| **Deployment**                    | Deployment Controller       | statelessアプリ管理               | Podの更新・スケール管理                     |
| **ReplicaSet**                    | Replica Set                 | Pod複製管理                      | 指定数のPodを維持                        |
| **StatefulSet**                   | StatefulSet Controller      | statefulアプリ管理                | DBや分散システム向け                       |
| **DaemonSet**                     | Daemon Set                  | NodeごとにPod配置                 | ログ / 監視エージェント                     |
| **Job**                           | Batch Job                   | 一回実行バッチ                      | 完了後終了                             |
| **CronJob**                       | Scheduled Job               | 定期バッチ                        | Cronスケジュール                        |
| **Service**                       | Kubernetes Service          | Pod公開                        | Podの安定アクセス提供                      |
| **ClusterIP**                     | Cluster Internal IP         | 内部Service                    | Pod間通信                            |
| **NodePort**                      | Node Port Service           | Node公開                       | NodeIP + Port                     |
| **LoadBalancer**                  | External Load Balancer      | 外部公開Service                  | Cloud Load Balancer               |
| **Ingress**                       | Kubernetes Ingress          | HTTPルーティング                   | URLベースルーティング                      |
| **Gateway API**                   | Kubernetes Gateway API      | L7ルーティング                     | Ingressの次世代API                    |
| **HPA**                           | Horizontal Pod Autoscaler   | Pod数自動スケール                   | CPU / custom metrics              |
| **VPA**                           | Vertical Pod Autoscaler     | Podリソース自動調整                  | CPU / Memory調整                    |
| **Cluster Autoscaler**            | Node Autoscaler             | Node自動スケール                   | Pod需要に応じNode追加                    |
| **Autopilot Mode**                | GKE Autopilot               | フルマネージドGKE                   | Node管理不要                          |
| **Standard Mode**                 | GKE Standard                | Node管理型GKE                   | Node設定自由                          |
| **Workload Identity**             | Workload Identity for GKE   | Pod → GCP API認証              | Service Account連携                 |
| **Private Cluster**               | Private GKE Cluster         | Private IP Node              | NodeにPublic IPなし                  |
| **Binary Authorization**          | Container Image Policy      | コンテナ署名検証                     | 不正イメージ防止                          |
| **Artifact Registry**             | Container Artifact Storage  | コンテナ保存                       | Dockerイメージレジストリ                   |
| **StorageClass**                  | Storage Provisioning Policy | 動的ボリューム作成                    | PVC要求時に自動作成                       |
| **Persistent Volume (PV)**        | Persistent Storage Volume   | Kubernetesストレージ              | クラスタ外ストレージ                        |
| **Persistent Volume Claim (PVC)** | Volume Request              | PV要求                         | Podがストレージ要求                       |
| **Rolling Update**                | Rolling Deployment          | 無停止更新                        | Podを順次更新                          |
| **Rollback**                      | Deployment Rollback         | 更新取り消し                       | 旧バージョン復元                          |
| **ConfigMap**                     | Configuration Resource      | 設定管理                         | アプリ設定をPodへ                        |
| **Secret**                        | Secret Resource             | 機密情報管理                       | パスワード / APIキー                     |
| **Sidecar Container**             | Sidecar Pattern             | 補助コンテナ                       | ログ / Proxy                        |
| **Init Container**                | Initialization Container    | 初期処理コンテナ                     | Pod起動前処理                          |
| **Network Policy**                | Kubernetes Network Policy   | Pod通信制御                      | Pod間Firewall                      |
| **Pod Disruption Budget**         | PDB                         | Pod停止制御                      | 高可用性維持                            |
| **Node Auto Repair**              | Node Self Healing           | Node自動修復                     | 異常Node再作成                         |
| **Node Auto Upgrade**             | Node Auto Upgrade           | Node自動更新                     | Kubernetes更新                      |

---

