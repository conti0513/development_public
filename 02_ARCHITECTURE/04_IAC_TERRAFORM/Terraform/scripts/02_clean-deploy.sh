#!/bin/bash
set -e
PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"

echo "🧹 [1/2] キャッシュをクリア中..."
gcloud artifacts repositories delete cloud-run-source-deploy --location $REGION --project $PROJECT_ID --quiet || true
go clean -cache -modcache

echo "🚀 [2/2] クリーンデプロイ中..."
gcloud run deploy opengemini-lite \
    --source . \
    --region $REGION \
    --project $PROJECT_ID \
    --clear-env-vars \
    --set-secrets="GEMINI_API_KEY=GEMINI_API_KEY:latest,GITHUB_PAT=GITHUB_PAT:latest" \
    --allow-unauthenticated \
    --timeout=300
