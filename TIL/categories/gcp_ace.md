## 📘 Cloud Concepts Summary (Based on NIST & GCP ACE)

### ☁️ What is Cloud Computing?

Cloud computing is a model for enabling on-demand access to a shared pool of configurable computing resources over the internet.

クラウドコンピューティングとは、  
必要なときにネットワーク経由で共有のITリソース（サーバー、ストレージ、アプリなど）にアクセスできるサービスモデル。

---

### 🔑 5 Essential Characteristics / クラウドの5つの本質的特性

- **On-demand self-service**  
  → Users can provision resources as needed, automatically  
  → ユーザーが必要なときに自分でリソースを追加・削除できる

- **Broad network access**  
  → Accessible over the internet from any device  
  → ネットワーク経由でさまざまな端末から利用可能

- **Resource pooling**  
  → Resources are shared across multiple users (multi-tenancy)  
  → 複数ユーザーでリソースを共有（マルチテナント）

- **Rapid elasticity**  
  → Resources can scale up/down quickly  
  → リソースの拡張・縮小が迅速にできる

- **Measured service**  
  → Usage is monitored and billed (pay-as-you-go)  
  → 使用量に応じて課金（従量課金）

---

### 🧱 3 Service Models / サービスモデル

| モデル | 説明 | 代表例 |
|--------|------|--------|
| **IaaS** (Infrastructure as a Service) | 仮想マシン、ネットワーク、ストレージなどインフラ提供 | Compute Engine |
| **PaaS** (Platform as a Service) | アプリ実行環境やランタイム提供 | App Engine |
| **SaaS** (Software as a Service) | 完成されたアプリケーション提供 | Gmail など |

---

### 🏗️ 4 Deployment Models / 導入モデル

| モデル | 説明 |
|--------|------|
| **Public Cloud** | 誰でも利用可能なクラウド（例：GCP, AWS） |
| **Private Cloud** | 特定組織向けに構築された専用クラウド |
| **Hybrid Cloud** | パブリックとプライベートの併用 |
| **Community Cloud** | 特定の共同体（例：医療）による共有クラウド |

---

### ✅ Private Cloud vs. On-Premises — 違いは？

| 観点 | Private Cloud | On-Premises |
|-------|---------------|-------------|
| **設置場所** | 社内 or 外部ホスティング | 完全に社内 |
| **クラウド機能** | セルフサービス、弾力性、仮想化など含む | 通常はクラウド機能なし |
| **所有と管理** | 組織が所有または専用で運用 | 組織内で完全に管理 |
| **例** | VMware + 自動化 | 物理サーバーの運用のみ |

> 🔹 すべてのオンプレがプライベートクラウドではないが、クラウド的機能を備えたオンプレはプライベートクラウドになりうる。

---

## ☁️ Cloud Service Models – Responsibility Comparison

### 🔹 Overview (English)

| Component         | On-Premises | Hosted DC | IaaS (e.g. GCE) | PaaS (e.g. Cloud Run) | SaaS (e.g. Gmail) |
|------------------|-------------|-----------|----------------|------------------------|-------------------|
| Applications     | You         | You       | You            | ✅ Provider            | ✅ Provider        |
| Data             | You         | You       | You            | You                   | ✅ Provider        |
| Runtime          | You         | You       | You            | ✅ Provider            | ✅ Provider        |
| Middleware       | You         | You       | You            | ✅ Provider            | ✅ Provider        |
| OS               | You         | You       | ✅ Provider     | ✅ Provider            | ✅ Provider        |
| Virtualization   | You         | ✅ Maybe   | ✅ Provider     | ✅ Provider            | ✅ Provider        |
| Servers          | You         | ✅ Maybe   | ✅ Provider     | ✅ Provider            | ✅ Provider        |
| Storage          | You         | ✅ Maybe   | ✅ Provider     | ✅ Provider            | ✅ Provider        |
| Networking       | You         | ✅ Maybe   | ✅ Provider     | ✅ Provider            | ✅ Provider        |

### 🔹 日本語まとめ

