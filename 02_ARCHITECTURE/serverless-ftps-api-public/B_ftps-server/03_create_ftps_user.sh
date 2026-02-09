#!/bin/bash

# FTPユーザー作成スクリプト

FTP_USER="ftpuser"
FTP_PASS="your_password"

echo "👤 FTPユーザー [$FTP_USER] を作成中..."

# ユーザー追加（パスワード付き）
sudo useradd -m "$FTP_USER"
echo "$FTP_USER:$FTP_PASS" | sudo chpasswd

# ディレクトリ所有権とパーミッション設定
sudo mkdir -p /home/$FTP_USER/ftp/upload
sudo chown nobody:nogroup /home/$FTP_USER/ftp
sudo chmod a-w /home/$FTP_USER/ftp
sudo chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/upload

echo "✅ FTPユーザー [$FTP_USER] 作成完了"
#!/bin/bash
# FTPSユーザー作成スクリプト
