#!/bin/bash
set -e

PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"

echo "🧹 [1/3] GCP Artifact Registry のキャッシュを浄化中..."
gcloud artifacts repositories delete cloud-run-source-deploy \
    --location $REGION --project $PROJECT_ID --quiet || echo "⚠️  Repository already clean."

echo "🧹 [2/3] ローカルの Go ビルドキャッシュをクリア中..."
go clean -cache -modcache

echo "🚀 [3/3] Dockerfile モードで Cloud Run へ強制デプロイ中..."
gcloud run deploy opengemini-lite \
    --source . \
    --region $REGION \
    --project $PROJECT_ID \
    --set-env-vars="GEMINI_API_KEY=${GEMINI_API_KEY}" \
    --set-secrets="GITHUB_PAT=GITHUB_PAT:latest" \
    --allow-unauthenticated

echo "✅ 完了！環境は完全にクリーンになり、最新版がデプロイされました。"
