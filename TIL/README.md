# 🗂️ Today I Learned (TIL)

## 📌 概要 / Overview

このリポジトリは、日々の学び・業務・改善活動を記録する「TIL（Today I Learned）」用です。  
日々5〜15分で、業務やクラウド設計、英語学習の成果・気づきを記録しています。

This is a collection of daily technical notes and learnings.  
Each entry is short and focused, written in 5–15 minutes, covering cloud, internal IT, English learning, and more.

---

## 🧭 目的 / Purpose

スキルや実務の記録をシンプルに整理
海外・リモート案件に向けたポートフォリオづくり
小さく続けて、着実にレベルアップ

To keep a simple record of skills and daily work,
build a lightweight portfolio for remote/global projects,
and grow step by step through daily habits.

---

## 🏗️ ディレクトリ構成 / Structure

```bash
TIL/
├── entries/             # 日ごとのTIL（YYYY/MM/DD.md）
├── categories/          # カテゴリ別の抜粋まとめ
├── til_git_push.sh      # Git自動Pushスクリプト
└── README.md            # このファイル
```

例：`entries/2025/04/2025-04-02.md`

---

## 🏷️ カテゴリ一覧 / Categories

| カテゴリ（JP）              | Category (EN)                | 内容 / Description |
|----------------------------|------------------------------|--------------------|
| Cloud & Automation         | Cloud & Automation           | GCP/AWS, API開発, スクリプト自動化など |
| Internal IT / SaaS運用     | Internal IT & SaaS Ops       | M365, Entra ID, GWS, SaaS管理 |
| ネットワーク・セキュリティ  | Network & Security           | VPC, VPN, Firewall等の設計運用 |
| 横断的なIT運用対応         | Cross-functional Ops         | 一人情シス, 監査, ヘルプデスク等 |
| 英語学習・海外案件対応     | English & Global Work        | 英語学習, 海外PJ準備, 英語TIL など |

---

## ✍️ TILエントリの記載例 / Sample Entry Format

```markdown
# TIL: 2025-04-03

## ✅ 成果 / Highlight  
Automated Windows provisioning with Power Automate  
→ Efficient GUI-based setup for internal use.

## 🧠 学び / Learnings  
- Low-code automation can speed up IT onboarding
- Works well for scaling internal IT ops

## 🏷️ Tags (カテゴリチェック)
- [x] Cloud & Automation
- [x] Internal IT & SaaS Ops
- [ ] Network & Security
- [x] Cross-functional Ops
- [x] English & Global Work
```

---

## 🛠️ 運用ルール / Daily Workflow

| 時間 | 内容 |
|------|------|
| 5分  | 今日の実績・気づきメモ  
| 5分  | Markdownで追記（英日OK）  
| 5分  | `til_git_push.sh` でコミット＆Push

---

## 🚀 Git操作の基本コマンド

```bash
# すべての変更を反映
git add -A
git commit -m "Update TIL: YYYY-MM-DD entry"
git push
```

または：

```bash
# スクリプトで一括処理
./til_git_push.sh
```

---

## 🧠 その他Tips

- `categories/*.md` に抜粋を転記 → Zennや電子書籍への展開素材に
- 書けない日は1行だけでもOK → 継続重視
- Markdown推奨 → GitHubでの見やすさUP

---

Happy learning & small daily wins! 🎯
