# 開発・学習ログ（Development Public Repository）

本リポジトリは、セキュリティ運用・クラウド・PMO領域を中心に、日々の学習や小規模自動化の成果を整理した記録です。
実務経験をもとにした知見・改善策を再利用可能な形で残すことを目的としています。

---

## 📝 TIL（Today I Learned）

* 1日の学びを簡潔に記録する仕組み
* 内容は粗くてもまず残すことを優先
* 継続性を重視し、後から整理・補完

---

## 📂 リポジトリ構成

```bash
TIL/
  ├── entries/2025/...   # Daily logs
  ├── create_til_entry.sh
  └── til_git_push.sh

devops_notes/
  ├── cloud/             # クラウド関連ノート
  ├── docker/            # Docker環境・スクリプト
  ├── gas/               # Google Apps Script
  ├── powershell/        # PowerShellスクリプト
  ├── python/            # Python演習
  └── security/          # セキュリティ関連ノート

project_examples/
  ├── daily-sheet-to-slack/        # GAS 日報通知サンプル
  ├── gmailcsv_to_gcs_uploader/    # Node.js CSVアップローダー
  ├── gws_auto_py/                 # Python GWS自動化
  ├── windows_setup_automation/    # Windows セットアップ自動化
  └── zapier_form_notify_logger/   # Zapier + GCS ロガー
```

---

## 💼 キャリア概要（直近6年間）

* **2019**：大手通信会社 — M365導入支援・導入後サポート
* **2020〜2022**：ITサービス企業 — HENNGE / GWS / SaaS運用、セキュリティ教育・監査対応、一人情シス業務
* **2022〜2023**：医療系企業 — M365運用、SharePoint管理、PowerAutomate導入、VPNリプレース対応
* **2023〜2024**：製造業系SIer — Entra ID運用（海外ユーザー含む）、クラウド認証基盤管理
* **2024〜2025**：小売企業 — ESET / HENNGE / GWS、セキュリティ運用、監査、ベンダー調整、PM補佐・PMO

---

## 📌 主な取り組み・強み

* **セキュリティ運用**：ESET / HENNGE / GWS を中心としたゼロトラスト基盤運用、監査対応
* **クラウド自動化**：AWS Lambda / GCP Cloud Run を活用したファイル転送・認証処理の自動化
* **ベンダー・工程調整**：出退店に伴う弱電工程管理、発注管理、ベンダー調整
* **PMO補佐業務**：進捗管理、タスク調整、議事録・ドキュメント整理

---

## 🎯 運用ポリシー

* 記録を優先：学習や業務の成果をまず残す
* 日本語ベース：国内案件での活用を想定
* アーカイブ活用：古い・ノイズの多い情報は archive\_private/ に集約

---

## 🔑 今後の方向性

「セキュリティ運用 × クラウド基盤 × ベンダー調整」を核とし、
PMO経験も組み合わせて **再現性のある改善スキル** を強みとして磨いていきます。

---

## 📌 Example Projects / 代表的なプロジェクト

- [Serverless FTPS Transfer API on GCP](./devops_notes/serverless-ftps-api-public)  
  GCP (Cloud Run + VPC + FTPS) を使ったサーバーレス構成サンプル

- [IT Administrator Notes](./devops_notes/IT_Administrator)  
  IT管理（Apps / Cloud Solution / Windows / Mac / Network）領域のナレッジまとめ

- [Daily Sheet to Slack (GAS Example)](./project_examples/daily-sheet-to-slack)  
  Google スプレッドシートの日報を Slack に自動通知するサンプル
---
