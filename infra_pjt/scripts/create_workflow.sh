#!/bin/bash

echo "Starting to create a workflow..."

# 対話的にユーザーから入力を受け取る
read -p "Enter workflow type (normal/rollback): " workflow_type
read -p "Enter project name (e.g., project1): " project_name

# 現在のディレクトリを取得
current_dir=$(pwd)

# YAMLファイルのパスを設定
yaml_file="$current_dir/../../.github/workflows/docker-publish-${project_name}.yml"

# YAMLファイルの内容を生成
if [ "$workflow_type" == "normal" ]; then
    cat <<EOL > $yaml_file
name: Build and Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  build-and-push-python:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: \${{ secrets.DOCKER_USERNAME }}
          password: \${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push
        uses: docker/build-push-action@v2
        with:
          context: ./infra_pjt/python_projects/${project_name}
          file: ./infra_pjt/common/Dockerfile
          push: true
          tags: butainco/${project_name}:latest

EOL
elif [ "$workflow_type" == "rollback" ]; then
    cat <<EOL > $yaml_file
name: Rollback Docker Image

on:
  workflow_dispatch:

jobs:
  rollback-python:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: \${{ secrets.DOCKER_USERNAME }}
          password: \${{ secrets.DOCKER_PASSWORD }}

      - name: Rollback
        run: |
          docker pull butainco/${project_name}:previous
          docker tag butainco/${project_name}:previous butainco/${project_name}:latest
          docker push butainco/${project_name}:latest

EOL
else
    echo "Invalid workflow type: $workflow_type"
    exit 1
fi

echo "Workflow file created successfully: $yaml_file"

