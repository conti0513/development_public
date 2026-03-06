#!/bin/bash

WORK_DIR="/workspaces/development_public"
BRANCH="main"

cd "$WORK_DIR" || { echo "❌ エラー: $WORK_DIR に移動できません"; exit 1; }

echo "🔄 AIエージェントの成果を確認中..."

# 1. ローカルに未コミットの変更があるか確認
if ! git diff-index --quiet HEAD --; then
    echo "📦 未コミットの変更を一時退避（Stash）します..."
    git stash
    STASHED=true
fi

# 2. リモートから最新のAI成果を取り込む
# --rebase を使うことで履歴を一本道に保つ
echo "📡 GitHubから最新のTILを取得しています..."
if git pull --rebase origin "$BRANCH"; then
    echo "✅ 同期成功！最新のAI成果を取り込みました。"
else
    echo "❌ 同期エラー: コンフリクトが発生した可能性があります。"
    exit 1
fi

# 3. 退避していた変更を戻す
if [ "$STASHED" = true ]; then
    echo "🔓 退避していたローカルの変更を復元します..."
    git stash pop
fi

echo "🏁 全ての同期作業が完了しました！（$WORK_DIR）"
