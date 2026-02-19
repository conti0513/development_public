#!/bin/bash

REPO="conti0513/development_public"

echo "🔍 最新の失敗したWorkflowを取得中..."

# 1. 最新の失敗したRun IDを取得
FAILED_ID=$(gh run list --repo $REPO --status failure --limit 1 --json databaseId -q ".[0].databaseId")

if [ -z "$FAILED_ID" ]; then
    echo "✅ 失敗した実行は見つかりませんでした。直近の実行を表示します。"
    gh run list --repo $REPO --limit 5
    exit 0
fi

echo "🚩 Failed Run ID: $FAILED_ID"
echo "--------------------------------------------------"
echo "❌ エラーログの抜粋 (Critical Lines):"
echo "--------------------------------------------------"

# 2. 失敗ログを取得し、特に exit code や command not found 系のエラーを抽出
gh run view $FAILED_ID --repo $REPO --log-failed | grep -iE "error|fatal|command not found|syntax error|exit code"

echo -e "\n--------------------------------------------------"
echo "📝 ペイロードの展開状況を確認しますか？ (y/n)"
read -p ">> " CONFIRM

if [ "$CONFIRM" == "y" ]; then
    # 変数展開の様子が見える部分を抽出
    gh run view $FAILED_ID --repo $REPO --log-failed | grep -A 5 "RAW_CONTENT="
fi