| 項目             | オンプレ | データセンター | IaaS（GCEなど） | PaaS（Cloud Runなど） | SaaS（Gmailなど） |
|------------------|---------|----------------|------------------|------------------------|-------------------|
| アプリケーション   | 自分で  | 自分で         | 自分で           | ✅ プロバイダー         | ✅ プロバイダー     |
| データ            | 自分で  | 自分で         | 自分で           | 自分で                 | ✅ プロバイダー     |
| ランタイム        | 自分で  | 自分で         | 自分で           | ✅ プロバイダー         | ✅ プロバイダー     |
| ミドルウェア      | 自分で  | 自分で         | 自分で           | ✅ プロバイダー         | ✅ プロバイダー     |
| OS               | 自分で  | 自分で         | ✅ プロバイダー   | ✅ プロバイダー         | ✅ プロバイダー     |
| 仮想化           | 自分で  | ✅ 一部         | ✅ プロバイダー   | ✅ プロバイダー         | ✅ プロバイダー     |
| サーバー         | 自分で  | ✅ 一部         | ✅ プロバイダー   | ✅ プロバイダー         | ✅ プロバイダー     |
| ストレージ        | 自分で  | ✅ 一部         | ✅ プロバイダー   | ✅ プロバイダー         | ✅ プロバイダー     |
| ネットワーク      | 自分で  | ✅ 一部         | ✅ プロバイダー   | ✅ プロバイダー         | ✅ プロバイダー     |

---

## ☁️ GCP Infrastructure Concepts (Short Summary)

### 🔹 Region
- A **specific geographical area** (e.g., `asia-northeast1` = Tokyo).
- Contains multiple **zones**.
- Data **stays in the region** unless configured otherwise.

### 🔹 Zone
- An **isolated location** within a region (e.g., `asia-northeast1-a`).
- Each zone has its own power, network, and resources.
- Use **multiple zones** for high availability.

### 🔹 Multi-Region
- A group of **regions** (not just zones) spread across a **continent**.
- Optimized for **geo-redundant storage and services** (e.g., `asia`, `us`, `eu`).
- Used in **Cloud Storage multi-region buckets**, etc.

### 🔹 POP (Point of Presence)
- Edge network locations (outside GCP regions).
- Used for **low-latency content delivery** via Cloud CDN and Cloud Interconnect.
- Not for deploying compute resources.

### 🔹 Geography
- The **legal or physical boundary** for compliance.
- Example: all `asia` region data stays in Asia for legal reasons.
- **Multi-region** can be aligned to geography.

### 🗺️ Visual Hierarchy
```
Geography > Multi-Region > Region > Zone
```

### 🔸 日本語版まとめ

- **リージョン**：東京などの地理的な場所。複数のゾーンを含む。
- **ゾーン**：リージョン内の独立した設備単位。高可用性には複数ゾーンが必要。
- **マルチリージョン**：複数のリージョンをまたぐ広域分散エリア。主にストレージ用途。
- **POP（エッジ拠点）**：CDNやネットワーク高速化のための拠点。コンピュートは配置しない。
- **地理エリア（Geography）**：法的要件に準拠するための概念。アジアのデータはアジア内に保持、など。

---

## ☁️ GCP Compute Services – Overview

### 🔹 1. **Compute Engine (CE)**  
- **Type**: IaaS (Infrastructure as a Service)  
- **Summary**: Fully customizable **virtual machines**  
- **Use Case**: Legacy systems, full OS control, custom runtime  
- **Example**: Install your own database, run proprietary software

---

### 🔹 2. **App Engine (AE)**  
- **Type**: PaaS (Platform as a Service)  
- **Summary**: Deploy code without managing infrastructure  
- **Versions**:
  - **Standard**: Fast startup, auto-scaling, sandboxed
  - **Flexible**: VM-based, more control  
- **Use Case**: Web apps, REST APIs, rapid development  
- **Example**: Python/Node web app deployment in minutes

---

