# 📘 Today I Learned (TIL) – Security Focus

## 📌 Overview / 概要

This repository documents technical insights, hands-on security practices, and automation tools—built from real-world infrastructure experience.
It serves as both a **daily learning log** and a **portfolio for high-accountability, security-aware roles**, especially in **remote-first environments**.

このリポジトリは、監視ネットワークやクラウドセキュリティの設計・運用経験をもとに、日々の学びと再利用可能なスクリプト群を記録した「実務寄りのナレッジベース」です。
**運用負荷の削減・構成の見える化・監査への耐性**を意識した構成になっています。

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



