# 📘 Today I Learned (TIL) – Security, Automation & Digital Retail

## 📌 Overview / 概要

> 📘 This repository is a **bilingual, structure-oriented portfolio**,  
> focused on **secure system design, infrastructure automation, and digital retail operations**,  
> optimized for **remote-first workflows, inventory-driven scripting**, and **quiet, failure-resistant systems**.

このリポジトリは、**セキュアな構成設計、クラウドインフラの自動化、および小売EC業務の最適化**を目的とした  
**構造的かつ非属人的なナレッジベース**です。  
**Cloud Run / GAS / GCS / Slack** などのツールを用い、**現実の業務運用に直結した設計知見**を記録しています。

---

## 🔐 Featured: Retail × Security × Automation

This repository includes:

- ✅ **Zero Trust and Security Architecture glossary (EN/JP)**
- ✅ **eBay & GAS automation samples** for listing and tracking
- ✅ **Retail workflow integration scripts** using GCS / Cloud Run / Slack
- ✅ **Monitoring logic** for real-world operations

---

## 🛠️ Workflow / 運用方針

- 毎日 or 週次で短時間の **構成メモ/TIL** を蓄積
- 実務に基づいた **eBay業務×自動化×監視構成** の検証と記録
- クラウド運用は「**静か・再現性・非属人性**」を重視
- 売上・在庫・パフォーマンス分析をコードで管理

📍 日次ログ → `entries/YYYY/MM/DD.md`  
📍 構成例 → `project_examples/`, `retail_ops/`, `devops_notes/`

---

## 📁 Directory Structure / ディレクトリ構成

```bash
.
├── TIL/                       # 日々の積み上げ（学び・業務ログ）
│   └── entries/
├── retail_ops/               # 小売業務 × 自動化 × 監視の実装例
│   └── ebay_listing_automation/
├── devops_notes/             # 構成・監視設計の技術メモ
├── project_examples/         # PoC・通知連携・インフラツールなど
├── 00_sample_web_server/     # 軽量死活監視用のFlask Web Server
├── zero_trust_terms_enjp.md  # ゼロトラスト × インフラ用語カタログ（EN/JP）
└── README.md
````

---

## 🔧 Sample Topics / 主な実装トピック例

* Cloud Logging → Cloud Function → Slack通知による軽量SIEM構成
* GmailからCSVを取得 → GCSへ自動アップロード
* eBay出品用テンプレート生成（GAS × シート連携）
* Cloud Run + 固定IP経由FTPS接続（業務連携）
* 死活監視の設計メモと実装（ローカル/クラウド）
* セキュリティ資格（Security+）の学習ログと構成整理
* ECオペレーションにおける在庫同期・価格変更・通知ロジックのPoC

---

## 🎯 Strategy / 戦略と目的

* **「壊れない×静かな構成」** ＝ 信頼性のある業務運用の支援
* **ISMS的ドキュメントではなく、実装主体のセキュリティ強化**
* **小売・EC分野に強いインフラ/セキュリティ技術者像**の可視化
* 海外バイヤー対応や非対面運用を支える**Quiet DevOps**

---

## 💡 Featured Project Examples

| Project                                                                     | Description                 |
| --------------------------------------------------------------------------- | --------------------------- |
| [daily-sheet-to-slack](./project_examples/daily-sheet-to-slack/)            | GASによる日報Slack通知             |
| [gmailcsv\_to\_gcs\_uploader](./project_examples/gmailcsv_to_gcs_uploader/) | Gmail添付CSV → GCSアップロード      |
| [ebay\_listing\_automation](./retail_ops/ebay_listing_automation/)          | eBay出品・在庫表・価格連携ワークフロー       |
| [cloudrun-ftps](./devops_notes/cloud/cloudrun-ftps/)                        | Cloud Run × 固定IPによるFTPS転送構成 |
| [sample\_web\_server](./00_sample_web_server/)                              | `/health` で応答する監視用Flaskサーバー |

---

## 👨‍💻 Author

A bilingual IT engineer specializing in **infrastructure, cloud operations, retail automation, and security monitoring**.
I design **quiet, failure-resistant systems** that support **remote-first and export-driven retail businesses**.

---

> **Reduce noise.
> Monitor smart.
> Design quietly, sell globally.**

---

## ✅ 技術ログ公開に関する説明文

### 🇯🇵 日本語版（説明用）

> これは私個人の**自己学習とスキル証明**を目的とした技術ログです。
> 内容は**実装検証・構成方針・学習記録**に基づく抽象化情報であり、
> **社内機密・顧客情報・認証情報・脆弱性等は一切含みません。**

---

### 🇺🇸 English Version (For Global Transparency)

> This is a **technical repository for personal skill-building and knowledge sharing**.
> All content is based on **abstracted architecture, implementation testing, and learning logs**.
> No proprietary data, credentials, or vulnerabilities are included.

