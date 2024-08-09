# Experience 1: Adopting New Technologies

## Overview
This project demonstrates the deployment of a Python Flask application using Terraform, Docker, and GitHub Actions.

## Steps
1. **Setup Docker**
   - Navigate to the `docker` directory, build the Docker image, and run the container.
     ```sh
     cd docker
     docker build -t flask-app .
     docker run -p 8080:8080 flask-app
     ```

2. **Setup Terraform**
   - Navigate to the `terraform` directory and initialize and apply the Terraform configuration.
     ```sh
     cd terraform
     terraform init
     terraform apply -auto-approve
     ```

3. **Setup GitHub Actions**
   - GitHub Actions workflow is defined in `.github/workflows/ci-cd.yml` for CI/CD.

## Technologies Used
- Python Flask
- Terraform
- Docker
- GitHub Actions
