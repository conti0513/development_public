#!/bin/bash
PROJECT_ID="terraform-sandbox-lab"
REGION="asia-northeast1"
SERVICE_NAME="opengemini-lite"

echo "=================================================="
echo "🛡️  OpenGemini-Lite 認証・権限 健康診断 (No.04)"
echo "=================================================="

echo -e "\n🔍 [1/3] Secret Manager: GEMINI_API_KEY"
gcloud secrets versions access latest --secret="GEMINI_API_KEY" --project=$PROJECT_ID > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 取得成功: 鍵は正しく格納されています。"
else
    echo "❌ 取得失敗: 鍵がないか、gcloudのログインが無効です。"
fi

echo -e "\n🔍 [2/3] IAM: Cloud Run Service Account"
SA_EMAIL=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')"-compute@developer.gserviceaccount.com"
gcloud secrets get-iam-policy GEMINI_API_KEY --project=$PROJECT_ID --format="value(bindings.members)" | grep -q "$SA_EMAIL"
if [ $? -eq 0 ]; then
    echo "✅ 権限確認: $SA_EMAIL に参照許可があります。"
else
    echo "❌ 権限不足: サービスアカウントに参照権限が付与されていません。"
fi

echo -e "\n🔍 [3/3] Cloud Run: Secret Binding"
CONF_CHECK=$(gcloud run services describe $SERVICE_NAME --region $REGION --project $PROJECT_ID --format="value(spec.template.spec.containers[0].envFrom)")
if echo "$CONF_CHECK" | grep -q "secretRef"; then
    echo "✅ 設定完了: Cloud Run は Secret Manager を参照しています。"
else
    echo "❌ 設定不備: 環境変数が古いか、Secretが紐付いていません。"
fi
echo -e "\n=================================================="
