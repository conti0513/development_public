#!/bin/bash
set -e

CONFIG_FILE="config.api.json"

# 設定読み込み
GCP_PROJECT=$(jq -r '.gcp_project' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
SERVICE_NAME=$(jq -r '.cloud_run.service_name' "$CONFIG_FILE")
VPC_CONNECTOR=$(jq -r '.cloud_run.vpc_connector' "$CONFIG_FILE")
TRIGGER_BUCKET=$(jq -r '.cloud_run.trigger_bucket' "$CONFIG_FILE")
EVENTARC_TRIGGER_NAME="gcs-trigger"

echo "🚀 Cloud Run A をデプロイ中..."

# Cloud Shell 対応: --egress-settings を省略
gcloud run deploy "$SERVICE_NAME" \
  --project="$GCP_PROJECT" \
  --region="$REGION" \
  --source . \
  --platform=managed \
  --allow-unauthenticated \
  --memory=512Mi \
  --timeout=300s \
  --port=8080 \
  --vpc-connector="$VPC_CONNECTOR"

echo "✅ Cloud Run A のデプロイが完了しました！"

# Cloud Run の URL を取得
CLOUD_RUN_URL=$(gcloud run services describe "$SERVICE_NAME" \
  --project="$GCP_PROJECT" \
  --region="$REGION" \
  --format "value(status.url)")
echo "🌍 Cloud Run A の URL: $CLOUD_RUN_URL"

# EventArc トリガー確認
echo "🔗 EventArc トリガー作成を確認..."
if gcloud eventarc triggers describe "$EVENTARC_TRIGGER_NAME" --location="$REGION" --project="$GCP_PROJECT" &>/dev/null; then
  echo "✅ EventArc '$EVENTARC_TRIGGER_NAME' は既に存在"
else
  gcloud eventarc triggers create "$EVENTARC_TRIGGER_NAME" \
    --project="$GCP_PROJECT" \
    --location="$REGION" \
    --destination-run-service="$SERVICE_NAME" \
    --destination-run-region="$REGION" \
    --event-filters="type=google.cloud.storage.object.v1.finalized" \
    --event-filters="bucket=$TRIGGER_BUCKET" \
    --service-account="$GCP_PROJECT@appspot.gserviceaccount.com"
  echo "✅ EventArc '$EVENTARC_TRIGGER_NAME' を作成しました"
fi

# IP チェック
echo "🔍 Cloud Run 外部IP (NAT経由) を確認..."
curl -s "$CLOUD_RUN_URL/ip-check" | jq || echo "IPチェック失敗"

echo "✅ Cloud Run A 再デプロイ完了"

