#!/bin/bash

# FTPS用の仮想マシンを作成するスクリプト
# 名前やゾーンは適宜変更してください

PROJECT_ID="your-gcp-project"
ZONE="asia-northeast1-b"
INSTANCE_NAME="ftps-instance"
MACHINE_TYPE="e2-micro"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
STARTUP_SCRIPT="startup-ftps.sh"

echo "🔧 FTPS仮想マシンを作成中..."

gcloud compute instances create "$INSTANCE_NAME" \
  --project="$PROJECT_ID" \
  --zone="$ZONE" \
  --machine-type="$MACHINE_TYPE" \
  --image-family="$IMAGE_FAMILY" \
  --image-project="$IMAGE_PROJECT" \
  --tags=ftps-server \
  --metadata=startup-script="$(cat $STARTUP_SCRIPT)" \
  --scopes=https://www.googleapis.com/auth/cloud-platform

echo "✅ FTPSサーバー（$INSTANCE_NAME）を作成しました"
#!/bin/bash
# FTPSサーバー作成スクリプト
