# 📘 Today I Learned (TIL)

## 📌 Overview / 概要

This repository documents daily technical insights, project experiences, and reusable tools.  
Designed as a personal knowledge base and global portfolio, especially useful for **remote and international roles**.

このリポジトリは、日々の技術的な気づきや実務経験、再利用可能なツールを記録する "Today I Learned" ログです。  
継続的な積み上げで対応力を可視化します。

---

## 🛠️ Workflow / 運用方針

- Log entries daily or weekly – even short notes are valuable  
- Use both English and Japanese as needed  
- Organize by date (`entries/`) and by example (`project_examples/`)

📍 日次ログ → `entries/YYYY/MM/DD.md`  
📍 技術スニペットや再利用PJ → `project_examples/`, `devops_notes/`

---

## 📁 Directory Structure / ディレクトリ構成

```bash
.
├── TIL/
│   ├── entries/             # 日々の学び・実務ログ
│   └── categories/          # （旧）カテゴリ整理（非推奨）
├── devops_notes/            # クラウド構成やCI/CDなどの構成メモ
├── project_examples/        # 自作スクリプト・PoC・自動化サンプル
└── README.md                # このファイル
```

---

## 🔁 Sample Topics / TILトピック例

- Automating Gmail → GCS file handling with Google Apps Script  
- Slack通知付きの日報スクリプト（GAS）  
- Shell scripting for Windows PC provisioning  
- Cloud Run × FTPS with static IP (secure transfer PoC)  
- Linux one-liner for directory-wide file inspection  
- Resume and career history for bilingual/global job search

---

## ✍️ Motivation / この活動の目的

- Make small efforts visible and reviewable  
- Convert experience into practical assets (scripts, docs, tools)  
- Strengthen bilingual output for global communication  
- Create without pressure – keep it daily and lightweight

---

## 📦 `Featured Project Examples

These are hands-on automation and integration examples I’ve built and documented as part of my daily learning (TIL).  
Each is designed to solve real-world problems with minimal cost and high reusability.

| Project | Description |
|--------|-------------|
| [daily-sheet-to-slack](./project_examples/daily-sheet-to-slack/) | Automatically post daily rows from Google Sheets to Slack |
| [form-to-slack](./project_examples/form-to-slack/) | Notify Slack when a Google Form is submitted |
| [gmailcsv_to_gcs_uploader](./project_examples/gmailcsv_to_gcs_uploader/) | Extract Gmail CSV attachments and upload to GCS |
| [unit_data_csv_automation](./project_examples/unit_data_csv_automation/) | Aggregate CSVs by unit with GAS |
| [gift-bot](./project_examples/gift-bot/) | Simple Slack bot to send randomized thank-you messages |
| [zapier_form_notify_logger](./project_examples/zapier_form_notify_logger/) | Webhook-based Google Sheets logging and Slack notification |


---

## ☁️ `devops_notes/` – 検証・構成メモ

PoCや構成検証を行ったクラウド構築・CI/CDなどの技術ログ。

```bash
devops_notes/cloud/
├── cloudrun-ftps/          # Cloud Run + FTPS の安全転送構成
├── gcp-sftp-transfer/      # GCP ↔ AWS のSFTP連携PoC
└── serverless-ftps-api/    # サーバーレス × 固定IP対応構成例
```

---

## 👨‍💻 Author

A bilingual IT engineer focused on infrastructure, automation, and cross-domain collaboration.  
I build **quiet, robust systems** that reduce operational noise and increase business value.

インフラ・自動化・越境案件に強いバイリンガルITエンジニア。  
**目立たないが壊れない仕組み**を設計・構築し、運用負荷を削減するのが得意です。

---

> Make your learning visible.  
> Keep it lightweight.  
> Keep it bilingual.  
> Keep it real.

```

---

# 🌐 THM補完用：英語で学ぶサイバーセキュリティチャンネルまとめ

## 🎧 目的

- 英語音声に触れながら、サイバーセキュリティの基本構造に慣れる
- CompTIA Security+やTHMの内容と親和性の高いものを中心に構成
- 聞き流しOK／構造学習OKの“Quiet Hero Boo”向けセレクション

---

## ✅ おすすめYouTubeチャンネル（2025年版）

### 1. [Professor Messer](https://www.youtube.com/professormesser)
- **対象資格**: CompTIA Security+ (SY0-701)
- **特徴**: 明快な発音、わかりやすいスライド、全章解説付き
- **おすすめ動画**: [SY0-701 Security+ Full Course](https://www.youtube.com/playlist?list=PLG49S3nxzAnl4QDVqK-hOnoqcSKEIDDuv)

---

### 2. [CyberSecurity 101](https://www.youtube.com/channel/UCQgL1ZrXfXapZk_eLQLDMJA)
- **特徴**: 初学者向けに短くシンプルに概念を解説
- **スタイル**: 聞き流しに最適なテンポと構成

---

### 3. [Simplilearn](https://www.youtube.com/watch?v=njPY7pQTRWg)
- **内容**: Cybersecurity basics, types of attacks, SOC, etc.
- **おすすめ動画**: “Cyber Security Full Course for Beginners” など

---

### 4. [Edureka](https://www.youtube.com/playlist?list=PL9ooVrP1hQOGPQVeapGsJCktzIO4DtI4_)
- **特徴**: エンジニア向けの技術講座チャンネル
- **内容**: Cybersecurity concepts, infrastructure, penetration testing など

---

## 🧭 Quiet Hero的な学習スタイル（組み合わせ）

| スタイル | 行動例 |
|----------|--------|
| 聞き流し学習 | 通勤中や作業中にYouTube再生（3〜5本/週） |
| メモ＋TIL連携 | 気になった単語や構造をTILに即メモ |
| TIL＋THM接続 | 聞いた内容がTHMやSecurity+学習と接続したら即記録 |

---