### 🔹 3. **Cloud Run**  
- **Type**: Serverless CaaS (Container as a Service)  
- **Summary**: Run stateless containers with **HTTP triggers**  
- **Features**: Auto-scaling to zero, full portability (Docker)  
- **Use Case**: Event-driven microservices, lightweight APIs  
- **Example**: REST API from Docker image without managing VMs

---

### 🔹 4. **Cloud Functions**  
- **Type**: FaaS (Function as a Service)  
- **Summary**: Execute single-purpose **functions on events**  
- **Triggers**: HTTP, Pub/Sub, Cloud Storage, etc.  
- **Use Case**: Automation, glue logic, small backend tasks  
- **Example**: Auto-resize image on upload to Cloud Storage

---

### 🔹 5. **Google Kubernetes Engine (GKE)**  
- **Type**: CaaS (Container as a Service)  
- **Summary**: Managed Kubernetes cluster  
- **Use Case**: Microservices, container orchestration  
- **Example**: Scalable backend with multiple containerized services

---

### 🔸 Comparison Table

| Service           | Type     | Scaling        | Deployment Style     | Use Case                       |
|------------------|----------|----------------|----------------------|--------------------------------|
| Compute Engine   | IaaS     | Manual / Auto  | VM                   | Full control, legacy systems   |
| App Engine       | PaaS     | Auto           | Source Code          | Web apps, APIs                 |
| Cloud Run        | Serverless / CaaS | Auto to Zero | Container Image        | Lightweight APIs, microservices|
| Cloud Functions  | FaaS     | Auto to Zero   | Function Code        | Event-driven logic             |
| GKE              | CaaS     | Manual / Auto  | YAML + Containers    | Scalable app, orchestration    |

---

## 📦 GCP Storage & Database Services Summary

### ☁️ **Cloud Storage** (Object Storage)
- **Type**: Object storage (like S3 in AWS)
- **Use Case**: Store **unstructured data** — images, videos, backups
- **Features**:
  - Global availability
  - Lifecycle rules
  - Multi-region, region, nearline/coldline options
- **Example**: Host static website files, store backups

---

### 💾 **Persistent Disks** (Block Storage)
- **Type**: Block storage attached to **Compute Engine**
- **Use Case**: Boot/root disks, data disks for VMs
- **Features**:
  - Zonal or regional
  - Snapshots
- **Example**: Attach SSD to a VM for fast disk I/O

---

### 📁 **Filestore** (File Storage)
- **Type**: **Managed NFS file share**
- **Use Case**: Shared filesystem for legacy apps or GKE
- **Features**:
  - Simple mount
  - High IOPS (premium tiers)
- **Example**: Migrate NAS-based workloads to GCP

---

## 🗃️ GCP Database Options

### 🧠 **Cloud SQL** (Managed RDBMS)
- **Type**: **Relational DB** (MySQL / PostgreSQL / SQL Server)
- **Use Case**: Traditional web apps, ERP systems
- **Features**:
  - Backups, replicas, automatic patching
  - Not designed for horizontal scaling
- **Example**: MySQL for WordPress, PostgreSQL for internal apps

---

### 🌍 **Cloud Spanner**
- **Type**: **Distributed Relational DB**
- **Use Case**: Global-scale apps needing high consistency
- **Features**:
  - Strong consistency + horizontal scalability
  - Global transactions
- **Example**: Large-scale financial or gaming platforms

---

### ⚡ **Firestore (NoSQL)**
- **Type**: **Serverless Document DB** (NoSQL)
- **Use Case**: Mobile apps, chat, user profiles
- **Features**:
  - Real-time sync
  - ACID transactions
  - Serverless and scalable
- **Example**: User data in a social media app

---

### 🔄 **Bigtable** (NoSQL)
- **Type**: **Wide-column NoSQL DB**
- **Use Case**: Time-series data, IoT, logs, analytics
- **Features**:
  - Massive scale, high throughput
  - No SQL joins
- **Example**: Sensor data from millions of IoT devices

---

### 🧠 Comparison Table

