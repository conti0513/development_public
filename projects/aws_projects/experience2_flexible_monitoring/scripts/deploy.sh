#!/bin/bash

# 開発環境向けデプロイメント手順
echo "Deploying to development"

# EC2インスタンスを起動
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --count 1 --instance-type t2.micro --key-name MyKeyPair --query 'Instances[0].InstanceId' --output text)
echo "Instance ID: $INSTANCE_ID"

# インスタンスが実行状態になるまで待機
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
echo "Instance $INSTANCE_ID is running"

# インスタンスのパブリックIPアドレスを取得
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
echo "Public IP: $PUBLIC_IP"

# SSHを使用して "Hello World" を出力
ssh -o StrictHostKeyChecking=no -i /path/to/MyKeyPair.pem ec2-user@$PUBLIC_IP "echo 'Hello World'"

# デプロイメントが完了したらインスタンスを終了
aws ec2 terminate-instances --instance-ids $INSTANCE_ID
aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
echo "Instance $INSTANCE_ID terminated"

