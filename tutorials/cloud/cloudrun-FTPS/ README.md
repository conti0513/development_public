# Cloud Run A (CRA) と FTPS サーバー (B) のネットワーク構成 & コンフィグレーション

## 1. ネットワーク要件

✅ **Cloud Run A からの外部通信には固定IPを使用**  
✅ **Cloud Router + Cloud NAT + 予約済み外部IP (NAT-IP) を設定**  
✅ **FTPS サーバー (B) のファイアウォールで Cloud Run A の固定IP のみ許可**  
✅ **Cloud Run A は VPC 内で動作し、VPC コネクタを使用**  
✅ **Cloud Run A からの `curl` で NAT-IP を確認できる API を実装**  
✅ **機能A・Bは外部接続を行うため、それぞれ別のVPCでパブリックIPを使用**  
✅ **機能B (FTPS) はエンドポイントとして構成可能**  

## 2. ネットワーク構成

1. **Cloud Run A を VPC 内に配置** (VPC コネクタを設定)  
2. **Cloud Router + Cloud NAT を利用し、NAT-IP を固定**  
3. **FTPS サーバー (B) のファイアウォールで Cloud Run A の NAT-IP のみ許可**  
4. **機能A・BはパブリックIPを持つ別のVPCに配置**  

✉ **構成図 (ASCII Art)**

```
 [Cloud Run A (VPC-A, Public IP)] → [Cloud Router] → [Cloud NAT (NAT-IP)] → [FTPS サーバー (B, VPC-B, Public IP or Endpoint)]
```

---

## 3. GCP リソース名 & `config.json` 設計

### **GCP リソース名の命名規則**

| リソース | 名称案 |
|---------|-------------------------------|
| **プロジェクトID** | `pjt-gcp` |
| **Cloud Run A** | `pjt-cra-file` |
| **GCS バケット** | `pjt-cra-bucket` |
| **Eventarc トリガー** | `pjt-cra-trigger` |
| **Cloud Router** | `pjt-cloud-router` |
| **Cloud NAT** | `pjt-cloud-nat` |
| **Cloud NAT の固定IP** | `pjt-nat-ip` |
| **VPC-A (Cloud Run A 用)** | `pjt-vpc-a` |
| **VPC-B (FTPS 用)** | `pjt-vpc-b` |
| **VPC コネクタ** | `pjt-vpc-connector` |
| **FTPS サーバー (B)** | `pjt-ftps-server` |
| **FTPS の固定IP** | `pjt-ftps-ip` |
| **ファイアウォールルール** | `pjt-fw-cra-to-ftps` |
| **Pub/Sub (ログ用)** | `pjt-cra-log` |

---

## 4. `config.json` の設計

```json
{
  "gcp_project": "pjt-gcp",
  "gcs_bucket": "pjt-cra-bucket",
  "gcs_trigger_folder": "input-csv/",
  "cloud_run": {
    "service_name": "pjt-cra-file",
    "region": "asia-northeast1",
    "ip_check_endpoint": "/ip-check"
  },
  "network": {
    "vpc_a_name": "pjt-vpc-a",
    "vpc_b_name": "pjt-vpc-b",
    "vpc_connector": "pjt-vpc-connector",
    "cloud_router": "pjt-cloud-router",
    "cloud_nat": "pjt-cloud-nat",
    "nat_ip": "35.200.XXX.XXX",
    "private_subnet": "10.128.0.0/20"
  },
  "ftps": {
    "server_ip": "34.85.XXX.XXX",
    "port": 21,
    "passive_ports": "50000-51000",
    "username": "ftps_user",
    "password": "securepassword",
    "upload_path": "/ftps-data/",
    "protocol": "FTPS",
    "mode": "passive"
  },
  "encoding": {
    "source_charset": "utf-8",
    "target_charset": "shift_jis"
  },
  "logging": {
    "pubsub_topic": "pjt-cra-log"
  }
}
```

---

## 5. Cloud Run A で実装する機能

