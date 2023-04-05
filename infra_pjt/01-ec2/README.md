<<<<<<< HEAD
# tfenv設定(ハンズオン)

## URL
https://harusite.net/20230328-terraform/


## tfenvインストール手順（ハンズオン）
=======
# URL
https://harusite.net/20230328-terraform/



# tfenv設定(ハンズオン)
>>>>>>> parent of 7af9e96 (Revert "Revert "2"")
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
<<<<<<< HEAD

## git-secrets設定(ハンズオン)
=======
　　
# git-secrets設定(ハンズオン)
>>>>>>> parent of 7af9e96 (Revert "Revert "2"")
　　
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
　　
<<<<<<< HEAD
　　
　　
　　3. 動作確認
　　
=======
　　　　
　　3. 動作確認
>>>>>>> parent of 7af9e96 (Revert "Revert "2"")
　　  # Terraformをインストールする「~/work-dir/」配下に作成
　　  $ mkdir ~/work-dir/aws-secrets-test
　　  $ cd ~/work-dir/aws-secrets-test
　　
　　  # Gitの新規リポジトリを作成
　　  $ git init
<<<<<<< HEAD
　　
　　  #テスト用のAWS認証情報は~/.gitconfigのallowedのサンプルキーを参考に　　main.tfを作成する
=======

     # テスト用のAWS認証情報
     # main.tfを作成する
>>>>>>> parent of 7af9e96 (Revert "Revert "2"")
　　
　　  echo "aws_access_key_id = 　　\"AKIAIOSFODNN8EXAMPLE\"\naws_secret_access_key = 　　\"wJalrXUtnFEMI/K8MDENG/bPxRfiCYEXAMPLEKEY\"" > main.tf
　　
　　  # テスト用の「main.tf」を確認
　　  $ cat main.tf
　　
　　  # 動作確認
　　  # エラーになることを確認
　　  $ git add main.tf
　　  $ git commit -m "secrets test"
　　
<<<<<<< HEAD
　　 
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
=======

# AWS CLI インストール
　　  1. AWS CLIのインストール
　　    https://awscli.amazonaws.com/AWSCLIV2.pkg
　　
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

# URL
https://harusite.net/20230328-terraform-2/


# Nginxの起動と動作確認

  #!/bin/bash

  $ sudo apt update
  $ sudo apt install -y nginx

  # プロセスの確認
  $ ps -ef | grep nginx


# TerraformでEC2を起動 → Nginxの動作確認を
  1. tfファイルの作成
    $ vim main.tf
    
    # tfファイルの記載内容は以下の通り

      provider "aws" {
        region = "ap-northeast-1"
      }
      
      resource "aws_instance" "terraform_ec2" {
      ami = "ami-0b828c1c5ac3f13ee"
      instance_type = "t2.micro"
      key_name = "conti-2"
      vpc_security_group_ids = ["sg-0944e366cf3684556"]
      
      tags = {
        Name = "20230328-terraform-test"
      }
      
      connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/keys/conti-2.cer")
        host = self.public_ip
      }
      
      provisioner "remote-exec" {
        inline = [
          "sudo apt-get update",
          "sudo apt-get install -y nginx"
        ]
        }
      }
      
      resource "aws_security_group" "instance" {
      name_prefix = "2023-terraform-sg"
      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
      }
      
      output "public_ip" {
        value = aws_instance.terraform_ec2.public_ip
      }


  2. Terraformの初期化
    terraform init

  3. 計画の作成
    $ terraform plan

  4. インスタンスの作成
    $ terraform apply

  5. インスタンスの削除
    $ terraform destroy
>>>>>>> parent of 7af9e96 (Revert "Revert "2"")


