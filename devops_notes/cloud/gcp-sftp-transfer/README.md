### **📄 テスト環境: AWS↔GCP データ転送設計ドキュメント**  
**目的:** **AWS S3 → GCP → AWS SFTP（テスト環境）** でのファイル転送フローを構築し、全区間の動作検証を行う。

---

## **📌 システム構成図（テスト環境）**
```
[1] PC (手動アップロード)
      │
      ▼  
+------------------------+
| [2] AWS-1 SFTP        |  (test-aws-sftp)  
| (AWS Transfer Family)  |  *テスト用SFTPサーバー*
+------------------------+
      │  (定期転送)  ✅ **AWS S3に自動アップロード**
      ▼  
+------------------------+
| [3] AWS-1 S3          |  (test-aws-s3-bucket)  
| (S3バケット / 保管領域) |
+------------------------+
      │  (CFがポーリング) ✅ **GCSへ転送**
      ▼  
==================【AWS → GCP】==================
      │  
      ▼  
+------------------------+
| [4] GCS (ストレージ)   |  (test-gcp-gcs-bucket)  
| *S3からデータ受信*     |
+------------------------+
      │ (Eventarc発火)  ✅ **CFが実行**
      ▼  
+----------------------------------+
| [5] Cloud Functions             |  (test-gcp-cf-sftp-transfer)  
| *GCSのファイルをAWS-2へ転送*    |
+----------------------------------+
      │  (SFTP接続)  ✅ **AWS-2 (テスト) にアップロード**
      ▼  
==================【GCP → AWS】==================
      │  
      ▼  
+------------------------------+
| [6] AWS-2 SFTP (テスト)      |  (test-core-ftp-server)  
| (AWS Transfer Family)        |  *テスト環境のSFTPサーバー*
+------------------------------+
```

---

## **🛠️ 開発タスク（テスト環境）**
| No | タスク | 状態 |
|----|-------------------------------------------|------|
| **1** | **AWS-1 S3 → GCS 転送の Cloud Functions 実装** | ✅ 完了 |
| **2** | **GCP → AWS-2 SFTP 転送の Cloud Functions 実装** | ✅ 完了 |
| **3** | **Eventarc のトリガー設定（GCSの "finalized" イベントを検知）** | ✅ 完了 |
| **4** | **GCP 側の IAM 設定（最小権限で適切なアクセス管理）** | ✅ 完了 |
| **5** | **AWS-2 SFTP（テスト）用のIAMユーザー作成** | ✅ 完了 |
| **6** | **GCPの固定IPは不要（Cloud NATは使わない）** | ✅ 完了 |
| **7** | **環境変数の整理（SFTP接続情報の管理）** | ✅ 完了 |
| **8** | **動作確認用スクリプトの作成（手動テスト用）** | ✅ 完了 |
| **9** | **トラブルシューティングログの記録と改善点の整理** | ✅ 完了 |

---

## **🔐 IAM 権限設定（テスト環境）**
### **AWS 側 IAM 設定**
#### **AWS-1 S3 → GCS 転送用 IAM ポリシー**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:ListBucket"],
      "Resource": [
        "arn:aws:s3:::test-aws-s3-bucket",
        "arn:aws:s3:::test-aws-s3-bucket/*"
      ]
    }
  ]
}
```
#### **AWS-2 SFTP 接続用 IAM ユーザー**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["transfer:UploadFile"],
      "Resource": "arn:aws:transfer:ap-northeast-1:123456789012:server/s-XXXXXX"
    }
  ]
}
```

### **GCP 側 IAM 設定**
#### **Cloud Functions 実行権限**
```sh
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:CF_SERVICE_ACCOUNT" \
  --role="roles/cloudfunctions.invoker"
```
#### **Eventarc トリガー権限**
```sh
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:EVENTARC_SERVICE_ACCOUNT" \
  --role="roles/eventarc.eventReceiver"
```
#### **GCS のオブジェクト読み書き権限**
```sh
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:CF_SERVICE_ACCOUNT" \
  --role="roles/storage.objectAdmin"
```

---

## **🚨 トラブルシューティング（テスト環境）**
### **AWS-1 → GCS 転送で失敗する場合**
```sh
gcloud functions logs read test-s3-to-gcs --region="asia-northeast1" --limit=10
```
- **IAMの権限が適切か？**
- **S3バケットのオブジェクトキーが正しいか？**
```sh
aws s3 ls s3://test-aws-s3-bucket/
```

### **GCP → AWS-2 SFTP で失敗する場合**
```sh
sftp -i ~/.ssh/test-aws2-sftp-private-key.pem SFTP_USER@SFTP_HOST
```
- **IAMのアクセス制限が原因か？**
- **秘密鍵のフォーマットが正しいか？**
```sh
file ~/.ssh/test-aws2-sftp-private-key.pem
```
→ "ASCII text" なら問題なし、"DOS text" なら改行コード変換が必要

---

## **📌 本番環境移行時の考慮点**
🔹 **AWS-1 S3 → GCS の Cloud Functions を本番用のIAMで再設定**  
🔹 **GCP → AWS-2 SFTP のIAM設定を本番向けに変更**  
🔹 **Eventarc のトリガーを本番バケットに変更**  
🔹 **本番環境の固定IPアドレスの必要性を再検討**  

---

## **📂 プロジェクトフォルダ構成**
```plaintext
~/projects/
  ├── gcp-sftp-transfer-test/      ← **テスト環境のフォルダ**
  │   ├── cloud-functions/     ← CFのコード
  │   ├── terraform/           ← IaCで管理する場合
  │   ├── scripts/             ← テスト用スクリプト
  │   ├── docs/                ← 設計メモ
  │   ├── README.md            ← 環境セットアップガイド
  │   ├── .env                 ← 環境変数ファイル (Git管理対象外)
```
📌 **補足**
- **`.env`** に AWS S3 や SFTP の接続情報を管理し、セキュリティを担保  
- **Terraform で IAM 設定を自動化可能**  
- **スクリプト (`scripts/`) でテストデータ投入 & 動作確認用**  

---