✅ **Eventarc トリガー**: GCS `/input-csv/` にファイルがアップロードされると Cloud Run A を起動  
✅ **GCS からのファイル取得**: `google-cloud-storage` を利用し、特定フォルダのみ処理  
✅ **CSV の文字コード変換**: `UTF-8` → `Shift_JIS` へのエンコード  
✅ **FTPS へのファイル送信**: `ftplib.FTP_TLS` を使用し、ID/PASS 認証でアップロード  
✅ **固定IP を使用した通信**: Cloud NAT 経由で FTPS (B) に接続  
✅ **IP 確認 API**: `/ip-check` エンドポイントで NAT-IP を確認可能  
✅ **プライベートアドレス範囲**: `10.128.0.0/20` を VPC 内のサブネットとして使用  

---

## 6. デプロイ手順 (ステップバイステップ)

### **1. GCP 環境のセットアップ**
- Cloud Router, Cloud NAT, VPC, Firewall ルールの作成
- Cloud Run A の VPC 設定 (VPC コネクタの適用)

### **2. Cloud Run A のデプロイ**
```sh
gcloud run deploy pjt-cra-file \
  --source . \
  --region=asia-northeast1 \
  --vpc-connector=pjt-vpc-connector \
  --egress=all \
  --allow-unauthenticated
```

### **3. FTPS サーバーのデプロイ (GCE or エンドポイント作成)**
```sh
gcloud compute instances create pjt-ftps-server \
  --zone=asia-northeast1-a \
  --machine-type=e2-micro \
  --subnet=pjt-vpc-b \
  --public-ip \
  --tags=allow-ftps
```

### **4. 動作確認テスト**
- `/ip-check` API で Cloud Run A の NAT-IP を確認
- FTPS にファイル転送テスト

---

### **確認すべき点**
❓ デプロイ手順はこの構成で問題ないか？  
❓ 追加したい手順や設定はあるか？  




了解！ステップバイステップで進めましょう。  
**順番としては以下の流れが良さそうです。**

### **1. 準備フェーズ**
✅ `config.json` のサンプル作成  
✅ `requirements.txt` の作成  

### **2. ネットワークリソース作成**
✅ **VPC, Cloud Router, Cloud NAT, Firewall ルールの作成**（シェルスクリプトで自動化）

### **3. アプリケーション実装**
✅ `main.py` の作成（Cloud Run A のエントリーポイント）  

### **4. デプロイ**
✅ `main.py` を Cloud Run にデプロイするシェルスクリプトを作成  

---

まず **1. 準備フェーズ** から進めます。  
最初に `config.json` と `requirements.txt` を作成していきますね。  
進めて問題なければ **OK** と教えてください！



＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠

### **ステップ 1: 準備フェーズ**  
まずは **`config.json`** と **`requirements.txt`** を作成します。

---

### **① `config.json`（サンプル）**
このファイルは **Cloud Run A の環境設定を一元管理** するためのものです。

{
  "gcp_project": "pjt-gcp",
  "gcs_bucket": "pjt-cra-bucket",
  "gcs_trigger_folder": "input-csv/",
  "cloud_run": {
    "service_name": "pjt-cra-file",
    "region": "asia-northeast1",
    "ip_check_endpoint": "/ip-check"
  },
  "network": {
    "vpc_a_name": "pjt-vpc-a",
    "vpc_b_name": "pjt-vpc-b",
    "vpc_connector": "pjt-vpc-connector",
    "cloud_router": "pjt-cloud-router",
    "cloud_nat": "pjt-cloud-nat",
    "nat_ip": "35.200.XXX.XXX",
    "private_subnet": "10.128.0.0/20"
  },
  "ftps": {
    "server_ip": "34.85.XXX.XXX",  // deploy_ftps.sh で取得した外部 IP に変更
    "port": 21,
    "passive_ports": "50000-51000",
    "username": "ftps_user",
    "password": "securepassword",
    "upload_path": "/ftps-data/",
    "protocol": "FTPS",
    "mode": "passive"
  },
  "encoding": {
    "source_charset": "utf-8",
    "target_charset": "shift_jis"
  },
  "logging": {
    "pubsub_topic": "pjt-cra-log"
  }
}

