#!/bin/bash
GREEN='\033[0-32m'
BLUE='\033[0-34m'
NC='\033[0m'

echo -e "${BLUE}=== [Step 3: Forced Build & Deploy] ===${NC}"
# ソースに「デプロイ時間」を刻むことで、キャッシュを物理的に無効化（ハッシュ値変更）
echo "// deploy-timestamp: $(date)" >> app/legacy/legacy_system.js

# 再デプロイ
gcloud run deploy legacy-app \
  --source app/legacy \
  --region asia-northeast1 \
  --quiet

echo -e "${BLUE}=== [Step 4: Waiting for Routing... (10s)] ===${NC}"
sleep 10

SERVICE_URL=$(gcloud run services describe legacy-app --region asia-northeast1 --format='value(status.url)')
echo -e "Testing URL: ${SERVICE_URL}/direct-debug\n"

echo -e "${BLUE}=== [Step 5: Final Verification] ===${NC}"
curl -X POST -v -d "text=ASIS-BOMB" "${SERVICE_URL}/direct-debug"

echo -e "\n\n${GREEN}Verification complete.${NC}"
