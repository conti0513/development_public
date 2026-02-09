#!/usr/bin/env bash
set -euo pipefail

ROOT="/workspaces/development_public/devops_notes/Terraform"
SANDBOX="${ROOT}/sandbox"

# ガード：想定外のパス削除を防止
case "$SANDBOX" in
  *"/devops_notes/Terraform/sandbox") : ;;
  *) echo "Refusing to clean: unexpected SANDBOX=$SANDBOX"; exit 1 ;;
esac

echo "[i] Cleaning sandbox: $SANDBOX"
rm -rf "${SANDBOX}"

echo "[i] Re-create minimal scaffold"
mkdir -p "${SANDBOX}/01_init_validate" \
         "${SANDBOX}/02_gcp_connect" \
         "${SANDBOX}/03_cloudrun_hello"
: > "${SANDBOX}/.gitkeep"

echo "[✓] Sandbox reset complete."