```

🔹 **設定内容**
- GCS バケット (`pjt-cra-bucket`) の `input-csv/` にファイルが入ると発火
- Cloud Run A (`pjt-cra-file`) のデプロイ情報
- ネットワーク (`VPC`, `Cloud NAT`, `Router`, `NAT-IP`)
- FTPS (`サーバー情報`, `ポート`, `認証情報`)
- **今後変更する可能性があるパラメータを `config.json` で管理**

---

### **② `requirements.txt`**
Cloud Run A で必要な Python ライブラリをまとめた `requirements.txt` を作成。

```txt
flask
google-cloud-storage
ftplib
requests
```

🔹 **含まれるライブラリ**
- `flask`: API 実装用（Cloud Run A のエントリーポイント）
- `google-cloud-storage`: GCS からファイルを取得
- `ftplib`: FTPS にファイルをアップロード
- `requests`: IP 確認のための HTTP リクエスト処理

---

### **次のステップ**
✅ `config.json` と `requirements.txt` を作成しました！  
次は **ネットワークリソースの作成スクリプト（シェル）** を書きます。  

🔹 **ネットワーク作成の流れ**
1. VPC A, VPC B を作成
2. Cloud Router, Cloud NAT, NAT-IP を設定
3. VPC コネクタを作成
4. Firewall ルールを適用

進めて OK なら **OK** と教えてください！

### **ステップ 2: ネットワークリソース作成スクリプト**
Cloud Run A と FTPS サーバー B のネットワーク環境を **シェルスクリプトで作成** します。  
このスクリプトを実行することで、**VPC・Cloud Router・Cloud NAT・NAT IP・ファイアウォール** のセットアップが完了します。

---

### **① `setup_network.sh`（ネットワーク作成スクリプト）**
```sh
#!/bin/bash

# プロジェクト ID
GCP_PROJECT="pjt-gcp"
REGION="asia-northeast1"

# VPC 設定
VPC_A="pjt-vpc-a"   # Cloud Run A 用
VPC_B="pjt-vpc-b"   # FTPS サーバー用
SUBNET_A="pjt-subnet-a"
SUBNET_B="pjt-subnet-b"
SUBNET_A_RANGE="10.128.0.0/20"
SUBNET_B_RANGE="10.130.0.0/20"

# Cloud Router / NAT
CLOUD_ROUTER="pjt-cloud-router"
CLOUD_NAT="pjt-cloud-nat"
NAT_IP_NAME="pjt-nat-ip"

# VPC コネクタ
VPC_CONNECTOR="pjt-vpc-connector"

# 1. VPC の作成
gcloud compute networks create $VPC_A --subnet-mode=custom --bgp-routing-mode=regional
gcloud compute networks create $VPC_B --subnet-mode=custom --bgp-routing-mode=regional

# 2. サブネットの作成
gcloud compute networks subnets create $SUBNET_A \
  --network=$VPC_A \
  --range=$SUBNET_A_RANGE \
  --region=$REGION

gcloud compute networks subnets create $SUBNET_B \
  --network=$VPC_B \
  --range=$SUBNET_B_RANGE \
  --region=$REGION

# 3. Cloud Router の作成
gcloud compute routers create $CLOUD_ROUTER \
  --network=$VPC_A \
  --region=$REGION

# 4. Cloud NAT の作成
gcloud compute addresses create $NAT_IP_NAME \
  --region=$REGION \
  --addresses \
  --network-tier=PREMIUM

NAT_IP=$(gcloud compute addresses describe $NAT_IP_NAME --region=$REGION --format="get(address)")

gcloud compute routers nats create $CLOUD_NAT \
  --router=$CLOUD_ROUTER \
  --region=$REGION \
  --nat-external-ip-pool=$NAT_IP \
  --nat-all-subnet-ip-ranges

