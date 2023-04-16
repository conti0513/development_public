# PATH
~/Development/development_public/tutorial_docker/README.md

# DIR構成
.tutorial_docker      # Dockerをインストールしたディレクトリ（任意）  
├── other DIRs        # その他のDIRs 本作業には無関係
├── build_LEMP-env.sh # 今回使用する環境構築用シェル
├── docker-LEMP       # 今回作成するDIR

# 概要
## Git URL       :
https://github.com/conti0513/development_public/tree/main/tutorial_docker


## 構築する環境    :
・WEBサーバー　Nginx
・開発環境　　 PHP
・DB         myphpadmin
・OS         ubuntu

## この環境でできること
・DockerをローカルPCにインストールし、Docker上で以下の操作ができる
・PHP（LEMP環境）で簡単なWEBアプリを開発する
  Linux
  Nginx
  MySQL
  PHP

・PHPでコンソール上で動くプログラムを開発する
　（じゃんけんアプリなど）
・myphpadminを使い、GUI上でMySQLの動作確認とSQLの実装


## 環境
### 構築するDIR構成
docker-LEMP
├── docker-compose.yml
├── nginx
│   └── nginx.conf
├── php
│   ├── Dockerfile
│   ├── php.ini
│   └── src
├── mysql
│   └── data
└── www
    └── html
        └── index.php

### ignoreするファイル
---
docker-LEMP/mysql/mysql
docker-LEMP/mysql/data
docker-LEMP/mysql/
docker-LEMP/php/src
---



## 構築手順
https://harusite.net/20230416-docker/



## PHPの開発
ここからは、PHPの開発について
---
# PHPが起動しているコンテナ（WebAPサーバー）にログイン
$ docker exec -it <phpが起動しているコンテナID> /bin/bash

---
# pwd
/var/www/html
root@53d7f3b11dd9:/var/www/html# ls -la
total 12
drwxr-xr-x 4 root root  128 Apr 12 11:39 .
drwxr-xr-x 3 root root 4096 Dec 11  2020 ..
-rw-r--r-- 1 root root   17 Apr  6 08:05 index.php
---
# ブラウジング確認
http://localhost:8080/index.php

---
### データの永続化について
・開発が進んでデータが増えた場合も、永続化データでデータは保存される
・新しいパッケージやライブラリを追加する場合は、新たにイメージを作成するのが望ましい。

# 開発手順
https://harusite.net/20230305-docker-2/#toc14
---

## MySQLの開発
---
# サンプルデータのダウンロード　→ インポート方法
MySQLのサンプルデータセットである「world」は、以下の手順でダウンロードできます。

MySQLの公式サイト（https://dev.mysql.com/doc/index-other.html）にアクセス
「Examples」のセクションを展開します。
「World Database」をクリックします。
ページ下部の「Download the world database script」をクリックして、zipファイルをダウンロードします。
ダウンロードしたzipファイルを展開し、world.sqlファイルを取得します。
ダウンロードしたworld.sqlファイルを使用して、MySQLサーバーにサンプルデータをインポートできます。以下のようなコマンドを使用できます。

---


