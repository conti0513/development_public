#!/bin/bash
set -e
CONFIG_FILE="config.network.json"

REGION=$(jq -r '.region' "$CONFIG_FILE")
ROUTER_NAME=$(jq -r '.nat.router_name' "$CONFIG_FILE")
NAT_NAME=$(jq -r '.nat.nat_name' "$CONFIG_FILE")

gcloud compute routers nats create "$NAT_NAME" \
  --router="$ROUTER_NAME" \
  --router-region="$REGION" \
  --nat-all-subnet-ip-ranges \
  --auto-allocate-nat-external-ips

echo "✅ NAT '$NAT_NAME' 作成完了"

