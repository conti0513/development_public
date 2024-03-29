# README.md
/Users/yoshi/Development/development_public/tutorial_docker/docker-terraform

後で記事にする

# 環境構築
【Terraform第1回】環境構築
https://harusite.net/20230328-terraform/


# EC2を手動　→ Terraformで起動　→ Nginxを起動　→ 動作確認　→ 環境削除まで
【Terraform第2回】EC2をTerraformで起動　→ Nginxを起動　→ 動作確認　→ 環境削除まで
https://harusite.net/20230328-terraform-2/



###################################################
ここからはEC2の起動
VPCを作ったり、少し高度なので、もう少しスモールな手順を使って、
Terraformの基礎的なコマンドを押さえられるようなメニューを作成する
---

Terraformのtfファイル作成
Terraformを実行する際に必要なtfファイルを作成していきます。


tfファイルはHCLで記述する
resource "リソースの種類" "リソース名" {
    設定項目1  =  値1
    設定項目2  =  値2
    設定項目3  =  値3
}
ーーー

作成するtfファイルについて
tfファイルの名前は自由に設定できます。

今回はtfファイルの一般的な命名パターンを使用し、以下のとおりに5つのtfファイルを作成します。

ファイル名	ファイルの定義内容
main.tf	"AWS" などTerraformを実行する環境（プロバイダーと呼ぶ）を定義
variables.tf	Terraformで使用する変数を定義（変数は他のtfファイルから${var.変数名}やvar.変数名で参照できる）
vpc.tf	VPCを作成するためのリソースを定義
ec2.tf	EC2を作成するためのリソースを定義
output.tf	作成したEC2のパブリックIPアドレスを出力する設定を定義


クライアントPCに作業用フォルダと空のtfファイルを作成
mkdir test-ec2

 touch main.tf variables.tf vpc.tf ec2.tf output.tf
yoshi@y0513 test-ec2 % ls -la
total 0
drwxr-xr-x  7 yoshi  staff  224 Mar 26 22:06 .
drwxr-xr-x  5 yoshi  staff  160 Mar 26 22:05 ..
-rw-r--r--  1 yoshi  staff    0 Mar 26 22:06 ec2.tf
-rw-r--r--  1 yoshi  staff    0 Mar 26 22:06 main.tf
-rw-r--r--  1 yoshi  staff    0 Mar 26 22:06 output.tf
-rw-r--r--  1 yoshi  staff    0 Mar 26 22:06 variables.tf
-rw-r--r--  1 yoshi  staff    0 Mar 26 22:06 vpc.tf
yoshi@y0513 test-ec2 % 
---



main.tf
# ---------------------------
# プロバイダ設定
# ---------------------------
# AWS
provider "aws" {
  region     = "ap-northeast-1"
}

# 自分のパブリックIP取得用
provider "http" {}


variables.tf
# ---------------------------
# 変数設定
# ---------------------------
variable "az_a" {
  default     = "ap-northeast-1a"
}

variable "access_key" {
  default     = "＊＊＊＊＊＊＊＊＊＊＊＊"
}

variable "secret_key" {
  default     = "＊＊＊＊＊＊＊＊＊＊＊＊"
}
----




vpc.tf
---
# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "handson_vpc"{
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true   # DNSホスト名を有効化
  tags = {
    Name = "terraform-handson-vpc"
  }
}

# ---------------------------
# Subnet
# ---------------------------
resource "aws_subnet" "handson_public_1a_sn" {
  vpc_id            = aws_vpc.handson_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.az_a}"

  tags = {
    Name = "terraform-handson-public-1a-sn"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "handson_igw" {
  vpc_id            = aws_vpc.handson_vpc.id
  tags = {
    Name = "terraform-handson-igw"
  }
}

# ---------------------------
# Route table
# ---------------------------
# Route table作成
resource "aws_route_table" "handson_public_rt" {
  vpc_id            = aws_vpc.handson_vpc.id
  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.handson_igw.id
  }
  tags = {
    Name = "terraform-handson-public-rt"
  }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "handson_public_rt_associate" {
  subnet_id      = aws_subnet.handson_public_1a_sn.id
  route_table_id = aws_route_table.handson_public_rt.id
}

# ---------------------------
# Security Group
# ---------------------------
# 自分のパブリックIP取得
data "http" "ifconfig" {
  url = "http://ipv4.icanhazip.com/"
}

variable "allowed_cidr" {
  default = null
}

locals {
  myip          = chomp(data.http.ifconfig.body)
  allowed_cidr  = (var.allowed_cidr == null) ? "${local.myip}/32" : var.allowed_cidr
}

# Security Group作成
resource "aws_security_group" "handson_ec2_sg" {
  name              = "terraform-handson-ec2-sg"
  description       = "For EC2 Linux"
  vpc_id            = aws_vpc.handson_vpc.id
  tags = {
    Name = "terraform-handson-ec2-sg"
  }

  # インバウンドルール
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.allowed_cidr]
  }

  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

