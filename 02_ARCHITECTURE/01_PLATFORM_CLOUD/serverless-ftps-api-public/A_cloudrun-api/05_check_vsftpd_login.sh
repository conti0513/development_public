#!/bin/bash
# FTPS サーバーへの手動ログインテスト（明示的FTPS）

HOST="localhost"
USER="ftpuser"
PASS="your_password"

echo "🚀 lftp による FTPS 接続テスト開始..."

lftp -u "$USER","$PASS" ftps://$HOST <<EOF
set ftp:ssl-force true
set ftp:ssl-protect-data true
set ftp:passive-mode true
ls
bye
EOF

