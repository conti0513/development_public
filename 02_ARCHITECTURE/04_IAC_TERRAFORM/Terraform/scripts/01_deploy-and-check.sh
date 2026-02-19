#!/bin/bash
set -e
PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"
SERVICE_NAME="opengemini-lite"

echo "🚀 [1/2] Cloud Run へデプロイ中 (Secret Manager 連携版)..."
gcloud run deploy $SERVICE_NAME \
    --source . \
    --region $REGION \
    --project $PROJECT_ID \
    --clear-env-vars \
    --set-secrets="GEMINI_API_KEY=GEMINI_API_KEY:latest,GITHUB_PAT=GITHUB_PAT:latest" \
    --allow-unauthenticated \
    --timeout=300 \
    --max-instances=1

echo "🔍 [2/2] 動作確認（ヘルスチェック）..."
URL=$(gcloud run services describe $SERVICE_NAME --region $REGION --project $PROJECT_ID --format='value(status.address.url)')
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Success! Agent is alive (Status: $HTTP_STATUS)"
else
    echo "❌ Failed (Status: $HTTP_STATUS). Logs:"
    gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME" --limit=5 --format="table(timestamp,textPayload)"
fi
