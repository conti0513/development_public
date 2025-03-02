#!/bin/bash

WORK_DIR="/workspaces/development_public"
BRANCH="main"

# カレントディレクトリを作業ディレクトリに移動
cd "$WORK_DIR" || { echo "❌ エラー: $WORK_DIR に移動できません"; exit 1; }

# Git ステータス確認
git status

# コミットメッセージの入力（Enterキーでデフォルト）
read -p "コミットメッセージを入力 (Enterでデフォルト): " commit_message
commit_message=${commit_message:-"Update $(date +%Y-%m-%d)"}

# Git コマンド実行
git add .
git commit -m "$commit_message"
git push origin "$BRANCH"

# 成功メッセージ
echo "✅ Gitの更新が完了しました！（$WORK_DIR）"
