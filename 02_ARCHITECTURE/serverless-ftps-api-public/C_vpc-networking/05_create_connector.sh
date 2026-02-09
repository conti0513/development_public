et -e
CONFIG_FILE="config.network.json"

PROJECT_ID=$(jq -r '.project_id' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
NETWORK_NAME=$(jq -r '.network.name' "$CONFIG_FILE")
CONNECTOR_NAME=$(jq -r '.vpc_connector.name' "$CONFIG_FILE")
CONNECTOR_RANGE="10.8.0.0/28"  # ← 固定ならここでOK、設定化したい場合はjsonに追加

gcloud compute networks vpc-access connectors create "$CONNECTOR_NAME" \
	  --project="$PROJECT_ID" \
	    --region="$REGION" \
	      --network="$NETWORK_NAME" \
	        --range="$CONNECTOR_RANGE"

echo "✅ VPC Connector '$CONNECTOR_NAME' 作成完了"

