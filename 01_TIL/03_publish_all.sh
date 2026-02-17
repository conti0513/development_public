#!/bin/bash

WORK_DIR="/workspaces/development_public"
BRANCH="main"

cd "$WORK_DIR" || { echo "❌ エラー: $WORK_DIR に移動できません"; exit 1; }

# Git ステータス表示
git status

# コミットメッセージ入力（Enterでデフォルト）
read -p "コミットメッセージを入力 (Enterでデフォルト): " commit_message
commit_message=${commit_message:-"Update $(date +%Y-%m-%d)"}

# 全変更（未追跡含む）を add
git add -A
git commit -m "$commit_message"
git push origin "$BRANCH"

echo "✅ Gitの更新が完了しました！（$WORK_DIR）"
