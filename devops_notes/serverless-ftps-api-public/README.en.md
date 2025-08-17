````markdown
# 📡 Serverless FTPS Transfer API on GCP

## 📌 Overview
This project demonstrates how to build a **serverless FTPS integration** on Google Cloud using Cloud Run, VPC networking, and an external FTPS server.  
（Cloud Run + 固定IP + FTPS 接続の構成サンプル）

It is modular, fully script-based, and designed for quick deployment, testing, and teardown.  
（スクリプトで簡単にデプロイ・削除できる構成）

---

## 🧱 Project Structure

```bash
serverless-ftps-api-public/
├── A_cloudrun-api/       # Cloud Run FTPS API (GCS Triggered)
├── B_ftps-server/        # GCE-based FTPS Server (Testing Target)
└── C_vpc-networking/     # Fixed IP Networking (VPC + NAT)
````

---

## 🏗️ Architecture

```text
[GCS] ──> [Cloud Run API] ──> [FTPS Server (GCE)]
              │
   (VPC Connector + NAT)
              │
          [Internet]
```

* Upload to GCS triggers Cloud Run
* Cloud Run uploads file to FTPS server using fixed IP
* Static IP is achieved via VPC Connector + Cloud NAT

---

## 🔧 Modules

### A. Cloud Run API

* `main.py`: Cloud Run main script
* `config.api.json`: API settings (bucket, credentials)
* `01_deploy_cloud_run.sh`: Deploy Cloud Run
* `03_test_cloud_run.sh`: Upload test file
* `99_delete_cloud_run.sh`: Delete resources

### B. FTPS Server

* `config.json`: Auth & connection settings
* `01_create_ftps_server.sh`: Create GCE instance
* `03_create_ftps_user.sh`: Create user
* `05_test_ftps_login.sh`: Login test
* `09_delete_ftps_server.sh`: Delete server

### C. Networking

* `config.network.json`: VPC/NAT settings
* `01_create_network.sh`: Create VPC
* `04_create_nat.sh`: Create Cloud NAT
* `05_create_connector.sh`: Create VPC Connector
* `09_delete_network.sh`: Cleanup

---

## 🚀 How to Run

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

### 4️⃣ Cleanup

```bash
bash A_cloudrun-api/99_delete_cloud_run.sh
bash B_ftps-server/09_delete_ftps_server.sh
bash C_vpc-networking/09_delete_network.sh
```

---

## 🧪 Output Example

```bash
$ bash 03_test_cloud_run.sh

✅ File uploaded to GCS: upload_test_20250323050140.txt
✅ Cloud Run triggered → FTPS transfer succeeded:

Transfer completed:
upload_test_20250323050140.txt -> /home/your_username/upload_test_20250323050140.txt
```

---

## 📝 Notes

* Replace dummy values in `config.*.json` with your own.
* Enable billing and IAM permissions before running.
* Each module is independent and testable.

---

## 📄 License

MIT License

```
```