# 5. VPC コネクタの作成
gcloud compute networks vpc-access connectors create $VPC_CONNECTOR \
  --network=$VPC_A \
  --region=$REGION \
  --range="10.129.0.0/28"

# 6. ファイアウォールルールの作成（Cloud Run A → FTPS サーバーの通信許可）
gcloud compute firewall-rules create pjt-fw-cra-to-ftps \
  --network=$VPC_B \
  --allow=tcp:21,tcp:50000-51000 \
  --source-ranges=$NAT_IP \
  --target-tags=allow-ftps \
  --direction=INGRESS

echo "✅ ネットワーク構成の作成が完了しました！"
```

---

### **② スクリプトの説明**
- **VPC A (pjt-vpc-a)**: Cloud Run A 用（Cloud NAT を通じて固定IPを持つ）
- **VPC B (pjt-vpc-b)**: FTPS サーバー用
- **Cloud Router + Cloud NAT**: VPC A からの **外部通信を固定IP (NAT IP) にする**
- **Firewall ルール**:
  - **Cloud Run A の固定IP (NAT IP) だけを許可**
  - **FTPS サーバーの 21, 50000-51000 (PASV) を開放**

---

### **③ 実行手順**
1. スクリプトを保存  
   ```sh
   nano setup_network.sh
   ```
   → コードを貼り付けて保存 (`Ctrl + X` → `Y` → `Enter`)

2. 実行権限を付与  
   ```sh
   chmod +x setup_network.sh
   ```

3. スクリプトを実行  
   ```sh
   ./setup_network.sh
   ```

---

### **次のステップ**
✅ ネットワーク作成スクリプト (`setup_network.sh`) を作成しました！  
次は **Cloud Run A の `main.py` (エントリーポイント)** を作成します。  

進めて OK なら **OK** と教えてください！


＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠

### **ステップ 3: Cloud Run A のエントリーポイント (`main.py`) 作成**
Cloud Run A は **GCS の `input-csv/` にファイルがアップロードされると発火し、FTPS サーバーへ転送** するアプリです。  

---

### **① `main.py`（Cloud Run A のメイン処理）**
```python
import os
import json
import logging
from flask import Flask, request, jsonify
from google.cloud import storage
from ftplib import FTP_TLS

# ログ設定
logging.basicConfig(level=logging.INFO)

# Flask アプリ作成
app = Flask(__name__)

# 設定ファイル読み込み
CONFIG_PATH = "config.json"
with open(CONFIG_PATH, "r") as f:
    config = json.load(f)

GCS_BUCKET = config["gcs_bucket"]
GCS_TRIGGER_FOLDER = config["gcs_trigger_folder"]
FTPS_CONFIG = config["ftps"]
ENCODING_CONFIG = config["encoding"]

# GCS クライアント
storage_client = storage.Client()

@app.route("/", methods=["GET"])
def home():
    return "Cloud Run A is running!", 200

@app.route("/ip-check", methods=["GET"])
def ip_check():
    """Cloud Run A の外部IPを確認するための API"""
    import requests
    ip = requests.get("https://ifconfig.me").text
    return jsonify({"external_ip": ip})

@app.route("/gcs-event", methods=["POST"])
def gcs_event():
    """Eventarc 経由で GCS のアップロードイベントを受け取る"""
    data = request.get_json()
    
    if not data or "name" not in data:
        logging.error("Invalid GCS event data")
        return jsonify({"error": "Invalid event data"}), 400
    
    file_name = data["name"]
    
    # 指定フォルダ以外は無視
    if not file_name.startswith(GCS_TRIGGER_FOLDER):
        logging.info(f"Skipping file: {file_name}")
        return jsonify({"message": "File ignored"}), 200

    logging.info(f"Processing file: {file_name}")
    
    # GCS からファイル取得
    temp_file = f"/tmp/{file_name.split('/')[-1]}"
    download_gcs_file(GCS_BUCKET, file_name, temp_file)
    
    # 文字コード変換（UTF-8 → Shift_JIS）
    converted_file = convert_encoding(temp_file, ENCODING_CONFIG["source_charset"], ENCODING_CONFIG["target_charset"])
    
    # FTPS へ転送
    upload_to_ftps(converted_file, file_name)

    return jsonify({"message": "File processed"}), 200