| Service         | Type        | Use Case                        | SQL / NoSQL | Scaling       |
|----------------|-------------|----------------------------------|-------------|---------------|
| Cloud SQL       | RDBMS       | Traditional apps, ERP            | SQL         | Vertical only |
| Cloud Spanner   | Distributed RDBMS | Global apps, fintech         | SQL         | Horizontal    |
| Firestore       | Document DB | Mobile apps, user profiles       | NoSQL       | Serverless    |
| Bigtable        | Wide-column DB | Logs, analytics, IoT         | NoSQL       | Horizontal    |

---

## 🌐 GCP Networking Services Summary

### 🛣️ **VPC (Virtual Private Cloud)**
- Private network within GCP — global, scalable.
- Subnetworks (subnets) are **regional**.
- **Auto** or **custom** mode VPCs.
- Includes routing tables and firewall rules.
- Example: Internal network for a web app and database.

---

### 🔥 **Firewall Rules**
- Control **ingress and egress traffic** at instance level.
- Applied to **VM tags or service accounts**.
- **Default rules** exist (e.g., deny all inbound).
- Example: Allow SSH only from trusted IPs.

---

### 🚦 **Cloud Routers**
- **Dynamic routing** for hybrid connectivity (VPN, Interconnect).
- Supports BGP (Border Gateway Protocol).
- Required for **HA VPN** and **Interconnect**.
- Example: Automatically update routes from on-prem.

---

### 🌐 **Cloud Load Balancing**
- Fully managed **global** load balancer (HTTP(S), TCP/UDP, internal).
- Distributes traffic across **multiple regions** or zones.
- Supports **autoscaling** and **SSL termination**.
- Types:
  - Global external HTTP(S)
  - Regional internal TCP/UDP
- Example: Load balance traffic across web servers.

---

### 📡 **Cloud DNS**
- Scalable, reliable **DNS resolution service**.
- Public and private zones.
- Example: Host domain `example.com` with GCP’s DNS.

---

### 🔐 **Cloud VPN**
- Secure tunnel between **on-prem and GCP VPC** over IPsec.
- Two types:
  - Classic VPN
  - HA VPN (with Cloud Router + BGP)
- Example: Securely connect a company’s data center to GCP.

---

### 🔌 **Cloud Interconnect**
- High-throughput, low-latency **private connectivity** to GCP.
- Two options:
  - **Dedicated Interconnect** (10 Gbps or 100 Gbps ports)
  - **Partner Interconnect** (through provider)
- Example: Transfer large volumes of data with low latency.

---

### 🔄 **Peering Options**

#### 🔹 **Direct Peering**
- Connects your network directly with Google (outside VPC).
- Used for **Google APIs**, not private GCP services.
- Public IPs required.

#### 🔹 **Carrier Peering**
- Like Direct Peering but via a **partner ISP**.
- Less complexity, easier to manage.
- Used for accessing Google services with lower latency.

---

### 🧠 Summary Table

| Service             | Purpose                                 | Typical Use Case                        |
|---------------------|------------------------------------------|------------------------------------------|
| **VPC**             | Private network in GCP                   | Isolate app traffic                     |
| **Firewall**        | Traffic control (allow/deny)             | Allow HTTPS, deny all others            |
| **Cloud Router**    | Dynamic route updates                    | VPN / Interconnect with BGP             |
| **Load Balancing**  | Distribute traffic                       | Balance load across global frontends    |
| **Cloud DNS**       | DNS resolution                           | Host a domain in GCP                    |
| **Cloud VPN**       | Secure site-to-site tunnel               | Connect on-prem to GCP securely         |
| **Interconnect**    | Private dedicated link to GCP            | High-throughput hybrid setup            |
| **Peering (Direct/Carrier)** | Public GCP service acceleration   | Lower latency to public Google services |

---
Great! Here's a concise and **GCP ACE-friendly summary of GCP Resource Hierarchy**, in both **English and Japanese**, perfect for your TIL.

---

## 🏗️ GCP Resource Hierarchy

### 🔹 Overview
Google Cloud organizes resources in a **hierarchical structure** to support **access control (IAM)** and **policy inheritance**.

```
Organization > Folder > Project > Resource
```

---

