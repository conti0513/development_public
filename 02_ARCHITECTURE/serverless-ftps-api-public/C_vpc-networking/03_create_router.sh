set -e
CONFIG_FILE="config.network.json"

PROJECT_ID=$(jq -r '.project_id' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
NETWORK_NAME=$(jq -r '.network.name' "$CONFIG_FILE")
ROUTER_NAME=$(jq -r '.nat.router_name' "$CONFIG_FILE")

gcloud compute routers create "$ROUTER_NAME" \
	  --project="$PROJECT_ID" \
	    --region="$REGION" \
	      --network="$NETWORK_NAME"

echo "✅ Router '$ROUTER_NAME' 作成完了"

