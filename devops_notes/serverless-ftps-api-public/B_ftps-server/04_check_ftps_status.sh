#!/bin/bash

echo "📡 vsftpd サービスのステータス確認中..."

# vsftpd がインストールされているか確認
if ! command -v vsftpd &>/dev/null; then
    echo "❌ vsftpd がインストールされていません。"
    exit 1
fi

# サービスの状態を確認
sudo systemctl status vsftpd

# ポート21番が開いているか確認
echo "🔍 ポート21 (FTPS) の状態確認:"
sudo lsof -i :21

# SSL設定の確認
echo "🔐 vsftpd.conf の SSL 関連設定:"
grep -E 'ssl_enable|rsa_cert_file|rsa_private_key_file' /etc/vsftpd.conf

echo "✅ vsftpd ステータス確認完了"
#!/bin/bash
# FTPSサーバー状態確認スクリプト
