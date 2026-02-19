#!/bin/bash
PROJECT_ID="terraform-sandbox-lab"
SERVICE_NAME="opengemini-lite"

echo "🔍 [1/4] Cloud Run サービス基本状態"
gcloud run services describe $SERVICE_NAME --region asia-northeast1 --format="value(status.conditions)"

echo -e "\n🤖 [2/4] Gemini API / ロジックエラーの抽出 (直近10件)"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"Error\" OR textPayload:\"❌\")" \
  --limit 10 --format="table(timestamp,textPayload)"

echo -e "\n🐙 [3/4] GitHub PR作成 / Git操作の成否"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND (textPayload:\"GitHub\" OR textPayload:\"PR\")" \
  --limit 5 --format="table(timestamp,textPayload)"

echo -e "\n📡 [4/4] Slack Event 受信ログ（疎通確認）"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:\"Slack\"" \
  --limit 5 --format="table(timestamp,textPayload)"

echo -e "\n💡 [TIPS] リアルタイムでログを流し続けたい場合は、以下を叩いてください:"
echo "gcloud logging tail --project $PROJECT_ID"
