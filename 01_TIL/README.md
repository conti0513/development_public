# 🌌 Development Public / 2026 Innovation Layer

## 🛠️ Main Feature: OpenGemini-Lite (AI-Driven Pipeline)
Slack を起点とし、最新の AI モデルと CI/CD パイプラインを直結させた自律型イベント駆動基盤。

---

## 🌌 AI-Native Development Lifecycle
人間と AI エージェント（OpenGemini-Lite）が共作する「AI共存型ワークフロー」の実践。

### 📊 開発ライフサイクル (Mermaid)

```mermaid
sequenceDiagram
    autonumber
    actor Human as 👤 自分 (Local)
    participant Shell as 🐚 Operations Shells
    participant GitHub as 🐙 GitHub (Remote)
    participant AI as 🧠 AI Agent (Cloud Run)

    Note over Human, AI: 🛠️ 開発開始フェーズ
    Human->>Shell: 1. ./01_sync_ai.sh
    Shell->>GitHub: Fetch & Rebase (AI成果の回収)
    GitHub-->>Human: 最新のTIL/成果物が手元に

    Note over Human, AI: ✍️ 執筆・開発フェーズ
    Human->>Shell: 2. ./02_create_today.sh
    Shell-->>Human: 今日のテンプレート生成
    Human->>Human: 開発 & ドキュメント執筆

    Note over Human, AI: 🚀 公開・AI起動フェーズ
    Human->>Shell: 3. ./03_publish_all.sh
    Shell->>GitHub: Push to Main
    GitHub->>AI: Webhook (Event Trigger)
    AI->>AI: 思考・推論 (OpenGemini-Lite)
    AI->>GitHub: 自律的な成果生成 (PR/Commit)

    Note over Human, AI: 🔄 サイクル完了（翌日へ）
```

### 🐚 運用スクリプト (標準ルーチン)
1. **./01_sync_ai.sh** : リモートのAI成果をローカルへ同期。
2. **./02_create_today.sh** : 今日のTILテンプレートを生成。
3. **./03_publish_all.sh** : 成果をPushし、AIエージェントを起動。

---

## ⚙️ システム管理・運用ツール (Admin & Debug)
通常ルーチン以外で、挙動の確認やメンテナンスが必要な際に使用します。

| エイリアス | 絶対パス | 用途 |
| :--- | :--- | :--- |
| **ag-check** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/check.sh | **稼働確認:** Slack受信やAI推論、制限（429）の状況確認 |
| **ag-deploy** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/deploy.sh | **再デプロイ:** Cloud Run環境への最新コードの反映 |
| **ag-debug** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/gh-debug-run.sh | **デバッグ:** GitHub Actionsの実行エラーログの解析 |
| **ag-clean** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/gh-clean.sh | **一括削除:** 不要になったPRやブランチの整理 |
| **auth-gcp** | /workspaces/development_public/02_ARCHITECTURE/04_IAC_TERRAFORM/Terraform/scripts/setup_auth_min.sh | **認証更新:** GCP操作に必要な認証情報の再取得 |

---
## 📝 実装のポイント
- **セキュア通信**: Base64エンコードにより特殊記号によるエラーを回避。
- **モデル追従**: \`gemini-flash-latest\` 指定により最新モデルへ自動追従。
- **制限緩和**: 安全フィルター設定を調整し、技術的な出力を最適化。