### 1. **Organization**
- Represents a **company or domain** (e.g., `example.com`).
- Root node of the hierarchy.
- Required for **enterprise-level management**.
- Only **one** organization per Google Workspace / Cloud Identity.

🔧 Example: `example.com` organization manages all projects.

---

### 2. **Folders** (optional)
- Logical groupings of projects or other folders.
- Useful for **departments**, **environments** (dev/stage/prod), or **regions**.
- Can apply **IAM policies** or **org policies** at folder level.

🔧 Example: `prod/`, `dev/`, `security/` folders under the same org.

---

### 3. **Projects**
- Fundamental unit for **billing**, **resources**, and **IAM**.
- Each resource **must belong to one project**.
- Has a **unique project ID** and **project number**.

🔧 Example: `project-webapp`, `project-database`, etc.

---

### 4. **Resources**
- Actual GCP services like **Compute Engine**, **Cloud Run**, **Cloud Storage**, etc.
- Created and managed inside a project.
- IAM roles can be applied **at this level**, but often managed at **project or folder** level.

🔧 Example: A VM instance, Cloud Run service, GCS bucket, etc.

---

### 📌 Policy Inheritance

- **IAM roles and Org Policies** propagate **top-down**:
  - Org → Folder → Project → Resource
- Lower-level permissions can be **overridden or narrowed**.
- Ensures centralized governance and decentralized flexibility.

---

### 🗂️ Visual Summary

```
[Organization]
   ├── [Folder: Dev]
   │     └── [Project: Dev-App]
   │           └── [Resource: Cloud Run]
   ├── [Folder: Prod]
   │     └── [Project: Prod-DB]
   │           └── [Resource: Cloud SQL]
```

---

### 📝 日本語まとめ

| 階層           | 説明 |
|----------------|------|
| **Organization** | 組織のルートノード（例：example.com） |
| **Folder**      | 部門・環境・用途別にプロジェクトをグループ化（任意） |
| **Project**     | 請求・IAM・リソースの単位。すべてのリソースはプロジェクトに属する |
| **Resource**    | 実際のGCPサービス（VM、Storageなど） |

- IAMや組織ポリシーは、上から下へ継承される（オーバーライド可能）

---

Great! Here's a simple and clear explanation of **Service Accounts vs. User Accounts** and **IAM roles** in Google Cloud — tailored for GCP ACE learning:

---

## 🔐 Identity Types in GCP: User Account vs. Service Account

### 👤 1. **User Account**
- A **human user** with a Google account (e.g., `you@gmail.com` or `you@company.com`)
- Authenticates interactively (login via browser)
- Used for manual access: Cloud Console, `gcloud` CLI, etc.
- **Assigned IAM roles** to manage or access GCP resources

🔧 Example: A developer logging in to deploy an app.

---

### 🤖 2. **Service Account**
- A **non-human identity** used by apps, VMs, or services to **access other GCP services**
- Acts as an identity for **automated processes**
- Can be **granted roles** and **used to sign tokens** to call APIs

🔧 Example: A Cloud Run app using a service account to access Cloud Storage.

---

### 🔑 IAM Roles and Scopes

- **IAM Role**: A set of permissions (e.g., `roles/storage.objectViewer`)
- Can be attached to:
  - User accounts
  - Service accounts
  - Groups

- **Scope of IAM Role Assignment**:
  - **Organization level**: applies to all folders/projects/resources
  - **Folder level**
  - **Project level**
  - **Resource level**

---

## 🧠 Key Concept: Least Privilege

- Grant **only the permissions needed**
- Example: Give a VM's service account `roles/logging.logWriter`, not `Editor`

---

### 📝 日本語まとめ

| 種類            | 説明 |
|-----------------|------|
| **ユーザーアカウント** | 人間のユーザー。Google アカウントで認証。コンソールや CLI に使用。 |
| **サービスアカウント** | アプリや VM などが使う "非人間" のアカウント。APIアクセスなどに利用。 |

- IAM ロールは組織・フォルダ・プロジェクト・リソース単位で割当可能  
- **最小権限の原則**を守ることが重要
---