def download_gcs_file(bucket_name, file_name, local_path):
    """GCS からファイルをダウンロード"""
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob.download_to_filename(local_path)
    logging.info(f"Downloaded {file_name} to {local_path}")

def convert_encoding(input_file, source_encoding, target_encoding):
    """ファイルの文字コード変換"""
    output_file = f"{input_file}.converted"
    with open(input_file, "r", encoding=source_encoding) as src, open(output_file, "w", encoding=target_encoding) as dest:
        dest.write(src.read())
    logging.info(f"Converted {input_file} from {source_encoding} to {target_encoding}")
    return output_file

def upload_to_ftps(file_path, remote_name):
    """FTPS サーバーへファイルをアップロード"""
    logging.info(f"Connecting to FTPS: {FTPS_CONFIG['server_ip']}")
    ftps = FTP_TLS()
    ftps.connect(FTPS_CONFIG["server_ip"], FTPS_CONFIG["port"])
    ftps.login(FTPS_CONFIG["username"], FTPS_CONFIG["password"])
    ftps.prot_p()  # PASV モード
    with open(file_path, "rb") as f:
        ftps.storbinary(f"STOR {FTPS_CONFIG['upload_path']}/{remote_name}", f)
    ftps.quit()
    logging.info(f"Uploaded {file_path} to FTPS")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
```

---

### **② `main.py` の動作**
- `GET /` → Cloud Run A が動作中か確認
- `GET /ip-check` → Cloud Run A の **外部IP を確認**
- `POST /gcs-event` → Eventarc からの **GCS アップロード通知を処理**
  - 指定フォルダのファイルを **ダウンロード**
  - **UTF-8 → Shift_JIS に変換**
  - **FTPS にアップロード**

---

### **次のステップ**
✅ `main.py`（Cloud Run A のメイン処理）を作成しました！  
次は **Cloud Run A のデプロイをシェルスクリプトで作成** します。  

進めて OK なら **OK** と教えてください！

＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠

### **ステップ 4: Cloud Run A のデプロイスクリプト**
Cloud Run A (`main.py`) を GCP にデプロイする **シェルスクリプト** を作成します。

---

### **① `deploy_cra.sh`（Cloud Run A デプロイ用スクリプト）**
```sh
#!/bin/bash

# プロジェクト ID
GCP_PROJECT="pjt-gcp"
REGION="asia-northeast1"
SERVICE_NAME="pjt-cra-file"
VPC_CONNECTOR="pjt-vpc-connector"

# Cloud Run にデプロイ
gcloud run deploy $SERVICE_NAME \
  --source . \
  --project $GCP_PROJECT \
  --region $REGION \
  --vpc-connector $VPC_CONNECTOR \
  --egress all \
  --allow-unauthenticated

echo "✅ Cloud Run A ($SERVICE_NAME) のデプロイが完了しました！"
```

---

### **② スクリプトの説明**
- **Cloud Run A (`pjt-cra-file`) を GCP にデプロイ**
- **VPC コネクタ (`pjt-vpc-connector`) を適用し、VPC 内で動作**
- **外部との通信を許可 (`--egress all`)**
- **認証なしでアクセス可能に (`--allow-unauthenticated`)**

---

### **③ 実行手順**
1. **スクリプトを作成**
   ```sh
   nano deploy_cra.sh
   ```
   → コードを貼り付けて保存 (`Ctrl + X` → `Y` → `Enter`)

2. **実行権限を付与**
   ```sh
   chmod +x deploy_cra.sh
   ```

3. **Cloud Run A をデプロイ**
   ```sh
   ./deploy_cra.sh
   ```

---

### **次のステップ**
✅ **Cloud Run A のデプロイスクリプトを作成しました！**  
次は **テスト（動作確認）** のスクリプトを作成します。  

進めて OK なら **OK** と教えてください！

＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠

### **ステップ 5: Cloud Run A のテストスクリプト**
Cloud Run A (`pjt-cra-file`) が正しく動作するか確認する **シェルスクリプト** を作成します。

---

### **① `test_cra.sh`（Cloud Run A の動作確認スクリプト）**
```sh
#!/bin/bash

