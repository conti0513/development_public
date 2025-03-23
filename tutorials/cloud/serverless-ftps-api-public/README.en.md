# serverless-ftps-api-public (English)

This is a sample infrastructure setup to build a **serverless file transfer API** on GCP using Cloud Run and an external FTPS server. The project is divided into three modules, all implemented using shell scripts, enabling easy deployment, testing, and teardown.

---

## 🔧 Project Structure

```
serverless-ftps-api-public/
├── A_cloudrun-api/      # Cloud Run API deployment and testing
├── B_ftps-server/       # FTPS server creation and connectivity check
└── C_vpc-networking/    # Network components (VPC, NAT, Connector)
```

---

## 🏗️ System Architecture

```
[GCS] ---> [Cloud Run API] ---> [FTPS Server (GCE)]
                 │
        (VPC Connector + NAT)
                 │
             [Internet]
```

- When a file is uploaded to a GCS bucket, Cloud Run is triggered.
- Cloud Run connects to an external FTPS server using a fixed IP.
- Fixed IP is made possible by routing through a VPC Connector and Cloud NAT.

---

## A. Cloud Run API Module (`A_cloudrun-api/`)

Handles the API endpoint executed by Cloud Run, triggered by GCS uploads.

### 📁 Key Files
- `main.py`: Cloud Run entry point
- `config.api.json`: API config (project ID, bucket, FTPS credentials)
- `01_deploy_cloud_run.sh`: Deploys the Cloud Run service
- `03_test_cloud_run.sh`: Uploads a test file to GCS to trigger the API
- `99_delete_cloud_run.sh`: Cleanup script

---

## B. FTPS Server Module (`B_ftps-server/`)

Creates a simple FTPS server on GCE for testing Cloud Run FTPS uploads.

### 📁 Key Files
- `config.json`: FTP username, password, and other settings
- `01_create_ftps_server.sh`: Create the GCE instance
- `03_create_ftps_user.sh`: Create a user on the FTPS server
- `05_test_ftps_login.sh`: Test FTPS login
- `09_delete_ftps_server.sh`: Cleanup script

---

## C. Networking Module (`C_vpc-networking/`)

Builds a private networking environment that enables Cloud Run to use a fixed IP.

### 📁 Key Files
- `config.network.json`: Contains project ID and resource names
- `01_create_network.sh`: Create the VPC
- `04_create_nat.sh`: Set up Cloud NAT
- `05_create_connector.sh`: Create a VPC Access Connector
- `06_check_network_status.sh`: Verifies the network components
- `09_delete_network.sh`: Cleanup script

---

## 🚀 Execution Steps (Recommended Order)

### 1. Create the Network
```bash
cd C_vpc-networking
bash 01_create_network.sh
bash 02_create_subnet.sh
bash 03_create_router.sh
bash 04_create_nat.sh
bash 05_create_connector.sh
```

### 2. Set Up the FTPS Server
```bash
cd B_ftps-server
bash 01_create_ftps_server.sh
bash 02_setup_ftps_env.sh
bash 03_create_ftps_user.sh
```

### 3. Deploy and Test the Cloud Run API
```bash
cd A_cloudrun-api
bash 01_deploy_cloud_run.sh
bash 03_test_cloud_run.sh
```

### 4. Clean Up Resources
```bash
bash A_cloudrun-api/99_delete_cloud_run.sh
bash B_ftps-server/09_delete_ftps_server.sh
bash C_vpc-networking/09_delete_network.sh
```

---

## 🧪 Example Output (Upload → FTPS Transfer)
```bash
$ bash 03_test_cloud_run.sh

✅ File uploaded to GCS: upload_test_20250323050140.txt

✅ Cloud Run triggered → FTPS transfer succeeded:

Transfer completed:
upload_test_20250323050140.txt -> /home/your_username/upload_test_20250323050140.txt
```

---

## ✅ Notes
- All credentials and IDs in this repository are masked.
- Please update your own `config.*.json` files accordingly.
- Make sure billing is enabled and your IAM account has required permissions.

---

## 📄 License
MIT License


