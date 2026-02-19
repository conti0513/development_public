#!/bin/bash

REPO="conti0513/development_public"

echo "🔍 OpenなPRを取得中..."
# PRの一覧を表示（番号とタイトル）
gh pr list --repo $REPO --limit 10 --json number,title --template \
'{{range .}}{{tablerow (printf "#%v" .number | autoresize) .title}}{{end}}'

echo -e "\nどのPRをクローズしますか？"
echo "  - 番号を入力 (例: 25)"
echo "  - 全て消すなら 'all'"
echo "  - やめるなら 'q'"
read -p ">> " TARGET

if [ "$TARGET" == "all" ]; then
    echo "⚠️ 全てのPRをクローズし、ブランチを削除します..."
    gh pr list --repo $REPO --json number -q '.[].number' | xargs -I {} gh pr close {} --repo $REPO --delete-branch
elif [ "$TARGET" == "q" ]; then
    echo "キャンセルしました。"
else
    # 数値チェック
    if [[ $TARGET =~ ^[0-9]+$ ]]; then
        echo "✅ PR #$TARGET をクローズ中..."
        gh pr close $TARGET --repo $REPO --delete-branch
    else
        echo "❌ 無効な入力です。"
    fi
fi