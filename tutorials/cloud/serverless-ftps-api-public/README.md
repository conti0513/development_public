了解！以下は構成図と実行ログ例も追記した `README.md` の完成版です。

---

```markdown
# serverless-ftps-api-public

GCP 環境で Cloud Run + FTPS サーバーを連携し、**サーバーレスなファイル転送 API** を構築するインフラ構成サンプルです。  
以下の3つのモジュールに分かれ、すべてシェルスクリプトで構成されており、環境の作成・確認・削除を簡単に行えます。

---

## 🔧 構成概要

```
serverless-ftps-api-public/
├── A_cloudrun-api/      # Cloud Run API のデプロイとテスト
├── B_ftps-server/       # FTPS サーバーの作成と接続確認
└── C_vpc-networking/    # ネットワーク構成（VPC, NAT, Connector）
```

---

## 🏗️ システム構成図

```
[GCS] ---> [Cloud Run API] ---> [FTPS Server (GCE)]
                 │
        (VPC Connector + NAT)
                 │
             [Internet]
```

- GCS バケットにファイルがアップロードされると Cloud Run がトリガーされます。
- Cloud Run は固定IP経由で外部の FTPS サーバーに接続します。
- VPC Connector + NAT を使うことで Cloud Run でも固定IPを使用可能にしています。

---

## A. Cloud Run APIモジュール（`A_cloudrun-api/`）

GCSバケットにファイルがアップロードされると Cloud Run API が発火し、FTPS サーバーにファイル転送する仕組み。

### 📁 主なファイル
- `main.py`: Cloud Run のエントリーポイント
- `config.api.json`: Cloud Run に関する設定ファイル
- `01_deploy_cloud_run.sh`: Cloud Run のデプロイ
- `03_test_cloud_run.sh`: GCSアップロードによる動作テスト
- `99_delete_cloud_run.sh`: 削除スクリプト

---

## B. FTPSサーバーモジュール（`B_ftps-server/`）

GCE上に簡易的な FTPS サーバーを立て、Cloud Run 側からの接続先として利用。

### 📁 主なファイル
- `config.json`: ユーザー名やパスワード等のFTPS設定
- `01_create_ftps_server.sh`: GCE インスタンス作成
- `03_create_ftps_user.sh`: FTPS ユーザー作成
- `05_test_ftps_login.sh`: ログインテスト
- `09_delete_ftps_server.sh`: 削除スクリプト

---

## C. ネットワーク構成モジュール（`C_vpc-networking/`）

Cloud Run から固定IPで外部 FTPS サーバーに接続するためのネットワーク構成。

### 📁 主なファイル
- `config.network.json`: プロジェクトIDやリソース名を記述
- `01_create_network.sh`: VPC作成
- `04_create_nat.sh`: Cloud NAT作成
- `05_create_connector.sh`: VPC Connector作成
- `06_check_network_status.sh`: 構成確認スクリプト
- `09_delete_network.sh`: 削除スクリプト

---

## 🚀 実行手順（推奨順）

### 1. ネットワーク構成の作成

```bash
cd C_vpc-networking
bash 01_create_network.sh
bash 02_create_subnet.sh
bash 03_create_router.sh
bash 04_create_nat.sh
bash 05_create_connector.sh
```

### 2. FTPSサーバーの構築

```bash
cd B_ftps-server
bash 01_create_ftps_server.sh
bash 02_setup_ftps_env.sh
bash 03_create_ftps_user.sh
```

### 3. Cloud Run API のデプロイ & テスト

```bash
cd A_cloudrun-api
bash 01_deploy_cloud_run.sh
bash 03_test_cloud_run.sh
```

### 4. リソースの削除（任意）

```bash
bash A_cloudrun-api/99_delete_cloud_run.sh
bash B_ftps-server/09_delete_ftps_server.sh
bash C_vpc-networking/09_delete_network.sh
```

---

## 🧪 実行ログ例（Cloud Run へのアップロード→FTPS 転送）

```bash
$ bash 03_test_cloud_run.sh

✅ GCSへファイルアップロード完了: upload_test_20250323050140.txt

✅ Cloud Runが発火 → FTPSへ転送成功ログ確認:

Transfer completed:
upload_test_20250323050140.txt -> /home/your_username/upload_test_20250323050140.txt
```

---

## ✅ 注意点

- このリポジトリ内の設定値（パスワードやプロジェクトID等）は **すべてマスク済み** です。
- `config.*.json` ファイルを自身の環境に合わせて修正してください。
- GCPリソースを作成するには必要な権限と課金設定が必要です。

---

## 📄 ライセンス

MIT License
```

---

このREADMEは、GitHub 公開時にもそのまま使える構成になっています。  
必要であれば `.png` の構成図や GIF デモなども追加可能です。希望があれば教えてください！
