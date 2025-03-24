#!/bin/bash
set -e
CONFIG="config.network.json"

PROJECT_ID=$(jq -r '.project_id' $CONFIG)
NETWORK_NAME=$(jq -r '.network.name' $CONFIG)

gcloud compute networks create "$NETWORK_NAME" \
  --project="$PROJECT_ID" \
  --subnet-mode=custom

echo "✅ VPCネットワーク [$NETWORK_NAME] 作成完了"

