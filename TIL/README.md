# Today I Learned (TIL)

## 📘 概要 / Overview

このリポジトリは、日々の学び・業務経験を簡潔に記録する **Today I Learned（TIL）ログ**です。  
自分のスキルや成果を整理し、グローバル案件や英語対応のポートフォリオとして活用しています。

This repository is a personal **Today I Learned (TIL)** log.  
It helps me organize my skills and experiences, and serves as a portfolio for global/remote projects.

---

## 🛠️ 運用方針 / Workflow

- 毎日数分でTILを書く（1日1ファイル or 数行でもOK）
- 自分の得意分野をタグ（カテゴリ）で整理
- 実績・成果は冒頭で強調して見せ方を意識

📌 日次エントリ → `entries/YYYY/MM/DD.md`  
📌 カテゴリ別整理 → `categories/` フォルダに記録を分散管理

---

## 🧩 カテゴリ定義 / Category Tags

- `Cloud & Automation`：GCP, AWS, IaC, API連携, スクリプト
- `Internal IT & SaaS Ops`：Microsoft 365, GWS, Entra ID, SaaS管理
- `Network & Security`：VPC, VPN, Firewall, セキュリティ設定
- `Cross-functional Ops`：情シス, ヘルプデスク, 監査, 複数領域対応
- `English & Global Work`：英語学習, 英語アウトプット, 海外案件対応

---

## 📂 ディレクトリ構成 / Directory Structure

```bash
TIL/
├── entries/               # 日次ログ
│   └── 2025/04/2025-04-02.md
├── categories/            # カテゴリ別アウトプット（※随時更新）
├── archive/               # 過去ログ・旧ファイル
├── til_git_push.sh        # Git push 自動化スクリプト
└── README.md              # このファイル
```

---

## 💬 Motivation

- 自分の経験・成長を「伝わる形」で見える化
- 英語と日本語で記録し、海外PJにも対応
- 小さく続けて、大きな武器に

Make your progress visible.  
Keep it simple. Keep it daily. Keep it global.

---

## 🔗 今後の拡張予定（Future Plans）

- Zenn / Note / ブログ記事化
- 英語ポートフォリオとの統合

---
```

---

## ✅ 適用手順

1. 上記の内容を `TIL/README.md` にペースト
2. コミットして push するだけで OK！

```bash
git add TIL/README.md
git commit -m "Redesign TIL README as repo landing page"
git push origin main
```

---

---

## 🧰 補足ディレクトリ / Supplementary Directories

### 📁 devops_notes/

このフォルダには、個人開発や検証で使用したコード・設定ファイルを保管しています。  
TILと並行して、クラウドアーキテクチャ・自動化スクリプト・CI/CDの設計などを記録。

This directory contains development and test artifacts, such as cloud architecture samples, automation scripts, and CI/CD prototypes.  
Used in parallel with TIL entries for deeper experimentation and system design.

```bash
devops_notes/
├── cloud/
│   ├── gcp-sftp-transfer/      # GCP ↔ AWS のデータ連携PoC
│   ├── cloudrun-ftps/          # Cloud Run + FTPS のサーバーレス構成
│   └── serverless-ftps-api/    # 本番を想定したAPI構成
├── projects/
│   └── infra_pjt/              # ポートフォリオ用のインフラ構築プロジェクト
└── ...
