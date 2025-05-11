# 📘 Today I Learned (TIL) – Security & Infrastructure Focus

## 📌 Overview / 概要

> 📘 This repository is a **bilingual, structure-oriented portfolio**,
> focusing on **secure system design, infrastructure automation, and Zero Trust architecture**,
> optimized for remote-first operations and quiet, failure-resistant environments.

このリポジトリは、**セキュアな構成設計、クラウドインフラ運用、自動化、ゼロトラスト構成**を中心に、
**静かに壊れず、属人性のない構成の実装知見**を蓄積・共有するナレッジベースです。

**実装・構成・監視・運用をコード化／ドキュメント化し、リモート・非同期でも耐えうるセキュリティエンジニア像を体現**しています。

---

## 🔐 Featured: Zero Trust & Security Architecture Glossary

This repository also includes a **Zero Trust and Security Architecture glossary (EN/JP)**,
mapping **key security terms to my real-world project experience** in infrastructure, operations, and cloud services.

📍 [View the glossary (EN/JP) here](./zero_trust_terms_enjp.md)

---

このリポジトリには、\*\*ゼロトラスト・セキュリティ構造カタログ（英日対応）\*\*も収録しています。
**商談・履歴書・構成提案など、幅広い用途に対応する“静かな説得力”を備えたナレッジカタログ**です。

📍 [グロッサリーを見る（EN/JP）](./zero_trust_terms_enjp.md)

---

## 🛠️ Workflow / 運用指針

* **日々または週単位で短時間でも積み上げ（TIL）**
* **Security+対策と、実務に基づく検知ロジック・構成例を並行公開**
* **構成・運用は「静か・再現性・非属人化」を重視**

📍 日次ログ → `entries/YYYY/MM/DD.md`
📍 構成例 → `project_examples/`, `devops_notes/`

---

## 📁 Directory Structure / ディレクトリ構成

```bash
.
├── TIL/
│   ├── entries/             # 日々の学び・実務ログ
├── devops_notes/            # 構成・監視設計メモ
├── project_examples/        # PoC・通知連携・自動化ツール
├── 00_sample_web_server/    # 死活監視用軽量サーバー（Flask）
├── zero_trust_terms_enjp.md # ゼロトラスト×構成ナレッジカタログ（EN/JP）
└── README.md
```

---

## 🔐 Sample Topics / 実装・学習トピック例

* GCP Logging → Cloud Function → Slack 通知（軽量SIEM構成）
* 死活監視（ローカル or Cloud）＋Webhook連携スクリプト
* 802.1XやNGFWの要点整理（Security+対策含む）
* Cloud Run + 固定IP接続によるFTPSセキュア転送構成
* TILとCompTIAの学習接続ログ（EN⇔JP対応）
* Zero Trust / Quiet Engineer Handbook（商談用）

---

## 🎯 Motivation / 目的と戦略

* 「派手ではないが壊れない」構成力・検知力を静かに示す
* 文書管理型ISMSではなく、**実装型・現場対応型セキュリティを実践**
* グローバル・リモート案件向けに、**バイリンガル対応×静かな構成力**を可視化

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

A bilingual IT engineer specializing in **infrastructure, security operations, and secure monitoring systems.**
I design **quiet, failure-resistant systems** that support **high-accountability, remote-first environments.**

インフラ／監視／自動化／ゼロトラスト構成をベースに、**静かで壊れない、属人性のない構成設計**を得意とするエンジニアです。

---

> **Reduce noise.
> Monitor smart.
> Design quietly, deploy with confidence.**

---

## ✅ 技術ログ公開に関する説明文

### 🇯🇵 日本語版（説明用）

> これは私個人の**自己学習とスキル証明**を目的とした技術ブログです。
> 記録内容は**抽象化された構成設計・設計思想・学習ログ**であり、
> **社内情報・顧客名・個人情報・脆弱性などは一切含まれていません。**
>
> 日本的な「様式美」を重視し、**構造の見える化・再現性・非属人化**を意識したナレッジ整理を行っています。

---

### 🇺🇸 English Version (For Global Transparency)

> This is a **technical blog for personal learning and skill demonstration.**
> All contents are based on **abstracted architecture, design reasoning, and daily learning logs.**
> No internal data, credentials, customer identifiers, or vulnerabilities are included.
>
> Inspired by the Japanese value of **yōshiki-bi (様式美)**—aesthetic structure—
> the content is designed for **clarity, reproducibility, and de-personalized operations.**

---
