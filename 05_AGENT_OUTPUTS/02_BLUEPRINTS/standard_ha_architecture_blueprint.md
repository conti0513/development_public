# 高可用性クラウド基盤設計（リファレンスアーキテクチャ）

## 1. 概要
本ドキュメントは、AWS環境におけるマルチAZ（Availability Zone）構成を用いた、標準的なWebアプリケーション向けの高可用性インフラストラクチャの設計概要です。システムの信頼性、スケーラビリティ、およびセキュリティを担保することを目的とします。

## 2. コンポーネント構成
- **Network**: VPC (10.0.0.0/16) を中心とした3層レイヤー構造（Public, Private, Data）。
- **Compute**: 
    - Application Load Balancer (ALB) によるトラフィック分散。
    - Amazon ECS (Fargate) を用いたコンテナ実行基盤。
    - Auto Scalingによる負荷に応じた動的なリソース拡張。
- **Database**: Amazon Aurora (PostgreSQL互換) のマルチAZクラスタ。リードレプリカによる読み取り負荷の分散。
- **Security**: 
    - AWS WAFによるL7防御。
    - Security Groupsによる最小権限の通信制御。
    - IAM Roleによるリソースへのセキュアなアクセス管理。

## 3. 非機能要件への対応
- **可用性**: 各コンポーネントを2つ以上のAZに配置し、単一障害点（SPOF）を排除。
- **運用性**: CloudWatch Logs/Metricsによる集中監視と、Terraformを用いたIaC（Infrastructure as Code）の実現。
- **コスト**: 開発・検証環境においてはNAT Gatewayの集約やスポットインスタンスの活用を検討。
