# 

# DIR構成
/workspaces/development_public
└── projects
    └── infra_pjt
        ├── curation
        │   ├── README.md                  # プロジェクト概要と手順を記載
        │   ├── scripts                    # 各種スクリプト用ディレクトリ
        │   │   ├── deploy.sh              # インフラ展開用スクリプト
        │   │   ├── cleanup.sh             # クリーンアップ用スクリプト
        │   │   └── init.sh                # 初期化用スクリプト
        │   ├── terraform                  # Terraform構成ファイル用ディレクトリ
        │   │   ├── main.tf                # メインのTerraform設定
        │   │   ├── variables.tf           # 変数ファイル
        │   │   ├── outputs.tf             # 出力定義
        │   │   └── terraform.tfvars       # 変数の値を設定するファイル
        │   ├── docker                     # Docker関連ファイル用ディレクトリ
        │   │   ├── Dockerfile             # Dockerfile
        │   │   ├── docker-compose.yml     # Docker Composeファイル
        │   │   └── app                    # アプリケーション関連ファイル
        │   │       ├── app.py             # Python Flaskアプリなど
        │   │       └── requirements.txt   # Pythonパッケージの依存関係
        │   ├── .github                    # GitHub Actions用ディレクトリ
        │   │   └── workflows
        │   │       └── ci-cd.yml          # CI/CDパイプラインの設定ファイル
        │   └── docs                       # ドキュメント用ディレクトリ
        │       └── architecture.md        # システムアーキテクチャの説明

Here's a step-by-step guide to set up a simple Next.js project on GitHub Codespaces. 
The goal is to create a "Hello, World" application for testing.

### Step 1: Set Up the Next.js Project

1. **Navigate to the Project Directory:**
   Open terminal in Codespaces and navigate to the `curation` directory:
   ```bash
   cd /workspaces/development_public/projects/infra_pjt/curation
   ```

2. **Initialize a Next.js Project:**
   Run the following command to set up a new Next.js project:
   ```bash
   npx create-next-app@latest hello-world
   ```
   Follow the prompts to create the app. You can accept the defaults.

3. **Move the Project Files:**
   The Next.js project will be created in a `hello-world` directory. Move its contents to the appropriate directories under `curation`:
   ```bash
   mv hello-world/* ./
   mv hello-world/.gitignore ./
   mv hello-world/public ./docs  # Assuming public assets go to docs
   mv hello-world/pages/index.js ./docker/app/index.js
   mv hello-world/package.json ./docker/app/
   mv hello-world/package-lock.json ./docker/app/
   rm -rf hello-world
   ```

### Step 2: Update Docker and Compose Files

1. **Dockerfile:**
   Create or update the `Dockerfile` under the `docker` directory:
   ```dockerfile
   FROM node:16-alpine

   WORKDIR /app

   COPY app/package*.json ./

   RUN npm install

   COPY app/ ./

   EXPOSE 3000

   CMD ["npm", "run", "dev"]
   ```

2. **docker-compose.yml:**
   Update or create `docker-compose.yml` to define the service:
   ```yaml
   version: '3.8'

   services:
     app:
       build: .
       ports:
         - '3000:3000'
       volumes:
         - ./app:/app
       environment:
         NODE_ENV: development
   ```

### Step 3: Modify GitHub Actions Workflow

1. **CI/CD Workflow:**
   Update or create the `.github/workflows/ci-cd.yml` file to include steps for testing and building the Next.js app:
   ```yaml
   name: CI/CD

   on:
     push:
       branches:
         - main
     pull_request:

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
       - name: Checkout code
         uses: actions/checkout@v2

       - name: Set up Node.js
         uses: actions/setup-node@v2
         with:
           node-version: '16'

       - name: Install dependencies
         run: npm install
         working-directory: ./docker/app

       - name: Run tests
         run: npm run test
         working-directory: ./docker/app

       - name: Build project
         run: npm run build
         working-directory: ./docker/app
   ```

### Step 4: Run the Application

1. **Run the Application:**
   In the terminal, navigate to the `curation` directory and start the Docker service:
   ```bash
   docker-compose up
   ```
   Your Next.js app should be running on `http://localhost:3000`, displaying "Hello, World".

### Step 5: Test in Codespaces

1. **Access the App:**
   Open the browser tab within Codespaces to test the application:
   ```bash
   Open Browser > Forward Port > 3000
   ```

If everything is set up correctly, you'll see a "Hello, World" message on the page.