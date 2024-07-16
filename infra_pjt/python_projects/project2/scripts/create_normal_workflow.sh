#!/bin/bash

echo "Starting to create normal workflow for Project2..."

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

      - name: Build and push Project1
        if: contains(github.event.head_commit.message, 'project1')
        uses: docker/build-push-action@v2
        with:
          context: ./infra_pjt/python_projects/project1
          file: ./infra_pjt/common/Dockerfile
          platforms: linux/amd64
          push: true
          tags: btainco/project1:latest

      - name: Build and push Project2
        if: contains(github.event.head_commit.message, 'project2')
        uses: docker/build-push-action@v2
        with:
          context: ./infra_pjt/python_projects/project2
          file: ./infra_pjt/common/Dockerfile
          platforms: linux/amd64
          push: true
          tags: btainco/project2:latest
EOL

echo "Normal workflow for Project2 created successfully."
EOL

