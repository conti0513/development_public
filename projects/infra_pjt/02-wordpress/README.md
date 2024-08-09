# シングル構成でWordPressのブログサービスを構築

## URL
https://harusite.net/049/


## 要件
### IGW
@VPC 172.16.0.0/16
 vpc-041f1fec75e285b8b


### VPC
subnet
AZ ap-northeast-1a
・Public Subnet 1a (172.16.1.0/24)
・Private Subnet 1a (172.16.2.0/24)

AZ ap-northeast-1c
・Public Subnet 1c (172.16.3.0/24)
・Private Subnet 1c (172.16.4.0/24)

Route Tavle
・Route Table Public
・Route Table Private


### security gropu
Name web-sg
description web-sg
VPC	VPC (今回作成したVPC)
インバウンドルール
タイプ：HTTPS／ソース：0.0.0.0/0
タイプ：SSH／ソース：0.0.0.0/0

### EC2
・Name wordpress-01
・user ubuntu
・key pair conti-2
・public-ip をoutput

### RDS
subnet group
・name	wordpress-db-subnet group
・description	wordpress-db-subnet group
・AZ
  ap-northeast-1a
  ap-northeast-1c
・subnet
  172.16.2.0/24
  172.16.4.0/24

## 手順
$ cd ~/work-dir/
$ vim main.tf


## ファイル構成
<work-dir>
  |- db.tf
  |- ec2.tf
  |- output.tf
  |- variables.tf
  |- vpc.tf


## コマンド

terraform init

terraform plan

terraform apply

terraform destroy
---


