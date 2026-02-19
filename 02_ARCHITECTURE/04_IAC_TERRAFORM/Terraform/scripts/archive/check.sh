#!/bin/bash
SERVICE_NAME="opengemini-lite"

echo "--- [1. Slack Arrival] ---"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:Processing" --limit 3 --format="table(timestamp, textPayload)"

echo -e "\n--- [2. Logic Success (Flexible Parsing)] ---"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:✅" --limit 3 --format="table(timestamp, textPayload)"

echo -e "\n--- [3. GitHub Dispatch Outcome] ---"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:Dispatch" --limit 3 --format="table(timestamp, textPayload)"

echo -e "\n--- [4. Error Hunt (Check Raw Data if fails)] ---"
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME AND textPayload:❌" --limit 3 --format="table(timestamp, textPayload)"
