#!/bin/bash

echo "Starting to create rollback workflow for Project1..."

# 必要なディレクトリとファイルが存在するか確認
if [ ! -d "/workspaces/development_public/infra_pjt/common" ]; then
  echo "Error: Directory /workspaces/development_public/infra_pjt/common does not exist."
  exit 1
fi

if [ ! -f "/workspaces/development_public/infra_pjt/common/Dockerfile" ]; then
  echo "Error: File /workspaces/development_public/infra_pjt/common/Dockerfile does not exist."
  exit 1
fi

if [ ! -f "/workspaces/development_public/infra_pjt/python_projects/project1/app.py" ]; then
  echo "Error: File /workspaces/development_public/infra_pjt/python_projects/project1/app.py does not exist."
  exit 1
fi

if [ ! -f "/workspaces/development_public/infra_pjt/python_projects/project1/requirements.txt" ]; then
  echo "Error: File /workspaces/development_public/infra_pjt/python_projects/project1/requirements.txt does not exist."
  exit 1
fi

# ワークフローファイルを作成
cat <<EOL > /workspaces/development_public/.github/workflows/docker-publish.yml
name: Build and Push Docker Image

on:
  push:
    branches:
      - main
  workflow_dispatch:
    inputs:
      rollback:
        description: 'Trigger rollback'
        required: true
        default: 'false'
        type: boolean

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
          context: ./infra_pjt/python_projects/project1
          file: ./infra_pjt/common/Dockerfile
          platforms: linux/amd64
          push: true
          tags: butainco/project1:latest

  rollback:
    runs-on: ubuntu-latest
    if: github.event.inputs.rollback == 'true'
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: \${{ secrets.DOCKER_USERNAME }}
          password: \${{ secrets.DOCKER_PASSWORD }}

      - name: Rollback to previous version
        run: |
          docker pull butainco/project1:previous
          docker tag butainco/project1:previous butainco/project1:latest
          docker push butainco/project1:latest
EOL

echo "Rollback workflow for Project1 created successfully."

