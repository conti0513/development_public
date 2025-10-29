#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------------------
# Minimal GCP Auth Script for Terraform Sandbox (Global)
#  - Works from any layer (03, 04, 05…)
#  - Re-authenticate via browser
#  - Set project & ADC quota
#  - Verify tokens
# -------------------------------------------------

PROJECT_ID="${PROJECT_ID:-terraform-sandbox-lab}"
TFSTATE_BUCKET="${TFSTATE_BUCKET:-${PROJECT_ID}-tfstate}"

echo "🔐 Re-authenticating with GCP..."
gcloud auth login --update-adc --no-launch-browser

echo "⚙️  Setting project and ADC quota..."
gcloud config set project "$PROJECT_ID" >/dev/null
gcloud auth application-default set-quota-project "$PROJECT_ID" >/dev/null

echo "🧪 Checking access tokens..."
gcloud auth print-access-token >/dev/null && echo "✅ gcloud OK"
gcloud auth application-default print-access-token >/dev/null && echo "✅ ADC OK"

echo "✅ Authentication completed for project: $PROJECT_ID"
echo "📁 Current directory: $(pwd)"
