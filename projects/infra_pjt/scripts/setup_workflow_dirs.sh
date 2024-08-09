#!/bin/bash

# プロジェクトリストの入力を促す
echo "Enter the project names separated by spaces (e.g., project1 project2 project3):"
read -r -a projects

# ワークフローファイルのディレクトリを作成し、権限を付与
for project in "${projects[@]}"; do
  workflow_dir="/workspaces/development_public/infra_pjt/python_projects/${project}/.github/workflows"
  
  # ディレクトリの作成
  mkdir -p "$workflow_dir"
  
  # 権限の付与
  chmod -R 755 "$workflow_dir"
  
  echo "Created and set permissions for: $workflow_dir"
done

echo "All workflow directories created and permissions set."

