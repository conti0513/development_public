#!/bin/bash
set -e

CONFIG_FILE="config.api.json"

# 設定ファイル読み込み
GCP_PROJECT=$(jq -r '.gcp_project' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
BUCKET=$(jq -r '.cloud_run.trigger_bucket' "$CONFIG_FILE")
SERVICE_NAME=$(jq -r '.cloud_run.service_name' "$CONFIG_FILE")

# Cloud Run の URL を取得
CLOUD_RUN_URL=$(gcloud run services describe "$SERVICE_NAME" \
  --project="$GCP_PROJECT" \
  --region="$REGION" \
  --format="value(status.url)")

# テストファイル作成
TEST_FILE="test_upload_$(date +%Y%m%d%H%M).csv"
echo "sample,data,123" > "$TEST_FILE"

echo "📤 テストファイルを GCS にアップロード中: $TEST_FILE"
gsutil cp "$TEST_FILE" "gs://$BUCKET/"

# 待機（Cloud Run 実行を待つ）
echo "⏳ 処理待機中（10秒）..."
sleep 10

# ログ確認
echo "📜 Cloud Run のログを取得:"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME" \
  --project="$GCP_PROJECT" \
  --limit=10 \
  --format="json"

# 後片付け
rm -f "$TEST_FILE"

echo "✅ テスト完了"

