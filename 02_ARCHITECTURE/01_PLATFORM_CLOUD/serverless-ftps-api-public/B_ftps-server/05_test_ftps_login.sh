#!/bin/bash
set -e

echo "🚀 lftp による FTPS ログイン確認中..."

HOST="localhost"
USER="ftpuser"
PASS="your_password"

lftp -u "$USER","$PASS" ftps://$HOST <<EOF
set ftp:ssl-force true
set ftp:ssl-protect-data true
set ftp:passive-mode true
ls
bye
EOF

