#!/bin/bash

echo "🔐 GCP Application Default Credentials (ADC) の認証を開始します..."

# ブラウザが自動で開かない環境（Codespaces等）を想定し、リンクを表示するモードで実行
gcloud auth application-default login --no-launch-browser

echo ""
echo "✅ 認証が完了したら、以下のコマンドで現在のアカウントを確認してください:"
echo "gcloud auth application-default print-access-token"