# プロジェクト ID & サービス名
GCP_PROJECT="pjt-gcp"
REGION="asia-northeast1"
SERVICE_NAME="pjt-cra-file"

# Cloud Run の URL 取得
CLOUD_RUN_URL=$(gcloud run services describe $SERVICE_NAME --region=$REGION --format='value(status.url)')

# Cloud Run A の動作確認
echo "🔍 Cloud Run A のステータス確認: $CLOUD_RUN_URL"
curl -X GET "$CLOUD_RUN_URL/"

# Cloud Run A の外部IP確認
echo "🔍 Cloud Run A の外部IPを確認"
curl -X GET "$CLOUD_RUN_URL/ip-check"

# GCS のサンプルイベント送信
echo "🔍 GCS イベントのテスト"
curl -X POST "$CLOUD_RUN_URL/gcs-event" -H "Content-Type: application/json" -d '{
  "name": "input-csv/test_file.csv"
}'

echo "✅ Cloud Run A のテスト完了！"
```

---

### **② スクリプトの説明**
1. **Cloud Run A (`pjt-cra-file`) の URL を取得**
2. **`GET /` で Cloud Run A が稼働しているか確認**
3. **`GET /ip-check` で Cloud Run A の外部IPを取得**
4. **`POST /gcs-event` で GCS にファイルがアップロードされたと仮定して Eventarc の処理をテスト**

---

### **③ 実行手順**
1. **スクリプトを作成**
   ```sh
   nano test_cra.sh
   ```
   → コードを貼り付けて保存 (`Ctrl + X` → `Y` → `Enter`)

2. **実行権限を付与**
   ```sh
   chmod +x test_cra.sh
   ```

3. **Cloud Run A をテスト**
   ```sh
   ./test_cra.sh
   ```

---

### **次のステップ**
✅ **Cloud Run A のテストスクリプトを作成しました！**  
次は **FTPS サーバー（B）のデプロイスクリプト** を作成します。  

進めて OK なら **OK** と教えてください！

＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠
### **ステップ 6: FTPS サーバー（B）のデプロイスクリプト**
FTPS サーバー (`pjt-ftps-server`) を **GCE（Google Compute Engine）にデプロイ** するための **シェルスクリプト** を作成します。

---

### **① `deploy_ftps.sh`（FTPS サーバーのデプロイ用スクリプト）**
```sh
#!/bin/bash

# プロジェクト ID & リージョン
GCP_PROJECT="pjt-gcp"
REGION="asia-northeast1"
ZONE="asia-northeast1-a"

# FTPS サーバーの設定
INSTANCE_NAME="pjt-ftps-server"
MACHINE_TYPE="e2-micro"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
SUBNET="pjt-vpc-b"

# ファイアウォールルール
FW_RULE="pjt-fw-ftps"

# FTPS サーバーのデプロイ
echo "🚀 FTPS サーバーをデプロイ中..."
gcloud compute instances create $INSTANCE_NAME \
  --project=$GCP_PROJECT \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --subnet=$SUBNET \
  --tags=allow-ftps \
  --image-family=$IMAGE_FAMILY \
  --image-project=$IMAGE_PROJECT \
  --boot-disk-size=10GB \
  --metadata=startup-script="#!/bin/bash
    apt update -y && apt install -y vsftpd
    systemctl enable vsftpd
    systemctl start vsftpd
  "

# 外部IPの取得
FTPS_IP=$(gcloud compute instances describe $INSTANCE_NAME --zone=$ZONE --format="get(networkInterfaces[0].accessConfigs[0].natIP)")

