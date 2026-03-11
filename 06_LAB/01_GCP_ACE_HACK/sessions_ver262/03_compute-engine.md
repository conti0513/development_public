````markdown
# GCP Compute 選択（ACE 2026）

GCPのComputeは **5種類で判断**すると試験が解きやすい。

```mermaid
graph TD
A[Compute options] --> B[Compute Engine]
A --> C[GKE]
A --> D[Cloud Run]
A --> E[App Engine]
A --> F[Batch]
````

---

# 1. Compute 全体比較

| サービス           | 実行単位      | 管理           | 主用途        |
| -------------- | --------- | ------------ | ---------- |
| Compute Engine | VM        | OS管理         | 既存アプリ      |
| GKE            | Pod       | Kubernetes管理 | マイクロサービス   |
| Cloud Run      | Container | Serverless   | API / イベント |
| App Engine     | App       | Serverless   | Webアプリ     |
| Batch          | Job       | Serverless   | 大量バッチ      |

---

# 2. ACE判断フロー

```mermaid
flowchart TD
A[Workload] --> B{コンテナ?}

B -->|No| C{既存VM?}

C -->|Yes| D[Compute Engine]
C -->|No| E{Web app?}

E -->|Yes| F[App Engine]
E -->|No| G[Batch]

B -->|Yes| H{Kubernetes必要?}

H -->|Yes| I[GKE]
H -->|No| J[Cloud Run]
```

---

# 3. Compute Engine

VMベースコンピュート。

```mermaid
graph TD
User --> VM
VM --> OS
OS --> App
```

## 特徴

| 項目   | 内容 |
| ---- | -- |
| 単位   | VM |
| OS管理 | 必要 |
| SSH  | 可能 |
| カスタム | 可能 |

### ACE暗記

```
SSH必要
既存VM
OSカスタム

→ Compute Engine
```

---

# 4. Machine Type

VM性能選択。

| タイプ         | 用途    |
| ----------- | ----- |
| Standard    | 一般    |
| High-CPU    | CPU処理 |
| High-Memory | メモリ処理 |
| Custom      | 自由    |

### ACE

```
RAM偏重
→ Custom machine type
```

---

# 5. Managed Instance Group

VMスケール。

```mermaid
graph TD
LoadBalancer --> MIG
MIG --> VM1
MIG --> VM2
MIG --> VM3
```

## 機能

| 機能             | 内容   |
| -------------- | ---- |
| Autoscaling    | 自動増減 |
| Autohealing    | 自動復旧 |
| Rolling update | 更新   |

### ACE

```
VM auto scale
→ Managed Instance Group
```

---

# 6. VM Storage

| 種類              | 特徴  |
| --------------- | --- |
| Persistent Disk | 標準  |
| Local SSD       | 高IO |
| Filestore       | NFS |

### ACE

```
最高IO
→ Local SSD
```

---

# 7. Snapshot

ディスクバックアップ。

```mermaid
graph TD
Disk --> Snapshot
Snapshot --> Backup
```

### ACE

```
Disk backup
→ Snapshot
```

---

# 8. Custom Image

VMテンプレート。

| 用途   | 内容    |
| ---- | ----- |
| VM複製 | Image |

### ACE

```
VMテンプレート
→ Image
```

---

# 9. Networking

VM公開。

```mermaid
graph TD
Internet --> LoadBalancer
LoadBalancer --> VM
```

### ACE

```
高可用VM
→ Load Balancer + MIG
```

---

# 10. Service Account

VMからGCP API利用。

```mermaid
graph TD
VM --> ServiceAccount
ServiceAccount --> GCP_API
```

### ACE

```
VM → GCP API
→ Service Account
```

---

# 11. Startup Script

VM初期化。

```bash
#!/bin/bash
apt update
apt install nginx
```

### ACE

```
VM起動時設定
→ Startup script
```

---

# 12. Spot VM

低コストVM。

| 特徴 | 内容    |
| -- | ----- |
| 割引 | 最大90% |
| 停止 | いつでも  |

### ACE

```
バッチ
→ Spot VM
```

---

# 13. OS Login

SSH管理。

| 機能       | 内容      |
| -------- | ------- |
| OS Login | IAMでSSH |

### ACE

```
SSH管理
→ OS Login
```

---

# 14. Cloud Run

Serverlessコンテナ。

```mermaid
graph TD
Container --> CloudRun
CloudRun --> HTTP
```

## 特徴

| 項目   | 内容        |
| ---- | --------- |
| 単位   | Container |
| スケール | 自動        |
| 課金   | リクエスト     |
| 運用   | 最小        |

### ACE

```
HTTP API
コンテナ

