#!/bin/bash

echo "Starting to create normal workflow for Project1..."

cat <<EOL > /workspaces/development_public/.github/workflows/docker-publish.yml
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
          context: ./infra_pjt/common
          push: true
          tags: butainco/project1:latest

EOL

echo "Normal workflow for Project1 created successfully."

