
# テキスト
# Udemy講座
https://www.udemy.com/course/terraform-with-aws/learn/lecture/36359552#overview

# 事前準備
AWSでEC2を起動し、Nginxを起動してブラウジングかくにんをする

## 手順
---
*AWSに接続
*デフォルトVPCを作成(あればそのまま使う)

*SGを作成
　名前　yyyymmdd-terraform-ec2-sg
　インバウンドルール
　　ssh ソース　0.0.0.0/0(どこからでも許可)
　　http ソース　0.0.0.0/0(どこからでも許可)
　アウトバウンド　そのまま

*最小構成でEC2を起動
　OS ubuntsu
　名前　yyyymmdd-terraform-ec2
　インスタンス　t2micro
  キーペアは作る　macの ~/.sshに
   conti-2.cer

  パブリックIP 自動割り当て　有効
  SG 咲穂作成したものを適用
  ゆーざーデータ
  mkdir ~/.ssh/keys
  chmod 777 ~/.ssh/keys
  chmod 400 ~/.ssh/keys/conti-2.cer
  ssh -i ~/.ssh/keys/conti-2.cer ubuntu@54.168.229.223

---
#!/bin/bash

sudo apt update
sudo apt install -y nginx
---

ブラウザで確認

　ぱぶりっくIP を確認

　ブラウザ
  http://publicIP/

エラーログかくにん場所
/var/log/cloud-init-output.log

---
←ここまで確認完了
---




macにteffaformをインストール
pwd
/Users/yoshi/Development/development_public/tutorial_docker/docker-terraform

*brew install tfenv
*tfenv --version

*インストール可能なterraformを確認
tfenv list-remote

*インストール
tfenv install 1.4.2

trdnv use 
tfenv list

---
git-secretsをインストール
brew install git-secrets

git secrets --register-aws --global

cat ~/.gitconfig 
[user]
        name = conti0513
        email = yoshimasa@sawadesign.jp
[core]
        editor = code --wait
[init]
        defaultBranch = tutorial
[secrets]
        providers = git secrets --aws-provider
        patterns = (A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}
        patterns = (\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?
        patterns = (\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?
        allowed = AKIAIOSFODNN7EXAMPLE
        allowed = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

---
git secrets --install ~/.git-templates/secrets
git config --global init.templatedir '~/.git-templates/secrets'

---
















クリデンシャル情報の逃し方

blog
https://qiita.com/Hikosaburou/items/1d3765d85d5398e3763f

Classmethod
https://dev.classmethod.jp/articles/terraform-getting-started-with-aws/

※アクセスキーをハードコードするのはクレデンシャル漏洩のリスクが高すぎのため

GitHub ActionsにAWSクレデンシャル情報を渡さずにTerraformでCI/CDをやってみた
https://zenn.dev/yuta28/articles/terraform-gha

---


# どの資料を見てもいまいちわからないので、公式ドキュメントを読んでみる

公式ドキュメント
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code


# TerraformによるInfrastructure as Codeとは？
Infrastructure as Code (IaC) ツールを使用すると、グラフィカルユーザーインターフェイスではなく、設定ファイルを使用してインフラストラクチャを管理することができます。

IaCは、バージョンアップ、再利用、共有が可能なリソース構成を定義することで、安全で一貫性のある反復可能な方法でインフラストラクチャを構築、変更、管理できるようにします。


## Terraformを使用すると、手動でインフラを管理するよりもいくつかの利点があります：

Terraformは、複数のクラウドプラットフォーム上のインフラを管理することができます。
人間が読める設定言語により、インフラストラクチャーコードを素早く書くことができます。
Terraformのstateは、デプロイメントを通してリソースの変更を追跡することができます。
設定をバージョン管理でコミットすることで、安全にインフラを共同利用することができます。


わかりにくい。。。
=========================
クラスメソッド

【初心者向け】MacにTerraform環境を導入してみた
https://dev.classmethod.jp/articles/beginner-terraform-install-mac/





## tfenv設定

pwd
/Users/yoshi/Development/development_public/tutorial_docker/docker-terraform


1. tfenvインストール
Homebrewでtfenvをインストールします。

% brew install tfenv
インストール後に、バージョン確認してみましょう。

% tfenv --version



2. 複数のTerraformバージョンインストール

tfenv list-remote

tfenv install 1.4.2
tfenv install 1.4.1

tfenv use 1.4.2
---
tfenv list
* 1.4.2 (set by /opt/homebrew/Cellar/tfenv/3.0.0/version)
  1.4.1
---


## git-secrets設定

1. Gitインストール
Gitが未インストールであれば、以下のコマンドを実行します。

% brew install git
インストール後に、バージョン確認してみましょう。

% git --version

git version 2.40.0

---


2. git-secrets設定
git-secretsが未インストールであれば、以下のコマンドを実行します。
% brew install git-secrets

全リポジトリにAWS認証情報のパターンを設定します。
% git secrets --register-aws --global


% cat ~/.gitconfig
[user]
        name = conti0513
        email = yoshimasa@sawadesign.jp
[core]
        editor = code --wait
[init]
        defaultBranch = tutorial
        templatedir = ~/.git-templates/secrets
[secrets]
        providers = git secrets --aws-provider
        patterns = (A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}
        patterns = (\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?
        patterns = (\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?
        allowed = AKIAIOSFODNN7EXAMPLE
        allowed = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
yoshi@y0513 docker-terraform % 

---


新規リポジトリ作成時に、git-secretsがインストールされるよう設定します。

% git secrets --install ~/.git-templates/secrets
% git config --global init.templatedir '~/.git-templates/secrets'



3. 動作確認

AWS認証情報が記載されていた場合に、Gitのコミットを防ぐことができるのかを確認します。

まずはテスト用のディレクトリを作成し、移動します。

% mkdir aws-secrets-test
% cd aws-secrets-test


Gitの新規リポジトリを作成します。

% git init


テスト用のAWS認証情報は~/.gitconfigのallowedのサンプルキーを参考にします。
数字の部分を7から8に変更してmain.tfを作成しましょう。
echo "aws_access_key_id = \"AKIAIOSFODNN8EXAMPLE\"\naws_secret_access_key = \"wJalrXUtnFEMI/K8MDENG/bPxRfiCYEXAMPLEKEY\"" > main.tf


oshi@y0513 aws-secrets-test % cat main.tf 
aws_access_key_id = "AKIAIOSFODNN8EXAMPLE"
aws_secret_access_key = "wJalrXUtnFEMI/K8MDENG/bPxRfiCYEXAMPLEKEY"
yoshi@y0513 aws-secrets-test % 
yoshi@y0513 aws-secrets-test % 
yoshi@y0513 aws-secrets-test % git add main.tf 
yoshi@y0513 aws-secrets-test % git commit -m "secrets test"
main.tf:1:aws_access_key_id = "AKIAIOSFODNN8EXAMPLE"

[ERROR] Matched one or more prohibited patterns

Possible mitigations:
- Mark false positives as allowed using: git config --add secrets.allowed ...
- Mark false positives as allowed by adding regular expressions to .gitallowed at repository's root directory
- List your configured patterns: git config --get-all secrets.patterns
- List your configured allowed patterns: git config --get-all secrets.allowed
- List your configured allowed patterns in .gitallowed at repository's root directory
- Use --no-verify if this is a one-time false positive
yoshi@y0513 aws-secrets-test % 

---
以上で
git-secretsの設定完了
Terraform環境導入完了
---













