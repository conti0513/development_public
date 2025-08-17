#!/bin/bash

set -e  # エラー時に停止

CONFIG_FILE="config.json"

# 設定ファイルから値を取得
GCP_PROJECT=$(jq -r '.gcp_project' "$CONFIG_FILE")
GCS_BUCKET=$(jq -r '.gcs_bucket' "$CONFIG_FILE")
TRIGGER_FOLDER=$(jq -r '.gcs_trigger_folder' "$CONFIG_FILE")
SERVICE_NAME=$(jq -r '.cloud_run.service_name' "$CONFIG_FILE")
REGION=$(jq -r '.cloud_run.region' "$CONFIG_FILE")

# Cloud Run のエンドポイント取得
CLOUD_RUN_URL=$(gcloud run services describe "$SERVICE_NAME" --region "$REGION" --format "value(status.url)")

# **GCS にテストファイルをアップロード**
echo "📂 テストファイルを GCS にアップロード..."
TEST_FILE="test_upload_$(date +%Y%m%d%H%M).csv"
echo "sample,data,123" > "$TEST_FILE"
gsutil cp "$TEST_FILE" "gs://$GCS_BUCKET/$TRIGGER_FOLDER/"

echo "✅ GCS に $TEST_FILE をアップロード"

# **EventArc トリガーの発火を確認**
echo "📜 EventArc のトリガーログを確認..."
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME" --limit 10 --format=json

# **Cloud NAT のログ確認**
echo "🌐 Cloud NAT のログを確認..."
gcloud logging read "resource.type=gce_router AND protoPayload.methodName=compute.routers.insertNat" --limit 10 --format=json

echo "✅ Cloud Run A のテスト完了！"

# 一時ファイル削除
rm -f "$TEST_FILE"

{
  "pjt_id": "your-gcp-project",
  "gcp_project": "your-gcp-project",
  "region": "asia-northeast1",
  "cloud_run": {
    "service_name": "cloudrun-ftps-api",
    "trigger_bucket": "gcs-ftps-trigger-tokyo"
  },
  "ftps": {
    "host": "your.ftps.server",
    "port": 21,
    "username": "your_username",
    "password": "your_password",
    "protocol": "FTPS",
    "mode": "passive"
  }
}
