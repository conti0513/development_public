### ✅ `docs/summary.md`（日英併記）

```markdown
# 🛠 Windows 11 自動セットアップ / Windows 11 Automated Setup

## 📌 概要 / Overview

Windows 11 初期セットアップ（いわゆる「キッティング」）を、PowerShell と USB メモリを活用して自動化しました。  
アプリのインストール、ユーザー作成、設定反映をまとめてスクリプト実行可能にし、**工数を50%以上削減**。  
有料ツールを使わず、**コストゼロ**で再現性の高いキッティングを実現しました。

This is an automation toolkit for provisioning Windows 11 devices using PowerShell and a USB drive.  
It automates app installation, user creation, and system config — reducing setup time by **over 50%**.  
Implemented with **zero cost**, using only built-in Windows tools.

---

## 🎯 主な目的 / Key Goals

- PowerShell によるキッティングの自動化 / Automate PC setup via PowerShell
- 無料・オフライン運用対応 / Operate with no license costs or internet access
- チーム引き継ぎ可能な再現性のある構成 / Make it reusable for team handover

---

## 📂 構成 / Structure

```
windows_setup_automation/
├── scripts/           # PowerShell スクリプト / Setup scripts
├── csv_templates/     # CSV サンプル / Sample CSV files
├── images/            # スクリーンショット / Screenshots
└── docs/              # この概要ファイル / Documentation
```

---

## ✅ 成果 / Outcome

- 工数50%以上削減 / 50%+ reduction in setup time  
- 非エンジニアでもセットアップ実行可能 / Non-tech staff can perform setup  
- ネットワーク不通環境でも運用可能 / Fully offline-capable

---

## 💡 補足 / Notes

- 管理者権限が必要 / Requires admin privileges  
- `.csv` 編集だけで簡単カスタマイズ可能 / Easily configurable via CSV  
- Chocolatey なしで即運用可 / Works without Chocolatey or winget

---

## 📎 利用シーン例 / Use Cases

- 小売現場や教育機関での大量展開  
- 中小企業での IT 部門負荷軽減  
- 海外拠点でのローカルオフライン初期化対応

```

