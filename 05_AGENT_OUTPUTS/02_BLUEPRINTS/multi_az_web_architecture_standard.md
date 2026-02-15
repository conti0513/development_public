# クラウドアーキテクチャ設計書: 高可用性Webアプリケーション基盤

## 1. 概要
本ドキュメントは、ミッションクリティカルなWebアプリケーション向けの標準的なMulti-AZアーキテクチャの設計指針を記述する。スケーラビリティ、可用性、およびセキュリティを重視した構成となっている。

## 2. コンポーネント構成
### 2.1 ネットワーク層 (VPC)
- **リージョン:** ap-northeast-1 (東京)
- **CIDR:** 10.0.0.0/16
- **構成:** 3つのAvailability Zone (AZ) を活用した冗長化
  - **Public Subnets:** ALB、NAT Gatewayを配置
  - **Private Subnets:** アプリケーションサーバ (EC2/ECS) を配置
  - **Isolated Subnets:** データベース (RDS/ElastiCache) を配置

### 2.2 コンピューティング層
- **Load Balancer:** Application Load Balancer (ALB) を採用し、パスベースルーティングを実装
- **Auto Scaling:** CPU使用率およびリクエスト数に基づいた動的スケーリングの設定
- **Instance Management:** SSM Session Managerによるマネージドアクセス（踏み台サーバの廃止）

### 2.3 データ層
- **Amazon RDS:** Multi-AZ構成による自動フェイルオーバーを有効化
- **Amazon S3:** 静的コンテンツの配信およびログ保存。ライフサイクルポリシーによるコスト最適化

## 3. セキュリティ設計
- **Security Groups:** 最小権限の原則 (Least Privilege) に基づくステートフルフィルタリング
- **IAM Role:** 各リソースに対するきめ細やかなアクセス制御 (IAM Managed Policies)
- **Encryption:** AWS KMSによるデータ暗号化 (At-rest) および TLS 1.2以上による通信暗号化 (In-transit)

## 4. 監視・運用
- **CloudWatch:** メトリクス監視、アラート通知 (SNS)
- **AWS CloudTrail:** APIコール監査ログの集約
