provider "aws" {
  region = var.aws_region
}

# 全てのIPからのSSHアクセスを許可するセキュリティグループを作成
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_from_anywhere"
  description = "Allow SSH inbound traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # すべてのIPアドレスを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # すべてのアウトバウンドトラフィックを許可
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_from_anywhere"
  }
}

# EC2インスタンスの起動
resource "aws_instance" "example" {
  ami           = "ami-0c08c226b5ff7874c" # TokyoリージョンのAmazon Linux 2 AMI ID
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_ssh.name]  # セキュリティグループをアタッチ

  tags = {
    Name = "TerraformExample"
  }
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "ap-northeast-1"  # Tokyoリージョンをデフォルトに設定
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}
