# AWS Hosting AutoScale & Proactive Monitoring Case
（匿名化アーキテクチャケース）

## 概要

広告キャンペーン時のアクセススパイクによるサービス停止の運用課題に対し、  
CloudWatchアラームをトリガーにLambda関数を起動し、営業チームへ通知する仕組みを構築しました。

ALB＋AutoScalingのWeb基盤に対して  
**イベント駆動型の監視・通知フロー** を実装した運用改善事例です。

また、キャンペーンサイトはサブドメイン単位で増減する運用だったため、  
**ドメインベースの通知ルーティング** を実装し、主担当営業が迅速に状況把握できるようにしました。

---

# ビジネス背景

本システムは複数広告主の  
**キャンペーンサイトをホスティングするWeb基盤** でした。

例

- キャンペーンLP
- 短期プロモーションサイト
- 広告流入サイト

サイトは顧客ごとに

```

aa.example.com
bb.example.com
campaign-x.example.com

```

のように **サブドメイン単位で作成・終了する運用** でした。

広告開始直後には以下の問題が発生していました。

```

広告配信開始
↓
アクセス急増
↓
Webサーバー高負荷
↓
サイト停止

```

---

# 課題（AS-IS）

当時の運用は完全に受動的でした。

```

アクセススパイク
↓
サイト停止
↓
顧客が営業へ問い合わせ
↓
営業からエンジニアへ連絡
↓
手動復旧

```

問題点

- 障害検知が顧客依存
- 復旧までの時間が長い
- 顧客体験の悪化
- 運用負荷が高い

---

# 改善アプローチ

以下の構成で  
**AutoScaling + イベント駆動通知** を実装しました。

---

# Web基盤

```

User
│
▼
ALB
│
▼
Auto Scaling Group
│
▼
EC2 (Apache)

```

負荷増加時

```

アクセス増加
↓
AutoScaling
↓
EC2自動追加

```

インスタンス障害時

```

ALB Health Check NG
↓
ASGがインスタンス切り離し
↓
新規インスタンス起動

```

---

# 監視構成

CloudWatchを利用して統合監視を実装。

```

CloudWatch Metrics
│
▼
CloudWatch Alarm
│
▼
AWS Lambda
│
▼
LINE通知
（営業チーム）

```

監視対象

- CPU使用率
- メモリ使用率
- Load Average
- ディスク使用率
- ALBヘルスチェック
- HTTP 5xx

---

# AutoScaling設定

```

Min     : 3
Desired : 3
Max     : 6〜10

```

これにより

- アクセス急増時の自動スケール
- インスタンス障害の自動復旧

を実現しました。

---

# Lambda通知設計

CloudWatch Alarmをトリガーに  
Lambda（Python）を実行し、営業へ通知しました。

Lambdaの主な役割

```

CloudWatch Alarm受信
↓
対象ドメイン特定
↓
ルーティングテーブル参照
↓
通知文生成
↓
LINE送信

```

---

# 通知ルーティング設計

キャンペーンサイトは  
**サブドメイン単位で顧客が異なる**ため、

以下のテーブルを用いて通知先を管理しました。

```

## Domain            Customer      PrimarySales

aa.example.com    Client A      Tanaka
bb.example.com    Client B      Suzuki
cc.example.com    Client C      Sato

```

Lambdaは

1. アラームから対象ドメインを取得
2. テーブルを参照
3. 顧客名と主担当営業を取得

という処理を行います。

---

# 通知ポリシー

通知は

- **営業チーム全体のLINEグループに送信**
- **本文に主担当営業を明記**

という設計にしました。

理由

- 担当不在でもチームが把握できる
- 主担当が即対応可能
- 障害見逃しを防止

---

# 通知メッセージ例

```

【ALERT】キャンペーンサイト異常検知

顧客: Client A
ドメイン: aa.example.com
主担当: Tanaka さん（確認お願いします）

検知内容:
CPU High

理由:
閾値80%超 / 現在92%

想定影響:
サイト応答遅延の可能性

初動:
・状況確認
・エンジニア連携
・必要に応じ顧客へ一次共有

```

---

# 運用改善

改善前

```

顧客
↓
営業
↓
エンジニア

```

改善後

```

CloudWatch検知
↓
Lambda通知
↓
営業が即把握
↓
エンジニア対応

```

---

# 成果

- 障害検知の高速化
- 復旧時間短縮
- アクセススパイク耐性向上
- 運用の標準化
- 営業とエンジニアの連携改善

---

# 技術ポイント

- Auto Scaling による負荷分散
- ALBヘルスチェックによる自動復旧
- CloudWatch統合監視
- Lambdaイベント駆動通知
- サブドメインベースの通知ルーティング

---

# アーキテクチャ図

```

```
            Internet
                │
                ▼
             Users
                │
                ▼
             ALB
                │
    ┌───────────┴───────────┐
    │                       │
 EC2 Instance           EC2 Instance
 (Apache)               (Apache)
    │                       │
    └───────────┬───────────┘
                │
         Auto Scaling Group

                │
                ▼
        CloudWatch Metrics
                │
                ▼
         CloudWatch Alarm
                │
                ▼
           AWS Lambda
                │
                ▼
           LINE Group
        (Sales Notification)
```

```

---

# 運用設計のポイント

この構成では

```

Monitoring
↓
Event
↓
Automation

```

という **イベント駆動型運用** を実現しました。

また

- サブドメイン単位の顧客管理
- 主担当営業の明示
- 営業チーム全体への通知

を組み合わせることで  
**ビジネス運用に適した監視通知設計** を実現しました。
```

---