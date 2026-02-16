#!/usr/bin/env bash
set -euo pipefail

ROOT="/workspaces/development_public/devops_notes/Terraform"
SANDBOX="${ROOT}/sandbox"

echo "[i] Removing all files under ${SANDBOX} (keeping folder)"
find "${SANDBOX}" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
: > "${SANDBOX}/.gitkeep"
echo "[✓] Cleaned."

