#!/bin/bash
PROJECT_ID="terraform-sandbox-lab"
SERVICE_NAME="opengemini-lite"

echo "=================================================="
echo "🔍 [1/4] Cloud Run サービス稼働状態 (Health)"
gcloud run services describe $SERVICE_NAME --region asia-northeast1 --format="value(status.conditions)"

echo -e "\n🤖 [2/4] Gemini API 思考ログ (エラー・クォータ)"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"Error\" OR textPayload:\"❌\" OR textPayload:\"Gemini\")" \
  --limit 10 --format="table(timestamp,textPayload)"

echo -e "\n🐙 [3/4] GitHub 連携・PR作成状況"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"GitHub\" OR textPayload:\"PR\" OR textPayload:\"RefError\")" \
  --limit 10 --format="table(timestamp,textPayload)"

echo -e "\n📡 [4/4] Slack 受信イベント (通信疎通)"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:\"Slack\"" \
  --limit 5 --format="table(timestamp,textPayload)"

echo -e "\n💡 [リアルタイム監視したい場合]"
echo "gcloud logging tail --project $PROJECT_ID"
echo "=================================================="
