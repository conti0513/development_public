#!/bin/bash
set -e
PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"

echo "🧹 [1/3] Artifact Registry のリポジトリを再作成（完全浄化）..."
# 一旦消して
gcloud artifacts repositories delete cloud-run-source-deploy --location $REGION --project $PROJECT_ID --quiet || true
# まっさらな状態で作り直す
gcloud artifacts repositories create cloud-run-source-deploy \
    --repository-format=docker \
    --location=$REGION \
    --project=$PROJECT_ID \
    --description="Cloud Run Source Deployments (Clean)"

echo "🧹 [2/3] ローカルキャッシュのクリア..."
go clean -cache -modcache

echo "🚀 [3/3] クリーンデプロイ中..."
gcloud run deploy opengemini-lite \
    --source . \
    --region $REGION \
    --project $PROJECT_ID \
    --clear-env-vars \
    --set-secrets="GEMINI_API_KEY=GEMINI_API_KEY:latest,GITHUB_PAT=GITHUB_PAT:latest" \
    --allow-unauthenticated \
    --timeout=300 \
    --max-instances=1
