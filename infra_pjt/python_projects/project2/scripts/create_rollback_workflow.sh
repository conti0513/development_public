#!/bin/bash

echo "Starting to create rollback workflow for Project2..."

cat <<EOL > /workspaces/development_public/.github/workflows/docker-publish.yml
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

      - name: Rollback Project1
        if: contains(github.event.head_commit.message, 'project1')
        run: |
          docker pull btainco/project1:previous
          docker tag btainco/project1:previous btainco/project1:latest
          docker push btainco/project1:latest

      - name: Rollback Project2
        if: contains(github.event.head_commit.message, 'project2')
        run: |
          docker pull btainco/project2:previous
          docker tag btainco/project2:previous btainco/project2:latest
          docker push btainco/project2:latest
EOL

echo "Rollback workflow for Project2 created successfully."
EOL
