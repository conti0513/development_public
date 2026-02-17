$(cat /workspaces/development_public/01_TIL/README.md | grep -v "OPERATIONS.md")

---

## 🏛️ 武器庫: メンテナンス (Admin & Debug)
日常のルーチン以外で、システム側の挙動がおかしい時は以下のスクリプト（絶対パス）を使用します。

| エイリアス | 絶対パス | 用途 |
| :--- | :--- | :--- |
| **ag-check** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/check.sh | **健康診断:** Slack受信/Gemini推論/429エラーの確認 |
| **ag-deploy** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/deploy.sh | **脳の更新:** Cloud Runへの最新コードのデプロイ |
| **ag-debug** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/gh-debug-run.sh | **筋力の点検:** GitHub Actionsの失敗ログ解析 |
| **ag-clean** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/gh-clean.sh | **現場の掃除:** 不要になったPR/ブランチの一括削除 |
| **auth-gcp** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/setup_auth_min.sh | **認証更新:** GCP操作権限（ADC等）の再取得 |

---
## 📜 2026.02.16 実装メモ
- **Base64 Secure Tunneling**: 特殊記号によるシェル自爆を封印処理で完全克服。
- **Alias Strategy**: gemini-flash-latest を採用し、モデル名の404問題を撲滅。
