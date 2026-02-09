#!/bin/bash
set -e
CONFIG_FILE="config.network.json"

PROJECT_ID=$(jq -r '.project_id' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
NETWORK_NAME=$(jq -r '.network.name' "$CONFIG_FILE")
SUBNET_NAME=$(jq -r '.network.subnet.name' "$CONFIG_FILE")
SUBNET_RANGE=$(jq -r '.network.subnet.ip_range' "$CONFIG_FILE")

gcloud compute networks subnets create "$SUBNET_NAME" \
  --project="$PROJECT_ID" \
  --region="$REGION" \
  --network="$NETWORK_NAME" \
  --range="$SUBNET_RANGE"

echo "✅ Subnet '$SUBNET_NAME' 作成完了"

