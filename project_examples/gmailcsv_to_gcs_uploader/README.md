# 📦 Gmail CSV to GCS Uploader  
# 📦 GmailのCSVをGCSにアップロードする自動化ツール

This project automatically extracts the latest `.csv` attachment from Gmail, uploads it to Google Cloud Storage (GCS), and optionally stores a history copy to Google Drive.  
このプロジェクトは、GmailのCSV添付ファイルを自動的に抽出し、Google Cloud Storageにアップロード、必要に応じてGoogle Driveにも保存します。

---

## 🔧 Technologies Used / 使用技術
- Google Apps Script (GAS)
- Gmail API
- Google Cloud Storage (GCS)
- Google Drive API

---

## 🧩 Key Features / 主な特徴
- Filters `.csv` attachments using subject and filename keywords  
  件名やファイル名のキーワードに基づいてCSVファイルを抽出
- Uploads only the **latest** file to GCS  
  最新のCSVファイルのみをGCSにアップロード
- Deletes old files from GCS, keeping only the most recent  
  GCS上の古いファイルは自動削除
- Supports backup to Google Drive (optional)  
  Driveへの履歴保存も可能（任意）
- Runs hourly via time-based trigger  
  毎時（例: xx:05）に自動実行（時間トリガー）

---

## 📁 Directory Structure / ディレクトリ構成

gmailcsv_to_gcs_uploader/ ├── README.md # Project overview / プロジェクト概要 ├── docs/ │ └── summary.md # Detailed use-case summary / ユースケースまとめ └── scripts/ ├── saveLatestCsvToGCSAndDrive.js # Main logic to extract/upload CSV ├── uploadToGCS.js # GCS upload logic ├── deleteOldFilesInGCS.js # Delete old files in GCS ├── saveToDrive.js # Optional: Save to Drive └── authorizeStorageAccess.js # Auth trigger (for first-time use)

yaml
コピーする
編集する

---

## 🔐 Security Notes / セキュリティについて
- Uses Google OAuth for GCS and Drive access  
  GCS・DriveへのアクセスにはOAuthを使用
- Deletes older files to reduce unnecessary storage  
  古いファイルは自動削除され、ストレージコストを節約

---

## 📌 Use Cases / 想定ユースケース
- Automated ingestion of vendor sales/inventory data  
  ベンダーからの売上・在庫データ自動取り込み
- Replaces manual CSV download/upload process  
  CSVの手動ダウンロードやアップロード作業の代替
- Improves reliability and reduces human error  
  信頼性向上とヒューマンエラーの削減

