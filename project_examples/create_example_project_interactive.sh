#!/bin/bash

echo "📁 Enter new project folder name (e.g. 'gmailcsv_to_gcs_uploader'):"
read PROJECT_NAME

# 空入力チェック
if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name cannot be empty."
  exit 1
fi

BASE_DIR="./$PROJECT_NAME"

# 既存確認
if [ -d "$BASE_DIR" ]; then
  echo "⚠️ Directory already exists: $BASE_DIR"
  exit 1
fi

# ディレクトリ作成
mkdir -p "$BASE_DIR/scripts"
mkdir -p "$BASE_DIR/docs"

# ファイル作成
touch "$BASE_DIR/README.md"
touch "$BASE_DIR/docs/summary.md"

# スクリプトファイル（必要に応じて拡張OK）
for f in saveLatestCsvToGCSAndDrive.js uploadToGCS.js deleteOldFilesInGCS.js saveToDrive.js authorizeStorageAccess.js
do
  touch "$BASE_DIR/scripts/$f"
done

echo "✅ Project '$PROJECT_NAME' created at: $BASE_DIR"

