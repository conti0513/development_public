### Experience 2: Flexible Monitoring Environment

## 概要
このプロジェクトは、オンプレミスからAWSクラウドへの移行直後に、手動モニタリングの負担を軽減し、Auto Scaling環境での監視を効率化するために導入した柔軟な監視環境を再現します。具体的には、CloudWatch、CloudWatch Agent、メトリクスの集約、およびデータ損失防止の施策を活用します。

## 背景
オンプレミスからAWSへの移行後、運用エンジニアは手動でモニタリングを行っていました。しかし、Auto Scaling環境では手動監視が追いつかず、監視が適切に機能しない問題がありました。

## 解決策
- **CloudWatch**: 各種メトリクスの収集とアラーム設定
- **CloudWatch Agent**: より詳細なメトリクスの収集
- **Aggregation**: メトリクスの集約と分析
- **Auto Scaling対応**: Auto Scaling停止時のデータ損失防止施策

## 閾値の設定
- **CPU使用率**
- **ハードディスク使用率**
- **メモリ使用率**
- **Apacheログの監視**: エラーログの増加や特定のエラーメッセージの頻発を監視

## インパクト
- 手動管理からの解放
- Slackへのアラーム通知

## データ損失防止の施策
Auto Scaling環境では、新しいインスタンスが起動したり停止したりする際にデータ損失のリスクがあります。以下の対策を講じました：

1. **セッションの永続化**: ELBでセッションスティッキーを設定することで、特定のユーザーのリクエストが同じインスタンスにルーティングされるようにします。
   ```sh
   aws elb create-load-balancer-policy --load-balancer-name my-load-balancer --policy-name my-stickiness-policy --policy-type-name AppCookieStickinessPolicyType --policy-attributes AttributeName=CookieName,AttributeValue=my-app-cookie
   aws elb set-load-balancer-policies-of-listener --load-balancer-name my-load-balancer --load-balancer-port 80 --policy-names my-stickiness-policy
   ```

2. **ログの集中管理**: ログをS3に保存し、CloudWatch Logsにストリームすることで、インスタンス停止時にもログデータが失われないようにします。
   ```sh
   aws s3 mb s3://my-log-bucket
   aws logs create-log-group --log-group-name my-log-group
   aws logs create-log-stream --log-group-name my-log-group --log-stream-name my-log-stream
   ```

3. **データベースのバックアップ**: MySQLデータベースを使用し、定期的なバックアップを実施します。
   ```sh
   mysqldump -u username -p database_name > backup.sql
   aws s3 cp backup.sql s3://my-backup-bucket/backup.sql
   ```

4. **Health Checksの設定**: Auto ScalingとELBのヘルスチェックを適切に設定し、障害発生時に速やかに問題のあるインスタンスを取り除くことで、ユーザーへの影響を最小限に抑えます。
   ```sh
   aws autoscaling put-scheduled-update-group-action --auto-scaling-group-name my-asg --scheduled-action-name scale-up --recurrence "0 18 * * *" --desired-capacity 10
   ```

## 手順
1. **EC2の設定**
   - `ec2`ディレクトリに移動し、セットアップスクリプトを実行します。
     ```sh
     cd ec2
     ./setup_ec2.sh
     ```

2. **Auto Scalingの設定**
   - `autoscaling`ディレクトリに移動し、セットアップスクリプトを実行します。
     ```sh
     cd autoscaling
     ./setup_autoscaling.sh
     ```

3. **CloudWatchの設定**
   - `cloudwatch`ディレクトリに移動し、セットアップスクリプトを実行します。
     ```sh
     cd cloudwatch
     ./setup_cloudwatch.sh
     ./cloudwatch_agent.sh
     ```

4. **Terraformの設定**
   - 過去のプロジェクトではTerraformを使用していませんでしたが、最新の技術を取り入れるためにここではTerraformを使用しています。
   - `terraform`ディレクトリに移動し、Terraformの初期化と適用を行います。
     ```sh
     cd terraform
     terraform init
     terraform apply -auto-approve
     ```

5. **追加スクリプト**
   - `scripts`ディレクトリにある追加のスクリプトを使用して、監視設定を作成および管理します。

## 使用技術
- AWS EC2
- AWS Auto Scaling
- AWS CloudWatch
- CloudWatch Agent
- Terraform (過去のプロジェクトでは未使用)

## 詳細
### 1. EC2の設定
`setup_ec2.sh`スクリプトは、以下の手順を実行します：
- EC2インスタンスの作成
- 必要なセキュリティグループの設定
- SSHアクセスの許可

