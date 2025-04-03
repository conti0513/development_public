# GCP Associate Cloud Engineer (ACE)

## 📘 Overview
Studying for the ACE exam to enhance my cloud architecture and operations capability in a global context.

## 🧩 Key Concepts & Cheat Sheets

Perfect! Here's a clear and concise TIL-style summary based on NIST definitions and GCP ACE requirements — bilingual format, ready to paste into your `TIL/categories/gcpace.md`:

---

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
