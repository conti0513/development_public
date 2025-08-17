## 📘 `README.md` 提案: `A_cloudrun-api/`

```markdown
# A_cloudrun-api - FTPS連携用 Cloud Run API

本ディレクトリは、Google Cloud Run を活用して、Google Cloud Storage（GCS）からのファイルアップロードイベントをトリガーにし、FTPS（FTP over TLS）で外部サーバへファイルをアップロードするAPIの構成です。

---

## 🧩 構成概要

```mermaid
graph LR
  GCS[Cloud Storage (Trigger Bucket)] -->|通知| CloudRun[Cloud Run API]
  CloudRun -->|FTPS Upload| FTPS[FTPS Server]
```

---

## 🔧 使用技術

- Cloud Run（FlaskベースのPythonアプリ）
- EventArc（GCSトリガー通知）
- Cloud NAT（固定IPで外部FTPS接続）
- PyCurl（明示的なFTPS対応）
- Google Cloud Storage Client（ダウンロード用）

---

## 📂 ディレクトリ構成

| ファイル名 | 説明 |
|------------|------|
| `main.py` | Cloud Run 本体（Flaskアプリ） |
| `requirements.txt` | Python 依存ライブラリ |
| `config.api.json` | Cloud Run用の設定ファイル（GCPプロジェクト、FTPS情報） |
| `01_deploy_cloud_run.sh` | Cloud Run + EventArc デプロイ用スクリプト |
| `02_check_cloud_run_status.sh` | Cloud Run の状態確認スクリプト |
| `03_test_cloud_run.sh` | テストファイルをGCSにアップロードして連携確認 |
| `05_check_vsftpd_login.sh` | lftpによるFTPS接続テスト |
| `99_delete_cloud_run.sh` | Cloud Run 削除スクリプト |

---

## 🚀 デプロイ手順

```bash
cd A_cloudrun-api/
bash 01_deploy_cloud_run.sh
```

- `config.api.json` に設定を書いてから実行すること
- Cloud NAT / VPC Connector が事前に必要（`C_vpc-networking/` 参照）

---

## ✅ 動作確認手順

```bash
bash 03_test_cloud_run.sh
```

- テスト用 `.csv` を自動生成し、指定バケットにアップロード
- Cloud Run 経由でFTPSアップロードされ、ログに出力されます

---

## 📌 注意点

- **FTPSはExplicitモード (AUTH TLS) を使用**
- `pycurl` で `FTP_SSL_ALL` と `USESSL_ALL` を明示設定済み
- Cloud Runは `Cloud NAT` 経由で接続され、**固定IPによる通信制御が可能**
- `config.api.json` は `.gitignore` 推奨 or ダミー化して公開

---

## 🧪 補足：接続先FTPSのローカルテスト

```bash
bash 05_check_vsftpd_login.sh
```

事前に `B_ftps-server/` で立ち上げた `vsftpd` 環境が必要です。

---

## 🗃️ 再現性確保

- **このフォルダ単体でCloud Run + FTPS連携が完結**
- `.sh` スクリプトで完全自動化
- GCPプロジェクトとBucket名、FTPS情報を書き換えるだけで別環境にも即対応可能

---

## 📤 利用例（商用）

- 海外拠点 → GCS経由 → 本社FTPS連携（基幹取り込み）
- 無人データアップロード連携（Webhook不要）

---

## 📚 関連

- `B_ftps-server/` ... ローカルFTPS環境の構築スクリプト
- `C_vpc-networking/` ... 固定IP用 VPC/NAT の構築スクリプト
```

---

## 🔚 次ステップ

- 必要に応じて `config.api.json.sample` を作成して、実機との差分を管理
- READMEはZennの分割記事ベースにも使える構成になってます

---