### 2. Auto Scalingの設定
`setup_autoscaling.sh`スクリプトは、以下の手順を実行します：
- Auto Scalingグループの作成
- スケーリングポリシーの設定
- 健康チェックの設定

### 3. CloudWatchの設定
`setup_cloudwatch.sh`スクリプトは、以下の手順を実行します：
- CloudWatchアラームの作成
- メトリクスの設定
- ログの収集

`cloudwatch_agent.sh`スクリプトは、以下の手順を実行します：
- CloudWatchエージェントのインストール
- エージェントの設定ファイルの作成
- エージェントの起動

### 4. Terraformの設定
`main.tf`ファイルを使用して、以下のリソースを管理します：
- EC2インスタンス
- セキュリティグループ
- Auto Scalingグループ
- CloudWatchアラーム

### 5. 追加スクリプト
`scripts`ディレクトリには、以下のスクリプトが含まれます：
- `create_monitoring_dashboard.sh`: CloudWatchダッシュボードの作成
- `update_scaling_policy.sh`: スケーリングポリシーの更新
- `cleanup_resources.sh`: リソースのクリーンアップ

## データ保全、ログ保全、モニタリングの集約
- **データ保全**: MySQLデータベースのバックアップをS3に保存し、定期的なバックアップを実施
- **ログ保全**: ログデータをS3に保存し、CloudWatch Logsにストリーム
- **モニタリングの集約**: CloudWatch Agentを使用してメトリクスを収集し、CloudWatchで可視化

## 警報転送
CloudWatchアラームを設定し、SNSトピックを通じてSlackに警報通知を送信します。以下の手順で実装可能です：
1. **SNSトピックの作成**:
   ```sh
   aws sns create-topic --name my-topic
   ```
2. **SlackとSNSの連携**: SlackのIncoming Webhookを使用して、SNSトピックからSlackチャネルに通知を送信します。

```sh
aws sns subscribe --topic-arn arn:aws:sns:us-east-1:123456789012:my-topic --protocol https --notification-endpoint https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
```

---

## 設計と実装の貢献について
### 私が設計した箇所
- モニタリング
- 警報転送全般
- ログの収集

### チームで設計・実装した箇所
- Auto Scaling
- データ損失防止施策
- CloudWatch Agentの設定



### アーキテクチャ図

```plaintext
          +-------------------+
          |     インターネット    |
          +-------------------+
                  |
                  |
            +------------+
            |    ELB     |
            +------------+
            /            \
           /              \
+---------------+    +---------------+
|    EC2 (WEB)  |    |    EC2 (WEB)  |
| CloudWatch Ag |    | CloudWatch Ag |
+---------------+    +---------------+
          |                    |
          |                    |
+---------------+    +---------------+
|    EC2 (DB)   |    |    EC2 (DB)   |
+---------------+    +---------------+

          モニタリング & ログ管理
          +-----------------+
          |   CloudWatch    |
          +-----------------+
                  |
          +-----------------+
          |   CloudWatch    |
          |     Agent       |
          +-----------------+
```

---

### README

---

## テストケース
以下は、プロジェクトの主要コンポーネントに対するテストケースの概要です。

### 1. CloudWatchアラームテスト
- **目的**: 正常にアラームが設定され、メトリクスに基づいて通知が送信されることを確認する。
- **手順**: 
  1. CloudWatchダッシュボードにアクセス。
  2. 設定したアラームの条件をトリガーするための負荷をシミュレート。
  3. SNSトピックを確認し、Slackに通知が送信されることを確認。

### 2. CloudWatch Agentテスト
- **目的**: CloudWatch Agentが正しくインストールされ、メトリクスを収集していることを確認する。
- **手順**:
  1. EC2インスタンスにログインし、CloudWatch Agentのステータスを確認。
  2. CloudWatchダッシュボードで収集されたメトリクスを確認。

### 3. Auto Scalingテスト
- **目的**: Auto Scalingグループが設定されたポリシーに従ってスケールインおよびスケールアウトすることを確認する。
- **手順**:
  1. EC2インスタンスの負荷をシミュレートして増加させる。
  2. Auto Scalingグループが新しいインスタンスを起動することを確認。
  3. 負荷を減少させ、インスタンスが正常に終了することを確認。

## 注意事項
- **データ永続化**: セッションスティッキー、ログの集中管理、データベースのバックアップ設定。
- **ログ収集**: CloudWatch Logs、S3へのストリーミング。
- **モニタリング**: CloudWatchとCloudWatch Agentの設定。

---
