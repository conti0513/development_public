#!/bin/bash

# FTPS 環境構築スクリプト
# インスタンス上で実行されることを想定

echo "🔧 パッケージをアップデート..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "📦 vsftpd（FTPS用FTPサーバー）をインストール..."
sudo apt-get install -y vsftpd openssl

echo "🔐 SSL証明書を作成（自己署名）..."
sudo openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/vsftpd-selfsigned.key \
  -out /etc/ssl/certs/vsftpd-selfsigned.crt \
  -subj "/C=JP/ST=Tokyo/L=Shibuya/O=TestOrg/OU=Dev/CN=localhost"

echo "🛠️ vsftpd 設定を更新..."
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

sudo tee /etc/vsftpd.conf > /dev/null <<EOF
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES

ssl_enable=YES
rsa_cert_file=/etc/ssl/certs/vsftpd-selfsigned.crt
rsa_private_key_file=/etc/ssl/private/vsftpd-selfsigned.key
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH

pasv_enable=YES
pasv_min_port=50000
pasv_max_port=50000

allow_writeable_chroot=YES
EOF

echo "📂 FTP用ユーザーディレクトリ作成..."
sudo mkdir -p /home/ftpuser/ftp/upload
sudo chown nobody:nogroup /home/ftpuser/ftp
sudo chmod a-w /home/ftpuser/ftp
sudo chown ftpuser:ftpuser /home/ftpuser/ftp/upload

echo "✅ vsftpd 設定完了！"
echo "⏯️ サービス再起動..."
sudo systemctl restart vsftpd
sudo systemctl enable vsftpd

echo "🎉 FTPS サーバー構築完了"
#!/bin/bash
# FTPS環境設定スクリプト
