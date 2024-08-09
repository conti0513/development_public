# Template Repository

## Overview

This repository is a template for setting up projects using Terraform, Docker, and GitHub Actions. 

## Project Structure

```plaintext
/workspaces/development_public/aws_projects/template_repository
├── docker
│   ├── Dockerfile
│   ├── requirements.txt
│   └── app.py
├── terraform
│   └── main.tf
└── .github
    └── workflows
        └── ci-cd.yml
```

## Project Setup

1. **Create a New Repository on GitHub**
   - Go to [GitHub](https://github.com) and create a new repository. Do not initialize it with a README, .gitignore, or license.

2. **Add the New GitHub Repository as a Remote**

   ```sh
   git remote add origin https://github.com/your-username/your-new-repo.git
   git push -u origin main
   ```

3. **Set Up AWS Credentials for Terraform**

   Ensure you have your AWS credentials configured. You can set them up using the AWS CLI:

   ```sh
   aws configure
   ```

4. **Initialize Terraform**

   Navigate to the `terraform` directory and initialize Terraform.

   ```sh
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```

5. **Build and Run the Docker Container**

   Navigate to the `docker` directory, build the Docker image, and run the container.

   ```sh
   cd ../docker
   docker build -t your-app-name .
   docker run -p 8080:8080 your-app-name
   ```

6. **Verify the Application**

   Open your browser and go to `http://localhost:8080` to verify that the application is running.

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)



cd /workspaces/development_public/aws_projects/template_repository/
cat <<EOF > README.md
# Template Repository

## Overview
このリポジトリは、Terraform、Docker、GitHub Actionsを使用してプロジェクトを設定するためのテンプレートです。

## Project Structure

\`\`\`plaintext
/workspaces/development_public/aws_projects/template_repository
├── docker
│   ├── Dockerfile
│   ├── requirements.txt
│   └── app.py
├── terraform
│   └── main.tf
└── .github
    └── workflows
        └── ci-cd.yml
\`\`\`

## Project Setup
### プロジェクト設定

1. **Create a New Repository on GitHub**
   - [GitHub](https://github.com) にアクセスして新しいリポジトリを作成します。README、.gitignore、ライセンスは初期化しないでください。

2. **Add the New GitHub Repository as a Remote**
   - 新しいGitHubリポジトリをリモートとして追加します。

   \`\`\`sh
   git remote add origin https://github.com/your-username/your-new-repo.git
   git push -u origin main
   \`\`\`

3. **Set Up AWS Credentials for Terraform**
   - TerraformのためにAWSクレデンシャルを設定します。AWS CLIを使用して設定できます。

   \`\`\`sh
   aws configure
   \`\`\`

4. **Initialize Terraform**
   - `terraform`ディレクトリに移動し、Terraformを初期化します。

   \`\`\`sh
   cd terraform
   terraform init
   terraform apply -auto-approve
   \`\`\`

5. **Build and Run the Docker Container**
   - `docker`ディレクトリに移動し、Dockerイメージをビルドしてコンテナを実行します。

   \`\`\`sh
   cd ../docker
   docker build -t your-app-name .
   docker run -p 8080:8080 your-app-name
   \`\`\`

6. **Verify the Application**
   - ブラウザを開き、`http://localhost:8080`にアクセスしてアプリケーションが実行されていることを確認します。

## Additional Resources
### 追加リソース

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

