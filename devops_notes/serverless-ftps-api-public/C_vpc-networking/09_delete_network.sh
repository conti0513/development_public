#!/bin/bash
set -e

CONFIG="config.network.json"

PROJECT_ID=$(jq -r '.project_id' "$CONFIG")
REGION=$(jq -r '.region' "$CONFIG")
ZONE=$(jq -r '.zone' "$CONFIG")
NETWORK=$(jq -r '.network_name' "$CONFIG")
SUBNET=$(jq -r '.subnet_name' "$CONFIG")
ROUTER=$(jq -r '.router_name' "$CONFIG")
NAT_NAME=$(jq -r '.nat_name' "$CONFIG")
CONNECTOR=$(jq -r '.vpc_connector_name' "$CONFIG")

echo "🚨 VPC ネットワークリソースを削除します。"

# VPC Connector 削除
echo "🧹 VPC Connector を削除中..."
gcloud compute networks vpc-access connectors delete "$CONNECTOR" \
  --region="$REGION" \
  --quiet

# Cloud NAT 削除
echo "🧹 Cloud NAT を削除中..."
gcloud compute routers nats delete "$NAT_NAME" \
  --router="$ROUTER" \
  --region="$REGION" \
  --quiet

# Cloud Router 削除
echo "🧹 Cloud Router を削除中..."
gcloud compute routers delete "$ROUTER" \
  --region="$REGION" \
  --quiet

# Subnet 削除
echo "🧹 Subnet を削除中..."
gcloud compute networks subnets delete "$SUBNET" \
  --region="$REGION" \
  --quiet

# VPC ネットワーク削除
echo "🧹 VPC ネットワークを削除中..."
gcloud compute networks delete "$NETWORK" \
  --quiet

echo "✅ すべてのネットワークリソースを削除しました"

