# Cloud Transaction Data Pipeline Case
（AWS → GCP → External System）

## 概要

海外拠点の店舗システムから送信される  
トランザクションデータをクラウド間で連携する  
データパイプラインの構築・運用に関わりました。

データはAWSを入口として受信し、

- AWS
- GCP
- 外部基幹システム

を連携する **クラウド横断データパイプライン** を構築しました。

---

# 背景

海外拠点の店舗システムから  
トランザクションデータを収集し、

- 売上管理
- BI分析
- 外部システム連携

に利用する必要がありました。

既存環境では

- データ転送の安定性
- セキュリティ
- 運用管理

に課題がありました。

---

# データフロー

```

Store Edge System
│
▼
SFTP (AWS Transfer Family)
│
▼
Amazon S3
│
▼
Data Pipeline
│
▼
Google BigQuery
│
▼
Data Processing
(Trimming / Transform)
│
▼
SFTP Server (Static IP)
│
▼
External Business System

```

---

# アーキテクチャ

```

```
    Store Edge System
            │
            ▼
    SFTP Upload
```

(AWS Transfer Family)
│
▼
S3
│
▼
Data Pipeline
│
▼
BigQuery
│
▼
Data Transformation
│
▼
SFTP Server
(Static IP)
│
▼
External System

```

---

# AWS側構成

AWSは主に  
**データ受信基盤** として利用しました。

```

AWS Transfer Family
│
▼
S3 Bucket

```

役割

- トランザクションデータ受信
- セキュアなSFTP転送
- データ保存

---

# GCP側構成

GCPでは

- データ処理
- 分析
- 外部連携

を担当しました。

```

Cloud Functions
│
▼
BigQuery
│
▼
Data Transform
│
▼
SFTP Export

```

---

# データ処理

BigQueryを利用し

- データ正規化
- 不要カラム削除
- フォーマット整形

を実施しました。

```

Raw Transaction Data
↓
Cleaning
↓
Trimming
↓
Export Data

```

---

# 外部連携

処理後のデータは  
外部システムへSFTP連携。

要件

- 固定IP接続
- セキュア通信
- 自動連携

---

# 技術ポイント

- AWS Transfer Family によるSFTP受信
- S3によるデータ保存
- GCP BigQueryによるデータ処理
- クラウド横断パイプライン設計
- 固定IPによる外部システム接続

---

# アーキテクチャ図

```

```
  Store Edge System
         │
         ▼
```

AWS Transfer Family
│
▼
S3
│
▼
Data Pipeline
│
▼
BigQuery
│
▼
Data Processing
│
▼
SFTP Server
(Static IP)
│
▼
External System

```

---

# 成果

- 海外拠点データの安定収集
- データパイプライン自動化
- クラウド横断データ連携
- BI分析基盤の整備

---

# 技術領域

- AWS
- GCP
- Data Pipeline
- BigQuery
- SFTP Integration
- Cloud Data Architecture
```

---
