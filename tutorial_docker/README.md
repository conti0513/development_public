# PATH
~/Development/development_public/tutorial_docker/README.md

# DIR構成
tutorial_docker
 ├── README.md
 ├── docker-html-css
 ├── docker-php-only
 ├── docker-php2
 ├── docker-terraform
 ├── docker-php-tutorial-sample
 ├── other DIRs

# Git URL
https://github.com/conti0513/development_public/tree/main/tutorial_docker

# 概要
## work DIR      : docker-php2

## README.mdのパス:
~/Development/development_public/tutorial_docker/docker-php2/README.md


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

## ブログ記事
8回　PHPの環境構築／docker-composeで複数コンテナを一括で起動
https://harusite.net/20230305-docker-2/



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



## 構築手順（手動）

### ISSUE
issue 1-01_docker-php2

### 基本手順
【Docker第8回】ハンズオン／PHPの環境構築／docker-composeで複数コンテナを一括で起動
https://harusite.net/20230305-docker-2/

### 起動手順の概要

<<<<<<< 3-feature-tutorial_sql
## 起動手順サマリー
## 開発が進んだらどうするかも考慮する
・永続化データでデータは保存される
・新しいパッケージやライブラリを追加する場合は、新たにイメージを作成するのが望ましい。
=======
#### 起動
---
# 1. プロジェクト用ディレクトリを作成し、移動する
mkdir ~/work/docker-LEMP
cd docker-LEMP

# 2. 必要なファイルとディレクトリを作成する
>>>>>>> main

# 3. docker-compose.ymlを作成する
touch docker-compose.yml

# 4. Dockerイメージをビルドする
docker-compose build

# 5. コンテナを起動する
docker-compose up -d


# 6. 動作確認
# Nginx
curl http://localhost:8080

# phpmyadmin
curl http://localhost:8888

ID   root
PASS secret



# 7.動作確認に問題なければ、環境を削除

# Docker Compose で作成したすべてのコンテナを停止し、削除
# Docker Compose ファイルを格納しているディレクトリに移動
$cd docker-LEMP
$ docker-compose down
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
 

# 作成したディレクトリを削除
$ cd ../
$ rm -rf docker-LEMP

---


#### エラー対応
---
# ポート番号競合
・nginxが80番ポートを使用しようとしていますが、すでに他のプロセスが使用している場合、エラーとなる
・まず、docker-compose downコマンドで現在のDockerコンテナをすべて停止
・次にdocker ps -aコマンドですべてのDockerコンテナが停止されていることを確認

その後、ポート番号80を使用しているプロセスがあるかどうかを確認するために、以下のコマンドを実行してください。

# 不要なDockerコンテナがあれば削除する
docker-compose down

# 実行中のコンテナを停止
# その後に削除
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

# port 80　を利用しているプロセスをストップする
sudo lsof -i :80
sudo apachectl stop
sudo kill -9 <PID>

---



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


<<<<<<< 3-feature-tutorial_sql
docker-php2_nginx_1: WEBサーバー（nginx）
docker-php2_phpmyadmin_1: MySQLデータベース管理用Webアプリケーション（phpMyAdmin）
docker-php2_php_1: PHP-FPMで実行されるWebアプリケーション

以下をWEBサーバー（docker-php2_php_1:）に適用していく

APサーバーにログイン
docker exec -it <コンテナIDまたは名前> bash


## 手動でパッケージを一括インストール
apt-get update && apt-get install -y \
    vim \
    wget \
    curl \
    zip \
    unzip \
    git \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    supervisor \
    cron \
    nginx \
    mariadb-client \
    postgresql-client \
    sqlite3
ーーー

Dockerfileに記載してもOK

# インストール後の確認
ex)
dpkg --list | grep nginx

ーーー
良さげ





一括でDocker Stop
docker stop $(docker ps -aq)

全てのコンテナを削除
docker rm -f $(docker ps -aq)


起動後にインストールしたほうがいいかもね。

うまくいかない場合はPCの再起動でうまくいく場合あり。

何度か試してく。


ーーー

## データの永続化

1 Dockerボリュームを使用する方法
 Dockerボリュームを使用すると、コンテナ内のデータがDockerホストに格納されます。
以下は、MySQLデータをDockerボリュームに永続化するための手順です。

# データを保存するDockerボリュームを作成します。
docker volume create mydata

# ボリュームをマウントして、コンテナを起動します。
docker run -d --name myphpadmin -v mydata:/var/lib/mysql -p 8080:80 phpmyadmin/phpmyadmin

2 ホストマシンのディレクトリをマウントする方法
ホストマシンのディレクトリをマウントすると、コンテナ内のデータがホストマシンのディレクトリに保存されます
以下は、MySQLデータをホストマシンのディレクトリに永続化するための手順

# MySQLデータを保存するホストマシンのディレクトリを作成します。
mkdir /path/to/mysql/data

# docker run -d --name myphpadmin -v /path/to/mysql/data:/var/lib/mysql -p 8080:80 phpmyadmin/phpmyadmin

ーーー
今回は２を採用
docker-compose.ymlに記載済み

ーーー
一旦docker stop

docker stop $(docker ps -aq)

---
次にデータが永続化されているか検証します。

http://localhost:8888/index.php?route=/database/structure&db=world

ワールドデータベースに接続できていることがかくにんできました。

エラー
DB接続エラー
色々やったが、再起動したら一発で解消した。
コンテナ削除もした
この辺りを整理していく

今日は一旦ここまで。

ーーー



テーブル
　データの集まり
　表形式
　
=======

やりたいこと。

この環境をいつでも作れるように、スクリプト化する

　・ディレクトリと各種ファイル
　・アップデートなど
　・手順にまとめる
　・ブログにアップする（自分も使い回しできる）

========================================================



# 構築するDIR構成
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

# docker-compose.yml
version: '3'
services:
  nginx:
    image: nginx:latest
    ports:
      - 8080:80
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf
      - ./www/html:/var/www/html
    depends_on:
      - php
 
  php:
    build: ./php
    volumes:
      - ./www/html:/var/www/html
    depends_on:
      - db
 
  db:
    image: mysql:latest
    ports:
      - 13306:3306
    volumes:
      - ./mysql/data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret
    # for m1 mac
    platform: linux/x86_64
 
  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8888:80
    depends_on:
      - db

---

# nginx.conf
server {
    listen 80;
    server_name _;
 
    root  /var/www/html;
    index index.php index.html;
 
    access_log /var/log/nginx/access.log;
    error_log  /var/log/nginx/error.log;
 
    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }
 
    location ~ \.php$ {
        fastcgi_pass php:9000;
        fastcgi_index index.php;    
        fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include       fastcgi_params;
    }
}
---

# php.ini
date.timezone = "Asia/Tokyo"
---

# index.php
<?php
phpinfo();
---

# Dockerfile
FROM php:7.2-fpm
COPY php.ini /usr/local/etc/php/
VOLUME .docker-LEMP/php/src:/var/www/html
---

# 開発ツールをインストール
RUN apt-get update && \
apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    nano \
    vim \
    tree \
    telnet \
    net-tools \
    iputils-ping \
    dnsutils \
    default-mysql-client
---
>>>>>>> main









