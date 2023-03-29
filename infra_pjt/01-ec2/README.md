# tfenv設定(ハンズオン)

## URL
https://harusite.net/20230328-terraform/


## tfenvインストール手順（ハンズオン）
　　1. tfenvインストール
　　
　　  # Terraformをインストールするディレクトリに移動
　　  $ cd ~/<work-dir>
　　
　　  # Homebrewでtfenvをインストール
　　  $ brew install tfenv
　　
　　  # インストール後に、バージョン確認
　　  $ tfenv --version
　　
　　2. 複数バージョンのTerraformをインストール
　　
　　  $ tfenv list-remote
　　
　　  # 最新(記事執筆時)に近い２つのバージョンをインストールしていく
　　  $ tfenv install 1.4.2
　　
　　  # 利用可能なtfenvのバージョンを確認
　　  $ tfenv list
　　  * 1.4.2 (set by /opt/homebrew/Cellar/tfenv/3.0.0/version)
　　    1.4.1
　　
　　  # 使用するバージョンをセット
　　  # 今回は最新を使用
　　  $ tfenv use 1.4.2

## git-secrets設定(ハンズオン)
　　
　　1. Gitインストール
　　
　　  # Gitが未インストールであれば、以下のコマンドを実行
　　  $ brew install git
　　
　　  # インストール後に、バージョン確認
　　  $ git --version
　　
　　
　　2. git-secrets設定
　　
　　  # git-secretsが未インストールであれば、以下のコマンドを実行
　　  $ brew install git-secrets
　　
　　  # 全リポジトリにAWS認証情報のパターンを設定
　　  $ git secrets --register-aws --global
　　
　　  # 現在のユーザーのGit設定ファイルの内容を確認
　　  $ cat ~/.gitconfig
　　
　　
　　
　　3. 動作確認
　　
　　  # Terraformをインストールする「~/work-dir/」配下に作成
　　  $ mkdir ~/work-dir/aws-secrets-test
　　  $ cd ~/work-dir/aws-secrets-test
　　
　　  # Gitの新規リポジトリを作成
　　  $ git init
　　
　　  #テスト用のAWS認証情報は~/.gitconfigのallowedのサンプルキーを参考に　　main.tfを作成する
　　
　　  echo "aws_access_key_id = 　　\"AKIAIOSFODNN8EXAMPLE\"\naws_secret_access_key = 　　\"wJalrXUtnFEMI/K8MDENG/bPxRfiCYEXAMPLEKEY\"" > main.tf
　　
　　  # テスト用の「main.tf」を確認
　　  $ cat main.tf
　　
　　  # 動作確認
　　  # エラーになることを確認
　　  $ git add main.tf
　　  $ git commit -m "secrets test"
　　
　　 
## AWS CLI インストール
  1. AWS CLIのインストール
　　  ・https://awscli.amazonaws.com/AWSCLIV2.pkg
　　
　　  # AWS CLIインストール後の確認コマンド
　　  $ which aws
　　
　　
  2. AWS CLIの構成を実施
　　
　　  # 以下のコマンで対話的に設定してく
　　  $ aws configure
　　
　　  # 確認
　　  ls -la ~/.aws/
　　
　　  # AWS CLI 認証情報が設定されたことを確認
　　  $ aws configure list
　　
  3. 動作確認
　　  # 確認
　　　$ aws iam get-user
---


