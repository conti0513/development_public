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
--

# GitHubのお掃除
# リモートでPR　→　マージ後に実施
git branch -d <feature-branch-name>




---
## 構築手順（手動）
build_LEMP-env.shを起動

$ bash build_LEMP-env.sh



==========

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





