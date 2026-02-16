#!/bin/bash
echo "🧹 Cleaning up dependencies..."
rm -f go.mod go.sum
go mod init opengemini-lite
go mod tidy

echo "🚀 Deploying to Cloud Run (Revision: 2026-Best-Practice)..."
gcloud run deploy opengemini-lite \
  --source . \
  --region asia-northeast1 \
  --set-secrets="GITHUB_PAT=GITHUB_PAT:latest" \
  --set-env-vars="GEMINI_API_KEY=AIzaSyBjeZTE9JHRI3xMoLXwpWQTx0jvTXcmfQI" \
  --allow-unauthenticated \
  --quiet

echo "✅ Deployment Triggered! Wait a moment, then run ./check.sh"
