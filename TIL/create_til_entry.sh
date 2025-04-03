#!/bin/bash

# Get current date components
current_year=$(date +%Y)
current_month=$(date +%m)
current_date=$(date +%Y-%m-%d)

# Define the directory path
directory="./entries/$current_year/$current_month"

# Create the directory if it doesn't exist
mkdir -p "$directory"

# Define the target file path for today
file_path="$directory/$current_date.md"

# 前回のTILを探す関数
find_latest_til() {
    # `find` コマンドで最新のTILを検索
    latest_til=$(find ./entries -type f -name "*.md" | sort | tail -n 1)
    echo "$latest_til"
}

# 最新のTILを取得
latest_file=$(find_latest_til)

# 強制的に前回のTILをコピー
if [ -n "$latest_file" ]; then
    cp "$latest_file" "$file_path"
    echo "✅ $file_path を作成しました（$latest_file をコピー）"
else
    echo "❌ エラー: 前回のTILが見つかりません"
    exit 1
fi

