# 📡 Serverless FTPS Transfer API on GCP

## 📌 Overview / 概要

This project demonstrates how to build a **serverless FTPS integration** on Google Cloud using Cloud Run, VPC networking, and an external FTPS server.  
（Cloud Run + 固定IP + FTPS 接続の構成サンプル）

It is modular, fully script-based, and designed for quick deployment, testing, and teardown.  
（スクリプトで簡単にデプロイ・削除できる構成）

---

## 🧱 Project Structure / プロジェクト構成

```bash
serverless-ftps-api-public/
├── A_cloudrun-api/       # Cloud Run FTPS API (GCS Triggered)
├── B_ftps-server/        # GCE-based FTPS Server (Testing Target)
└── C_vpc-networking/     # Fixed IP Networking (VPC + NAT)
```

---

## 🏗️ Architecture / システム構成

```text
[GCS] ──> [Cloud Run API] ──> [FTPS Server (GCE)]
              │
   (VPC Connector + NAT)
              │
          [Internet]
```

- Upload to GCS triggers Cloud Run  
- Cloud Run uploads file to FTPS server using fixed IP  
- Static IP is achieved via VPC Connector + Cloud NAT  

---

## 🔧 A. Cloud Run API Module

GCS トリガーで起動される Cloud Run API の構成

### 📁 Files
- `main.py`: Cloud Run main script  
- `config.api.json`: API設定（バケットや認証情報）  
- `01_deploy_cloud_run.sh`: Cloud Run のデプロイ  
- `03_test_cloud_run.sh`: テストファイルアップロード  
- `99_delete_cloud_run.sh`: リソース削除スクリプト  

---

## 📦 B. FTPS Server Module

GCE上にシンプルなFTPSサーバーを構築するモジュール

### 📁 Files
- `config.json`: 認証・接続設定  
- `01_create_ftps_server.sh`: GCEインスタンス作成  
- `03_create_ftps_user.sh`: ユーザー作成  
- `05_test_ftps_login.sh`: ログインテスト  
- `09_delete_ftps_server.sh`: 削除スクリプト  

---

## 🌐 C. Networking Module

Cloud Run 用に固定IPを提供するためのネットワーク構成

### 📁 Files
- `config.network.json`: VPC・NATなどの設定  
- `01_create_network.sh`: VPC作成  
- `04_create_nat.sh`: Cloud NAT作成  
- `05_create_connector.sh`: VPC Connector作成  
- `09_delete_network.sh`: クリーンアップスクリプト  

---

## 🚀 How to Run / 実行手順

### 1️⃣ Setup Network
```bash
cd C_vpc-networking
bash 01_create_network.sh
bash 02_create_subnet.sh
bash 03_create_router.sh
bash 04_create_nat.sh
bash 05_create_connector.sh
```

### 2️⃣ Setup FTPS Server
```bash
cd B_ftps-server
bash 01_create_ftps_server.sh
bash 02_setup_ftps_env.sh
bash 03_create_ftps_user.sh
```

### 3️⃣ Deploy Cloud Run API
```bash
cd A_cloudrun-api
bash 01_deploy_cloud_run.sh
bash 03_test_cloud_run.sh
```

### 4️⃣ Clean Up All Resources
```bash
bash A_cloudrun-api/99_delete_cloud_run.sh
bash B_ftps-server/09_delete_ftps_server.sh
bash C_vpc-networking/09_delete_network.sh
```

---

## 🧪 Output Sample / 実行例

```bash
$ bash 03_test_cloud_run.sh

✅ File uploaded to GCS: upload_test_20250323050140.txt

✅ Cloud Run triggered → FTPS transfer succeeded:

Transfer completed:
upload_test_20250323050140.txt -> /home/your_username/upload_test_20250323050140.txt
```

---

## 📝 Notes / 補足

- All `config.*.json` files contain dummy values – replace with your own.  
- Enable billing and grant necessary IAM permissions beforehand.  
- Project modules are isolated and can be tested individually.

---

## 📄 License

MIT License

---
```
