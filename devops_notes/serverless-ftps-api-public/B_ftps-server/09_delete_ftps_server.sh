{
  "ftps_server": {
    "host": "your.ftps.server",
    "port": 21,
    "username": "your_username",
    "password": "your_password",
    "protocol": "FTPS",
    "mode": "passive",
    "certificate": "/etc/ssl/certs/vsftpd.pem"
  },
  "users": [
    {
      "name": "your_username",
      "home": "/home/your_username",
      "permissions": "upload,download"
    }
  ]
}
#!/bin/bash
# FTPSサーバー削除スクリプト
