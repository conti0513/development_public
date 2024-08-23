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


# 次のステップ
1 README
プロジェクトの目的
キュレーションサイトの作成


### 技術スタックの妥当性

1. **Next.js (app router)**:
   - **特徴**: Next.jsはReactベースのフレームワークで、SEO対応やサーバーサイドレンダリング(SSR)が簡単に実装できます。App Routerを使うことで、ページやAPIのルーティングが柔軟に管理できます。
   - **利点**: パフォーマンスが高く、開発がしやすい。特に情報をキュレーションするようなサービスでは、ページの初期表示が速く、SEOが重要になるため、適しています。

2. **Shadcn/ui**:
   - **特徴**: シンプルでカスタマイズ性の高いUIコンポーネントライブラリ。デザインを効率よく構築するために使えます。
   - **利点**: Next.jsと組み合わせることで、迅速に美しいUIを構築できます。

3. **Supabase**:
   - **特徴**: SupabaseはPostgreSQLをベースとしたオープンソースのリアルタイムデータベースサービスです。バックエンドの構築に必要な認証、ストレージ、データベースの機能が統合されています。
   - **利点**: サーバーレスで管理が簡単。リアルタイムでデータを扱うことができ、APIの自動生成もできるので、迅速にプロジェクトを進められます。

4. **Cloud Run + Artifact Registry**:
   - **特徴**: Cloud Runはコンテナベースのアプリケーションをサーバーレスで実行できるGoogle Cloudのサービス。Artifact RegistryはDockerイメージなどを管理するためのサービスです。
   - **利点**: スケーラビリティが高く、トラフィックに応じて自動的にスケールします。インフラ管理の負担が少なく、コスト効率も高いです。

5. **Cloud Build (Auto Deploy) + GitHub Actions**:
   - **特徴**: Cloud BuildはGoogle CloudのCI/CDサービスで、コードのビルド、テスト、デプロイを自動化できます。GitHub Actionsはリポジトリのイベントに基づいて自動的にタスクを実行できます。
   - **利点**: 開発からデプロイまでのプロセスを自動化することで、開発のスピードと品質を向上させます。Cloud BuildとGitHub Actionsを組み合わせることで、柔軟なCI/CDパイプラインを構築できます。

まず、インフラストラクチャの構築と「Hello World」の表示を確認するためのプランを以下に提供します。このプランでは、Google Cloudを使用して、Cloud RunにシンプルなNext.jsアプリケーションをデプロイします。

### プラン概要
1. **Google Cloudプロジェクトの設定**
2. **Artifact Registryの設定**
3. **Next.jsアプリケーションの作成**
4. **Dockerfileの作成**
5. **Cloud Buildの設定**
6. **Cloud Runへのデプロイ**
7. **Hello Worldの確認**

### ステップバイステップのプラン

#### 1. Google Cloudプロジェクトの設定
- **Google Cloudにログイン**し、新しいプロジェクトを作成します。
- **Billingを有効化**し、必要なAPI（Cloud Run, Artifact Registry, Cloud Build）を有効にします。
- **IAMとサービスアカウントの設定**: Cloud BuildがCloud Runにデプロイできるようにするため、必要な役割（roles/run.admin, roles/storage.adminなど）を持つサービスアカウントを作成し、そのサービスアカウントをCloud Buildに紐付けます。

#### 2. Artifact Registryの設定
- **Artifact Registryを設定**します。これは、コンテナイメージを格納するリポジトリです。
  - コンテナレジストリを作成:
    ```bash
    gcloud artifacts repositories create my-repo --repository-format=docker --location=us-central1
    ```
  - リポジトリ名は `my-repo` として、必要に応じて地域を変更します。

#### 3. Next.jsアプリケーションの作成
- **Next.jsプロジェクトを作成**します。
  ```bash
  npx create-next-app@latest hello-world
  cd hello-world
  ```
- **シンプルなHello Worldページを作成**します。`pages/index.js`を以下の内容に変更します:
  ```javascript
  export default function Home() {
    return (
      <div>
        <h1>Hello, World!</h1>
      </div>
    )
  }
  ```

#### 4. Dockerfileの作成
- **プロジェクトのルートにDockerfileを作成**します。
  ```Dockerfile
  # Install dependencies only when needed
  FROM node:16-alpine AS deps
  WORKDIR /app
  COPY package.json yarn.lock ./
  RUN yarn install

  # Rebuild the source code only when needed
  FROM node:16-alpine AS builder
  WORKDIR /app
  COPY . .
  RUN yarn build

  # Production image, copy all the files and run next
  FROM node:16-alpine AS runner
  WORKDIR /app
  ENV NODE_ENV production

  # Install dependencies only for production
  RUN yarn install --production

  EXPOSE 3000

  CMD ["yarn", "start"]
  ```
- **`.dockerignore`** ファイルを作成し、ビルドに不要なファイルを除外します。
  ```plaintext
  node_modules
  .next
  ```

#### 5. Cloud Buildの設定
- **Cloud Buildの設定ファイルを作成**します。`cloudbuild.yaml`をプロジェクトのルートに作成します。
  ```yaml
  steps:
    - name: 'gcr.io/cloud-builders/docker'
      args: ['build', '-t', 'us-central1-docker.pkg.dev/[PROJECT_ID]/my-repo/hello-world', '.']
    - name: 'gcr.io/cloud-builders/docker'
      args: ['push', 'us-central1-docker.pkg.dev/[PROJECT_ID]/my-repo/hello-world']

  images:
    - 'us-central1-docker.pkg.dev/[PROJECT_ID]/my-repo/hello-world'
  ```
- `[PROJECT_ID]`はGoogle CloudプロジェクトのIDに置き換えてください。

#### 6. Cloud Runへのデプロイ
- **Cloud Runにデプロイ**します。以下のコマンドを実行します:
  ```bash
  gcloud run deploy hello-world \
    --image=us-central1-docker.pkg.dev/[PROJECT_ID]/my-repo/hello-world \
    --platform=managed \
    --region=us-central1 \
    --allow-unauthenticated
  ```
- `--allow-unauthenticated`オプションは、誰でもアクセスできるようにします。

#### 7. Hello Worldの確認
- デプロイ後、Cloud RunのURLが表示されます。ブラウザでそのURLを開き、"Hello, World!"が表示されることを確認します。

### 最終確認
- すべてのステップが完了したら、シンプルなNext.jsアプリケーションがGoogle Cloud Run上で動作し、「Hello World」の表示が確認できます。

### 次のステップ
この後、Supabaseを接続してデータベース機能を追加したり、Cloud BuildとGitHub Actionsを連携させてCI/CDを構築することも可能です。

