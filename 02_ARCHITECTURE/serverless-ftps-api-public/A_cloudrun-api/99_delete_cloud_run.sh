#!/bin/bash

echo "❌ Cloud Run サービスを削除..."
gcloud run services delete cloudrun-ftps-api --region="asia-northeast1" --quiet

echo "✅ Cloud Run サービス削除完了"
