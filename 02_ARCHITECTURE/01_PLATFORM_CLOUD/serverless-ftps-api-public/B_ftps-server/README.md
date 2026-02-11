## 📘 `README.md` 提案: `B_ftps-server/`

```markdown
# B_ftps-server - 明示的 FTPS サーバ構築スクリプト群

このディレクトリは、GCP 上に明示的 FTPS（FTP over TLS）サーバを立ち上げるためのスクリプトと設定ファイルを提供します。Cloud Run や GCS などのサーバレス構成と組み合わせることで、B2B向けのファイル連携に適した安全な転送手段を実現できます。

---

## 🧩 構成概要

```mermaid
flowchart TD
  VM[GCE (Debianベース)] -->|vsftpd構築| FTPS
  FTPS -->|Explicit TLS| 外部サービス
```

- vsftpd + 自己署名証明書（openssl）
- Passiveモード：ポート 50000 固定
- SSL明示設定済み（AUTH TLS）

---

## 📂 ファイル構成

| ファイル名 | 説明 |
|------------|------|
| `01_create_ftps_server.sh` | GCEインスタンスの起動（vsftpd用） |
| `02_setup_ftps_env.sh` | vsftpdの構築・SSL設定 |
| `03_create_your_username.sh` | FTPユーザー作成スクリプト |
| `04_check_ftps_status.sh` | サーバ起動確認・SSL設定チェック |
| `05_test_ftps_login.sh` | lftpを使ったログインテスト |
| `09_delete_ftps_server.sh` | インスタンス削除用スクリプト |
| `config.json` | 接続情報などの設定ファイル（必要に応じて.gitignoreへ） |

---

## 🔧 使い方

### 1. GCEインスタンスの作成

```bash
bash 01_create_ftps_server.sh
```

### 2. サーバ構築 & SSL設定

```bash
bash 02_setup_ftps_env.sh
```

### 3. ユーザー作成

```bash
bash 03_create_your_username.sh
```

### 4. 接続確認

```bash
bash 05_test_ftps_login.sh
```

---

## ✅ 設定ポイント

- ポート: `21（制御）` + `50000（Passiveモードデータ転送）`
- 証明書: 自己署名（vsftpd-selfsigned.crt）
- 明示的FTPS: `pycurl.FTPSSL_ALL` + `USESSL_ALL`
- 利用ユーザー: `ftpuser`（例）/ パスワード：任意指定可能

---

## 💡 補足

- Cloud NAT 経由で Cloud Run から FTPS 接続を行う構成と連携可能
- ローカルテストにも利用可
- 商用での再利用を想定し、構成・ディレクトリ・設定を簡潔に保守可能

---

## 📚 関連フォルダ

- `A_cloudrun-api/` … FTPSと連携する Cloud Run API
- `C_vpc-networking/` … NAT/VPC Connector の構築スクリプト群

---

## 🏷️ ラベル

```
FTPS / vsftpd / GCE / Cloud NAT / AUTH TLS / pycurl / lftp / 明示的TLS
```

---

## 🔒 商用導入時の注意

- ポート `21` および `50000` のインバウンドを開放する必要あり
- 本番運用では Let's Encrypt などの実証済みSSL利用を推奨
- 管理者アカウントのパスワード取り扱いに注意
```

---
