# 🛠️ GWS Auto Py – Google Workspace Python Automation Tools  
# 🛠️ Google Workspace 自動化ツール（Python版）

---

## 🎯 Overview / 概要

This project provides Python-based alternatives to Google Apps Script (GAS)  
for automating tasks in Google Workspace (Gmail, Drive, Sheets, etc.).

本プロジェクトは、Gmail・Google Drive・スプレッドシートなどの操作を  
**Pythonで自動化**することで、GASの代替を目指します。

---

## 💡 Motivation / 背景

GAS scripts are convenient but may cause issues in environments where:
- Multiple users share ownership
- Transferability is required
- GAS is prohibited due to policy

GASは便利ですが、以下のような環境では問題があります：
- スクリプトオーナーの異動・退職リスク
- ソースの属人化
- 組織方針でGAS禁止（例：CTO指示）

そこで、**サービスアカウントやOAuthでのPython化**により、
より管理しやすく移譲可能な運用を実現します。

---

## 📌 Key Features / 主な特徴

- ✅ Gmail, Drive, Spreadsheet API fully supported
- 🔐 OAuth / Service Account options available
- 🔄 CLI-based or cron-compatible automation
- 🧰 Easy integration into existing workflows

---

## 📂 Directory Structure / フォルダ構成

```bash
gws_auto_py/
├── README.md              # プロジェクト概要
├── docs/                  # 設計メモ・API仕様
│   └── system_diagram.md  # 処理の全体像（任意）
├── scripts/               # 実装スクリプト
│   ├── auth_sample.py     # 認証確認スクリプト（OAuth/SA）
│   ├── gmail_notify.py    # Gmail自動通知例
│   └── drive_backup.py    # Driveファイル操作の例
```

---

## 🔐 Authentication Options / 認証方式

| Method           | Suitable for            | Notes                                |
|------------------|-------------------------|--------------------------------------|
| OAuth            | User-level operations   | Needs user consent / token refresh   |
| Service Account  | System/service tasks    | Use with shared Drive / admin setup  |

---

## ✅ Sample Use Cases / 想定ユースケース

- 📩 Gmailの定期検索・自動分類・通知
- 📁 Google Drive内のバックアップ・同期
- 📊 スプレッドシートの更新・レポート生成
- 💬 Slack / Chat連携（通知 / エラー報告）

---

## 🛠️ Notes

- Python ≥ 3.9 推奨  
- Google API Client Library を使用（`google-api-python-client`, `google-auth`）  
- `credentials.json` または `service_account.json` が必要です

---

## 📄 License

MIT License – Feel free to fork and use for your workflow.
```

---
