# 📘 Today I Learned (TIL) – Security Focus

## 📌 Overview / 概要

> 📘 This repository is a public-facing log of my ongoing learning and secure architecture practices,
> designed to support global collaboration and remote-first operations with traceable documentation.

This repository captures technical insights, security-aware automation, and reusable design patterns—built from practical infrastructure and monitoring experience.
It serves as both a **daily engineering log** and a **portfolio for roles requiring high accountability, minimal operational noise, and audit-readiness**.

⚙️ This repository also functions as a technical portfolio for Security+ preparation, detection logic design, and cloud-based security architecture.
---

このリポジトリは、**監視ネットワーク・クラウドセキュリティ・自動化設計**に関する日々の学びと実装例を記録した「構造化されたナレッジベース」です。
**再現性ある構成・運用負荷の削減・構成の透明性**を重視し、**リモート・非同期でも意思決定を支援できるドキュメント構成**を意識しています。
---

## 🛠️ Workflow / 運用指針

* 日々または週単位でログを記録（短文・単語レベルでもOK）
* セキュリティ監視／検知ロジックの設計例も積極的に公開
* `entries/`で日次ログ、`project_examples/`で構成・実装を整理

📍 ログ → `entries/YYYY/MM/DD.md`
📍 実装例 → `project_examples/`, `devops_notes/`

---

## 📁 Directory Structure / ディレクトリ構成

```bash
.
├── TIL/
│   ├── entries/             # 日々の学び・実務ログ
├── devops_notes/            # 構成・監視設計メモ
├── project_examples/        # PoC・通知連携・自動化ツール
├── 00_sample_web_server/    # 死活監視用軽量サーバー（Flask）
└── README.md
```

---

## 🔐 Sample Topics / 実装・学習トピック例

* GCP Logging → Cloud Function → Slack 通知（軽量SIEM構成）
* 死活監視（ローカル or Cloud）＋Webhook連携スクリプト
* 802.1XやNGFWの要点整理（Security+対策含む）
* Cloud Run + 固定IP接続によるFTPSセキュア転送構成
* TILとCompTIAの学習接続ログ（EN⇔JP対応）

---

## 🎯 Motivation / 目的と戦略
* 「派手ではないが壊れない」構成力・検知力を見せる
* 文書管理中心のISMSではなく、**現場に寄り添うセキュリティ**を実践
* グローバル・リモート案件を視野に入れた**バイリンガル対応**と**実装力の可視化**

---

## 💡 Featured Project Examples

| Project                                                                     | Description                |
| --------------------------------------------------------------------------- | -------------------------- |
| [daily-sheet-to-slack](./project_examples/daily-sheet-to-slack/)            | GASで日報をSlack通知             |
| [gmailcsv\_to\_gcs\_uploader](./project_examples/gmailcsv_to_gcs_uploader/) | GmailからCSV抽出 → GCS自動アップロード |
| [cloudrun-ftps](./devops_notes/cloud/cloudrun-ftps/)                        | Cloud Run + FTPS 転送構成      |
| [unit\_data\_csv\_automation](./project_examples/unit_data_csv_automation/) | CSV自動集計ツール（GAS）            |
| [sample\_web\_server](./00_sample_web_server/)                              | `/health`を返す軽量監視用Flaskサーバー |

---

## 👨‍💻 Author

A bilingual IT engineer specializing in infrastructure, cloud operations, and secure monitoring systems.
I design **quiet, failure-resistant systems** that support high-accountability environments.

インフラ／監視／自動化をベースに、**運用負荷を下げる静かな構成設計**を得意とするエンジニアです。
---

> Reduce noise.
> Monitor smart.
> Design quietly, deploy with confidence.

---

## ✅ 技術ログ公開に関する説明文
### 🇯🇵 日本語版（説明用）

> これは私個人の**自己学習とスキル証明**を目的とした技術ブログです。
> 記録内容は**抽象化された構成設計・設計思想・学習ログ**であり、
> **社内情報・顧客名・個人情報・脆弱性などは一切含まれていません**。
>
> また、日本的な「様式美」を重視し、**構造の見える化・再現性・非属人化**を意識しています。

---

### 🇺🇸 English Version (For Global Transparency)

> This is a **technical blog for personal learning and skill demonstration**.
> All contents are based on **abstracted architecture, design reasoning, and daily learning logs**.
> No internal data, credentials, customer identifiers, or vulnerabilities are included.
>
> Inspired by the Japanese value of **yōshiki-bi (様式美)**—aesthetic structure—
> the content is designed for **clarity, reproducibility, and de-personalized operations**.
---