echo "✅ FTPS サーバーのデプロイ完了！"
echo "🌍 外部 IP: $FTPS_IP"

# ファイアウォールルールの作成（Cloud Run A の固定IPのみ許可）
echo "🚀 ファイアウォールルールを作成..."
gcloud compute firewall-rules create $FW_RULE \
  --network=$SUBNET \
  --allow=tcp:21,tcp:50000-51000 \
  --source-ranges=35.200.XXX.XXX \
  --target-tags=allow-ftps \
  --direction=INGRESS

echo "✅ FTPS サーバーのセットアップ完了！"
```

---

### **② スクリプトの説明**
- **GCE インスタンス (`pjt-ftps-server`) をデプロイ**
  - `e2-micro`（無料枠対応）・`Debian 11`
  - **`vsftpd` を自動インストール & 起動**
- **外部IP を取得**
- **Cloud Run A の固定IP (`35.200.XXX.XXX`) のみ通信を許可**
  - `21/tcp`（FTPS 制御用）
  - `50000-51000/tcp`（PASV データ転送用）

---

### **③ 実行手順**
1. **スクリプトを作成**
   ```sh
   nano deploy_ftps.sh
   ```
   → コードを貼り付けて保存 (`Ctrl + X` → `Y` → `Enter`)

2. **実行権限を付与**
   ```sh
   chmod +x deploy_ftps.sh
   ```

3. **FTPS サーバーをデプロイ**
   ```sh
   ./deploy_ftps.sh
   ```

---

### **次のステップ**
✅ **FTPS サーバー（B）のデプロイスクリプトを作成しました！**  
次は **FTPS サーバーのテスト（接続確認 & ファイルアップロード）スクリプト** を作成します。  

進めて OK なら **OK** と教えてください！

＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠

### **ステップ 7: FTPS サーバーのテストスクリプト**
FTPS サーバー (`pjt-ftps-server`) が正しく動作するか確認する **シェルスクリプト** を作成します。

---

### **① `test_ftps.sh`（FTPS 接続 & ファイルアップロード確認スクリプト）**
```sh
#!/bin/bash

# FTPS サーバーの情報
FTPS_SERVER="34.85.XXX.XXX"  # deploy_ftps.sh で取得した外部IPに変更
FTPS_USER="ftps_user"
FTPS_PASS="securepassword"
UPLOAD_FILE="test_upload.txt"
REMOTE_PATH="/ftps-data/test_upload.txt"

# 1. 確認用のテストファイル作成
echo "🚀 テスト用ファイルを作成中..."
echo "This is a test file for FTPS upload." > $UPLOAD_FILE

# 2. FTPS サーバーに接続してアップロード
echo "🚀 FTPS サーバーに接続..."
ftp -inv $FTPS_SERVER <<EOF
user $FTPS_USER $FTPS_PASS
binary
put $UPLOAD_FILE $REMOTE_PATH
bye
EOF

echo "✅ FTPS サーバーへのアップロードテスト完了！"
```

---

### **② スクリプトの説明**
1. **テスト用のファイル (`test_upload.txt`) を作成**
2. **FTPS サーバー (`pjt-ftps-server`) に接続**
3. **ファイルを `/ftps-data/` にアップロード**
4. **接続を終了**

---

### **③ 実行手順**
1. **スクリプトを作成**
   ```sh
   nano test_ftps.sh
   ```
   → コードを貼り付けて保存 (`Ctrl + X` → `Y` → `Enter`)

2. **実行権限を付与**
   ```sh
   chmod +x test_ftps.sh
   ```

3. **FTPS の動作テスト**
   ```sh
   ./test_ftps.sh
   ```

---

### **次のステップ**
✅ **FTPS サーバーのテストスクリプトを作成しました！**  
これで **Cloud Run A → FTPS の一連の動作確認** が可能になります。  

次に進めたい作業があれば教えてください！

＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠



固定IP予約