----

ec2.tf
---
# ---------------------------
# EC2 Key pair
# ---------------------------
variable "key_name" {
  default = "terraform-handson-keypair"
}

# 秘密鍵のアルゴリズム設定
resource "tls_private_key" "handson_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# クライアントPCにKey pair（秘密鍵と公開鍵）を作成
# - Windowsの場合はフォルダを"\\"で区切る（エスケープする必要がある）
# - [terraform apply] 実行後はクライアントPCの公開鍵は自動削除される
locals {
  public_key_file  = "C:\\terraform_handson\\${var.key_name}.id_rsa.pub"
  private_key_file = "C:\\terraform_handson\\${var.key_name}.id_rsa"
}

resource "local_file" "handson_private_key_pem" {
  filename = "${local.private_key_file}"
  content  = "${tls_private_key.handson_private_key.private_key_pem}"
}

# 上記で作成した公開鍵をAWSのKey pairにインポート
resource "aws_key_pair" "handson_keypair" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.handson_private_key.public_key_openssh}"
}

# ---------------------------
# EC2
# ---------------------------
# Amazon Linux 2 の最新版AMIを取得
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2作成
resource "aws_instance" "handson_ec2"{
  ami                         = data.aws_ssm_parameter.amzn2_latest_ami.value
  instance_type               = "t2.micro"
  availability_zone           = "${var.az_a}"
  vpc_security_group_ids      = [aws_security_group.handson_ec2_sg.id]
  subnet_id                   = aws_subnet.handson_public_1a_sn.id
  associate_public_ip_address = "true"
  key_name                    = "${var.key_name}"
  tags = {
    Name = "terraform-handson-ec2"
  }
}
---


output.tf
---
# 作成したEC2のパブリックIPアドレスを出力
output "ec2_global_ips" {
  value = "${aws_instance.handson_ec2.*.public_ip}"
}
---




## TerraformでVPCとEC2を構築

### terraform initでワークスペース初期化

まずterraform initを実行し、ワークスペース（tfファイルを格納しているフォルダ）を初期化します。

ワークスペース内のtfファイルが読み込まれ、必要なpluginがインターネットからワークスペースにダウンロードされます。



### terraform validateでtfファイルの構文チェック

terraform validateを実行するとtfファイルの構文をチェックをしてくれます。（本コマンドは必須ではない）

C:\terraform_handson> terraform validate


### terraform planで実行計画を作成

terraform planを実行すると、どういったリソースが作成（変更）されるかを事前に確認できます。（本コマンドは必須ではない）


### terraform applyでリソースを作成
terraform apply


### terraform showで作成したリソースを確認


### sshで接続
 % ls -la ~/.ssh/keys          
total 24
drwxrwxrwx  5 yoshi  staff   160 Mar 26 22:25 .
drwxrwxrwx  6 yoshi  staff   192 Mar 22 16:47 ..
-r--------@ 1 yoshi  staff  1678 Mar 22 15:26 conti-2.cer
-r--------@ 1 yoshi  staff  1674 Mar 22 14:53 conti.cer
-rwxr-xr-x  1 yoshi  staff  1679 Mar 26 22:25 terraform-handson-keypair.cer
yoshi@y0513 test-ec2 % 
yoshi@y0513 test-ec2 % chmod 400 ~/.ssh/keys/terraform-handson-keypair.cer
yoshi@y0513 test-ec2 % ls -la ~/.ssh/keys                                 
total 24
drwxrwxrwx  5 yoshi  staff   160 Mar 26 22:25 .
drwxrwxrwx  6 yoshi  staff   192 Mar 22 16:47 ..
-r--------@ 1 yoshi  staff  1678 Mar 22 15:26 conti-2.cer
-r--------@ 1 yoshi  staff  1674 Mar 22 14:53 conti.cer
-r--------  1 yoshi  staff  1679 Mar 26 22:25 terraform-handson-keypair.cer
yoshi@y0513 test-ec2 % ssh -i ~/.ssh/keys/terraform-handson-keypair.cer ec2-user@13.231.172.0

ーーー


## Terraformで作成したVPCとEC2を削除

### terraform plan -destroyで削除対象のリソースを確認

terraform plan -destroy

terraform destroy

---
Destroy complete! Resources: 10 destroyed.が出力されれば削除完了。

マネジメントコンソールから以下を確認します。

VPCが削除されたこと
EC2の [インスタンスの状態] が [終了済み] になったこと
 

クライアントPCに作成した秘密鍵C:\terraform_handson\terraform-handson-keypair.id_rsaも削除されます。
---

terraform show

yoshi@y0513 test-ec2 % terraform show
The state file is empty. No resources are represented.














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












