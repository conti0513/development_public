# ✅ GCP & AWS SFTP 転送システム要件 (テスト環境)

## **1. システム構成**
データフロー: **PC** → **AWS SFTP** → **AWS S3** → **GCS** → **Cloud Functions** → **基幹FTPサーバー**

```plaintext
  [1] PC  
      │  
      ▼  
+----------------+  
| [2] AWS SFTP   |  (aws-sftp)  
+----------------+  
      │  
      ▼  
+----------------+  
| [3] AWS S3     |  (aws-s3-bucket)  
+----------------+  
      │  
      ▼  
+----------------+  
| [4] GCS        |  (gcp-gcs-bucket)  
+----------------+  
      │  
      ▼  
+--------------------------+  
| [5] Cloud Functions      |  (gcp-cf-sftp-transfer)  
+--------------------------+  
      │  
      ▼  
+---------------------+  
| [6] 基幹FTPサーバー |  (core-ftp-server/AWS Transfer Family)  
+---------------------+  
```

## **2. 各コンポーネントの役割**
### **AWS 側**
- **AWS SFTP (`aws-sftp`)**: PC からの CSV ファイルを受信
- **Amazon S3 (`aws-s3-bucket`)**: SFTP 経由のデータを保存し、GCS に転送

### **Google Cloud 側**
- **Google Cloud Storage (`gcp-gcs-bucket`)**: S3 からのデータを受け取り、Cloud Function をトリガー
- **Cloud Functions (Gen2) (`gcp-cf-sftp-transfer`)**: GCS の新規 CSV を検知し、基幹FTP に転送
- **基幹FTP (`core-ftp-server`)**: 最終的なデータの格納先

## **3. 開発するコンポーネント**
- ✅ **AWS SFTP 設定 (`aws-sftp`)**: PC からのデータ受信
- ✅ **S3 バケット (`aws-s3-bucket`)**: SFTP データを保存・GCS 転送
- ✅ **GCS バケット (`gcp-gcs-bucket`)**: S3 からのデータ受け取り
- ✅ **Cloud Functions (`gcp-cf-sftp-transfer`)**: GCS から基幹FTPへの転送
- ✅ **IAM 設定 (Eventarc & GCS アクセス権限)**
- ✅ **環境変数管理 (SFTP 接続情報の安全な管理)**

## **4. 環境変数 (Cloud Functions 用)**
| 環境変数 | 説明 |
|-----------|--------------------------------|
| `SFTP_HOST` | `core-ftp-server` のホスト名 |
| `SFTP_PORT` | SFTP ポート（通常 22） |
| `SFTP_USER` | SFTP のユーザー名 |
| `SFTP_PASSWORD` | SFTP のパスワード |
| `SFTP_REMOTE_PATH` | SFTP の保存ディレクトリ（例: `/upload/`） |

## **5. 設計のポイント**
- ✅ **汎用的な名前で構成（職場でも流用可能）**  
- ✅ **AWS から GCP へのデータ連携を確立**  
- ✅ **Cloud Functions は Gen2 でデプロイ**  
- ✅ **環境変数で設定を管理し、柔軟に適用可能**

## **6. プロジェクトフォルダ構成**
```plaintext
~/projects/
  ├── gcp-sftp-transfer/  ← このプロジェクト用フォルダ
  │   ├── cloud-functions/   ← CFのコード
  │   ├── terraform/         ← IaCで管理する場合
  │   ├── scripts/           ← テスト用スクリプト
  │   ├── docs/              ← 設計メモ
  │   ├── README.md          ← 環境セットアップガイド
```

