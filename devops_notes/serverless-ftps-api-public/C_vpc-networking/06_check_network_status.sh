#!/bin/bash
set -e
CONFIG="config.network.json"

PROJECT_ID=$(jq -r '.project_id' "$CONFIG")
REGION=$(jq -r '.region' "$CONFIG")
NETWORK=$(jq -r '.network.name' "$CONFIG")
SUBNET=$(jq -r '.network.subnet.name' "$CONFIG")
ROUTER=$(jq -r '.nat.router_name' "$CONFIG")
NAT_NAME=$(jq -r '.nat.nat_name' "$CONFIG")
CONNECTOR=$(jq -r '.vpc_connector.name' "$CONFIG")

echo "🔍 ネットワーク構成確認: [$PROJECT_ID / $REGION]"
echo "----------------------------"

# VPCネットワーク確認
echo "📡 VPCネットワーク:"
gcloud compute networks describe "$NETWORK" --project="$PROJECT_ID" --format="get(name)"

# サブネット確認
echo "🌐 サブネット:"
gcloud compute networks subnets describe "$SUBNET" --region="$REGION" --project="$PROJECT_ID" --format="get(name, ipCidrRange)"

# ルーター確認
echo "🛣️ Cloud Router:"
gcloud compute routers describe "$ROUTER" --region="$REGION" --project="$PROJECT_ID" --format="get(name)"

# NAT確認
echo "🌐 Cloud NAT:"
gcloud compute routers nats describe "$NAT_NAME" --router="$ROUTER" --region="$REGION" --project="$PROJECT_ID" --format="get(name, natIpAllocateOption)"

# VPC Connector確認
echo "🔌 VPC Connector:"
gcloud compute networks vpc-access connectors describe "$CONNECTOR" --region="$REGION" --project="$PROJECT_ID" --format="get(name, state)"

echo "✅ ネットワーク構成の確認完了"

