# 📘 Project Summary – Gmail CSV to GCS Uploader  
# 📘 プロジェクト概要 – GmailのCSVをGCSへ自動アップロード

---

## ✅ Overview / 概要  
Automatically extracts `.csv` attachments from Gmail with specific subjects, and uploads the latest file to Google Cloud Storage (GCS).  
Also supports backup to Google Drive and removes older files from GCS.  
Gmailの特定の件名に一致する `.csv` ファイルを自動抽出し、Google Cloud Storage (GCS) に最新ファイルをアップロード。  
また、Google Driveへのバックアップや、GCS上の古いファイルの削除にも対応。

---

## �� Use Case / 利用シーン  
Used for automating sales or operations data intake from external vendors sending daily/weekly CSV reports via email.  
毎日または週次で外部ベンダーから送られるCSVレポートを自動的に取り込み、営業や業務データ処理を効率化。

---

## 🔄 Trigger Timing / 実行タイミング  
Runs every hour (e.g., at `xx:05`) using time-driven triggers in Google Apps Script.  
Google Apps Scriptの時間ベースのトリガーを用いて、毎時（例：05分）に自動実行。

---

## 💡 Features / 主な特徴  
- Supports multiple file encodings  
  複数の文字コード（Shift_JIS、UTF-8など）に対応  
- Preserves filename and folder hierarchy  
  ファイル名・保存先構造を維持して保存  
- Requires only initial authorization setup  
  初回の認可設定のみで、以降は無人で動作可能

---

## 🔐 Security Notes / セキュリティに関する注意  
- OAuth tokens used for GCS/Drive  
  GCSおよびDriveへのアクセスにはGoogle OAuthトークンを使用  
- File deletion policy ensures only latest is retained  
  最新のファイルのみを保持し、古いファイルは自動で削除
