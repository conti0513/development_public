#!/bin/bash
set -e

PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"
SERVICE_NAME="opengemini-lite"

echo "📦 [1/3] Artifact Registry の準備..."
# リポジトリがなければ作成する（エラーを回避）
gcloud artifacts repositories create cloud-run-source-deploy \
    --repository-format=docker \
    --location=$REGION \
    --project=$PROJECT_ID \
    --description="Cloud Run Source Deployments" || echo "✅ Repository already exists."

echo "🚀 [2/3] Cloud Run へデプロイ中..."
gcloud run deploy $SERVICE_NAME \
    --source . \
    --region $REGION \
    --project $PROJECT_ID \
    --set-env-vars="GEMINI_API_KEY=${GEMINI_API_KEY}" \
    --set-secrets="GITHUB_PAT=GITHUB_PAT:latest" \
    --allow-unauthenticated

echo "🔍 [3/3] 動作確認（ヘルスチェック）..."
URL=$(gcloud run services describe $SERVICE_NAME --region $REGION --project $PROJECT_ID --format='value(status.address.url)')
echo "🌐 Service URL: $URL"

# 実際に叩いてみて、200 OK が返るか確認
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Success! Agent is alive (Status: $HTTP_STATUS)"
else
    echo "❌ Failed... Agent returned Status: $HTTP_STATUS"
    echo "📝 [LOGS] 最新のエラーログを表示します:"
    gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME" --limit=5 --format="table(timestamp,textPayload)"
fi
