#!/bin/bash

echo "Do you want to create a normal workflow or a rollback workflow? (Enter 'normal' or 'rollback'):"
read workflow_type

echo "Enter the project name for which you want to create the workflow (e.g., project1, project2):"
read project_name

if [ "$workflow_type" == "normal" ]; then
  cat <<EOL > /workspaces/development_public/.github/workflows/docker-publish-${project_name}.yml
name: Build and Push Docker Image for ${project_name}

on:
  push:
    branches:
      - main

jobs:
  build-and-push-${project_name}:
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

  echo "Normal workflow for ${project_name} created successfully."

elif [ "$workflow_type" == "rollback" ]; then
  cat <<EOL > /workspaces/development_public/.github/workflows/docker-rollback-${project_name}.yml
name: Rollback Docker Image for ${project_name}

on:
  push:
    branches:
      - rollback

jobs:
  rollback-${project_name}:
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
        uses: docker/build-push-action@v2
        with:
          context: ./infra_pjt/python_projects/${project_name}
          file: ./infra_pjt/common/Dockerfile
          push: true
          tags: butainco/${project_name}:rollback
EOL

  echo "Rollback workflow for ${project_name} created successfully."

else
  echo "Invalid workflow type. Please enter 'normal' or 'rollback'."
fi

