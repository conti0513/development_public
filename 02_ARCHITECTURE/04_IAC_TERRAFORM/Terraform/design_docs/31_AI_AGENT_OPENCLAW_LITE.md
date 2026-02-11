## 🚀 AI Agent (OpenClaw-Lite) 構築実行手順書

### 1. Slack API：リモコンの作成

まずは、入り口となるSlack Appをセットアップします。

1. **App作成**: [Slack API Console](https://api.slack.com/apps) から `Create New App` (From scratch) を選択。
2. **Scopes設定**: `OAuth & Permissions` ページで以下の `Bot Token Scopes` を追加。
* `app_mention`: メンションを検知するため
* `chat:write`: AIが結果を返信するため


3. **Appインストール**: `Install to Workspace` を実行し、**Bot User OAuth Token** (`xoxb-...`) を控える。
4. **Signing Secretの取得**: `Basic Information` ページにある **Signing Secret** を控える（リクエスト検証用）。

ここまでの手順を、作成中の設計ドキュメント `31_AI_AGENT_OPENCLAW_LITE.md` の末尾に「実装メモ」として追記しておきました。

作業再開時にこれを見れば、どこまで進んだかすぐ思い出せるはずです！

---

### **今回の進捗まとめ（Slack設定完了）**

1. **Slack App作成**: `OpenClaw-Lite` を `Sawadesign` ワークスペースに作成。
2. **権限設定 (Scopes)**: `app_mention` と `chat:write` を付与。
3. **トークン回収**: `Bot User OAuth Token` (xoxb-...) と `Signing Secret` を取得済み。
4. **インストール**: ワークスペースへのインストールまで完了。

### **次回の開始ポイント**

* **GitHubの鍵（PAT）作成**: GitHub Actionsを動かすための通行証を発行。
* **GitHub Actionsの定義**: `.github/workflows/ai-worker.yml` を作成。
* **Go言語の実装**: 司令塔（APIサーバー）のコーディング開始。

---




### 2. GitHub：作業員（筋肉）の準備

AIが実際に手を動かすサンドボックス環境を用意します。

1. **PAT発行**: GitHubの `Settings` > `Developer settings` > `Personal access tokens` から、**Fine-grained token** を発行。
* **Permissions**: `Actions: Read & Write`, `Contents: Read & Write`, `Metadata: Read-only`


2. **Workflow作成**: リポジトリの `.github/workflows/ai-worker.yml` を作成。
* トリガーを `repository_dispatch` に設定する。
* 実行内容は、まず `echo "Hello World"` を出すだけの最小構成にする。



### 3. Google Cloud：司令塔の設置準備

サーバーレス実行環境（Cloud Run）の土台を作ります。

1. **Secret Manager登録**:
* 控えておいた `Slack Bot Token`, `Slack Signing Secret`, `GitHub PAT`, `AI API Key` を、Secret Managerに個別のシークレットとして登録。


2. **サービスアカウント作成**: Cloud Run用のサービスアカウントを作成し、上記シークレットへの `シークレット取次者` 権限を付与。
3. **Artifact Registry作成**: Goのバイナリ（Dockerイメージ）を格納するレジストリを作成。

### 4. Golang実装：司令塔のロジック構築（※コードは後ほど）

Go言語で実装すべき機能を以下の順序で組み立てます。

1. **Endpoint 1: `/slack/events` (POST)**:
* **署名検証**: Slackからのリクエストが本物か、Signing SecretでHMACチェック。
* **URL検証 (Challenge)**: 初回接続時の疎通確認に応答。
* **メンション検知**: メッセージ内容を抽出。


2. **AI相談ロジック**:
* 抽出したメッセージをLLM（Claude等）に送り、実行すべきGitHub Workflow名と引数を抽出。


3. **GitHub Dispatch**:
* GitHub APIを叩き、`repository_dispatch` を発火させる。



### 5. デプロイと疎通テスト

最後に、すべてを繋ぎ込みます。

1. **ビルド & プッシュ**: Goのコードをコンテナ化し、Artifact Registryへプッシュ。
2. **Cloud Runデプロイ**: サービスアカウントと環境変数を紐づけてデプロイ。
3. **Slack Webhook登録**: Cloud RunのURLをSlack Appの `Event Subscriptions` > `Request URL` に登録。
4. **動作確認**: SlackチャンネルにBotを招待し、`@Bot名 Hello!` と投げて、GitHub Actionsが回り出せば成功。

---

### 💡 構築のポイント

* **セキュリティ**: サーバーレスなので、IP制限より「署名検証」と「シークレット管理」が命です。
* **拡張性**: 最初のHello Worldが通れば、あとは `ai-worker.yml` を増やすだけで、NW図生成でもConfig修正でも、何でもAIにやらせることができます。
