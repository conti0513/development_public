# 構成
docker-php-only
├── index.php        # file
├── readme.txt       # file
└── data             # dir
    └── info.php     # file


# 構築手順

## 環境
M1 Mac

## Docker Desctopを事前にインストール

## 任意のDIRに以下の構成でディレクトリとファイルを作成

p 構成
docker-php-only
├── index.php        # file
├── readme.txt       # this file
└── data             # dir
    └── info.php     # file

## ファイルの内容
P index.php
---
echo "Hello, PHP on Docker!";
---

P info.php
---
<?php

phpinfo();

?>
---

## PHPのイメージを取得
$ docker pull php:7.1.29-apache

# 確認
$ docker images
REPOSITORY              TAG             IMAGE ID       CREATED        SIZE
php                     7.1.29-apache   9873db935da3   3 years ago    329MB
---


## PHPのコンテナを起動
$ docker run -p 4000:80 -v ${PWD}:/var/www/html -d php:7.1.29-apache

P コマンドの意味

PHPとApache Webサーバーを含むDockerコンテナを起動し、ホストマシンのポート番号4000でアクセスできるようにする
コンテナ内の /var/www/html ディレクトリを、ホストマシンの現在のディレクトリにマウントし、
コンテナ内のWebサーバーにアクセスするために必要なファイルをホストマシンから提供することができる

コマンドの詳細

# docker run: Dockerコンテナを実行
# -p 4000:80: コンテナのポート番号80を、ホストマシンのポート番号4000にマッピング
#             これにより、ホストマシンからコンテナ内のWebサーバーにアクセス可能になる
#             ホストマシンのポート番号：4000は任意のポートでOK
# -v ${PWD}:/var/www/html: コンテナの /var/www/html ディレクトリを、
                        ホストマシンの現在のディレクトリにマウント
                        これにより、ホストマシンからコンテナ内のファイルにアクセス可能になる
# -d: コンテナをバックグラウンドで実行
# php:7.1.29-apache: 使用するイメージの指定
                     この場合は、PHP 7.1.29 と Apache Webサーバーを含むDockerイメージを使用
---

## 動作確認

#　PHP infoのHTMLが表示される
$ curl http://localhost:4000//data/info.php

# index.phpが表示される
$ curl http://localhost:4000/index.php                              
echo "Hello, PHP on Docker!";

---

## コンテナを停止

# docker psでCONTAINER IDを確認
$ docker ps                                                         
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS                  NAMES
54c7623551fc   php:7.1.29-apache   "docker-php-entrypoi…"   2 minutes ago   Up 2 minutes   0.0.0.0:4000->80/tcp   silly_germain

# docker stopでコンテナを停止
$ docker stop 54c7623551fc

# 事後確認

$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
---