→ Cloud Run
```

---

# 15. Cloud Run Jobs

バッチ処理。

| 用途  | 内容   |
| --- | ---- |
| Job | 一回処理 |

### ACE

```
Container batch
→ Cloud Run Jobs
```

---

# 16. Cloud Run イベント処理

```
Pub/Sub
 ↓ push
Cloud Run
```

### ACE

```
Pub/Sub → Cloud Run
→ Push subscription
```

---

# 17. GKE

Kubernetes管理。

```mermaid
graph TD
Cluster --> Node
Node --> Pod
Pod --> Container
```

## 特徴

| 項目   | 内容         |
| ---- | ---------- |
| 単位   | Pod        |
| 管理   | Kubernetes |
| スケール | HPA        |

### ACE

```
多数コンテナ
Kubernetes

→ GKE
```

---

# 18. GKE Autopilot

| モード       | 特徴         |
| --------- | ---------- |
| Standard  | Node管理     |
| Autopilot | Serverless |

### ACE

```
Kubernetes
運用最小

→ GKE Autopilot
```

---

# 19. App Engine

PaaS型アプリ。

```mermaid
graph TD
User --> AppEngine
AppEngine --> Runtime
Runtime --> App
```

| 項目   | 内容  |
| ---- | --- |
| スケール | 自動  |
| 運用   | 最小  |
| 用途   | Web |

### ACE

```
Flask
Django

→ App Engine
```

---

# 20. Batch

大規模バッチ処理。

| 特徴   | 内容 |
| ---- | -- |
| 大量処理 | 可能 |
| VM管理 | 自動 |

### ACE

```
大規模バッチ
→ Batch
```

---

# 21. スケール比較

| サービス           | スケール |
| -------------- | ---- |
| Cloud Run      | 自動   |
| App Engine     | 自動   |
| GKE            | HPA  |
| Compute Engine | MIG  |
| Batch          | 自動   |

---

# 22. 運用負荷

| サービス           | 運用 |
| -------------- | -- |
| Compute Engine | 高  |
| GKE            | 中  |
| App Engine     | 低  |
| Cloud Run      | 最低 |
| Batch          | 最低 |

---

# 23. Snapshot vs Image

| 機能       | 用途     |
| -------- | ------ |
| Snapshot | バックアップ |
| Image    | VMテンプレ |

### ACE

```
バックアップ → Snapshot
VM複製 → Image
```

---

# 24. ACE Compute 頻出

```
Custom machine type
Managed Instance Group
Snapshot
Local SSD
Service Account
Spot VM
Startup script
```

---

# 25. ACE Compute 判断まとめ

```
SSH必要 → Compute Engine
Kubernetes → GKE
HTTPコンテナ → Cloud Run
Webアプリ → App Engine
大量バッチ → Batch
```

---

# 26. Compute 構造

```mermaid
graph TD
Compute --> VM
Compute --> Container
Compute --> Kubernetes

VM --> ComputeEngine
Container --> CloudRun
Kubernetes --> GKE
```

---

# 最終ACE暗記

```
VM → Compute Engine
Container → Cloud Run
Kubernetes → GKE
Web app → App Engine
Batch → Batch
```

```
