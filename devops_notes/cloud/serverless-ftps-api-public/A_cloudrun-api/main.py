import os
import logging
from flask import Flask, request
from google.cloud import storage
import pycurl
from io import BytesIO

# Cloud Runの環境変数を取得
FTPS_HOST = os.getenv("FTPS_HOST")
FTPS_PORT = int(os.getenv("FTPS_PORT", 21))
FTPS_USER = os.getenv("FTPS_USER")
FTPS_PASS = os.getenv("FTPS_PASS")
FTPS_DIR = os.getenv("FTPS_DIR", "/")
GCS_BUCKET = os.getenv("TRIGGER_BUCKET")

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

def list_ftps_files():
    buffer = BytesIO()
    curl = pycurl.Curl()
    try:
        curl.setopt(curl.URL, f"ftp://{FTPS_HOST}:{FTPS_PORT}{FTPS_DIR}")
        curl.setopt(curl.USERPWD, f"{FTPS_USER}:{FTPS_PASS}")
        curl.setopt(curl.SSL_VERIFYPEER, 0)
        curl.setopt(curl.SSL_VERIFYHOST, 0)
        curl.setopt(curl.FTP_SSL, pycurl.FTPSSL_ALL)  # 明示的にAUTH TLS使用
        curl.setopt(curl.USE_SSL, pycurl.USESSL_ALL)
        curl.setopt(curl.SSLVERSION, pycurl.SSLVERSION_TLSv1_2)
        curl.setopt(curl.FTP_FILEMETHOD, pycurl.FTPMETHOD_SINGLECWD)
        curl.setopt(curl.WRITEDATA, buffer)
        curl.perform()
        body = buffer.getvalue().decode("utf-8")
        return body.splitlines()
    except Exception as e:
        logging.error(f"❌ FTPSエラー: {e}")
        return []
    finally:
        curl.close()

def upload_file_to_ftps(local_path, remote_filename):
    curl = pycurl.Curl()
    try:
        curl.setopt(curl.URL, f"ftp://{FTPS_HOST}:{FTPS_PORT}{FTPS_DIR}{remote_filename}")
        curl.setopt(curl.USERPWD, f"{FTPS_USER}:{FTPS_PASS}")
        curl.setopt(curl.UPLOAD, 1)
        curl.setopt(curl.SSL_VERIFYPEER, 0)
        curl.setopt(curl.SSL_VERIFYHOST, 0)
        curl.setopt(curl.FTP_SSL, pycurl.FTPSSL_ALL)  # AUTH TLS を明示
        curl.setopt(curl.USE_SSL, pycurl.USESSL_ALL)
        curl.setopt(curl.SSLVERSION, pycurl.SSLVERSION_TLSv1_2)
        curl.setopt(curl.FTP_FILEMETHOD, pycurl.FTPMETHOD_SINGLECWD)
        with open(local_path, 'rb') as f:
            curl.setopt(curl.READDATA, f)
            curl.perform()
        logging.info(f"✅ アップロード成功: {remote_filename}")
    except Exception as e:
        logging.error(f"❌ アップロード失敗: {e}")
    finally:
        curl.close()

def download_gcs_file(bucket_name, blob_name, local_path):
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.download_to_filename(local_path)
    logging.info(f"✅ GCSからダウンロード: {blob_name} -> {local_path}")

@app.route("/", methods=["POST"])
def trigger():
    try:
        data = request.get_json()
        logging.info(f"📦 受信データ: {data}")
        gcs_file = data["name"]

        local_file = f"/tmp/{gcs_file}"
        download_gcs_file(GCS_BUCKET, gcs_file, local_file)
        upload_file_to_ftps(local_file, gcs_file)
        files = list_ftps_files()
        logging.info(f"✅ FTPS接続成功: {files}")
        return "Success", 200
    except Exception as e:
        logging.error(f"❌ Cloud Run エラー: {e}")
        return "Error", 500

@app.route("/ip-check")
def ip_check():
    import requests
    return requests.get("https://ifconfig.me").text

