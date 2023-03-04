# PHPの環境構築

## 参考URL
https://webukatu.com/wordpress/blog/13099/

## 構成
docker-php2
├── docker-compose.yml
├── nginx
│   └── nginx.conf
├── php
│   ├── Dockerfile
│   └── php.ini
├── mysql
│   └── data
└── www
    └── html
        └── index.php

## テストの状況
ほぼ上手くいった
PHPINFOがブラウザに表示されない
https://webukatu.com/wordpress/blog/13099/




################################################
以下はdocker-php環境で使用した手順
################################################

目次
Dockerによる環境構築
1.  Dockerのインストール
2.  ディレクトリ・ファイルの準備
3.  Dockerfileの作成
4.  docker-compose.ymlの作成
5.  index.phpの作成
6.  コンテナの起動
7.  動作確認

#### 環境情報
PC
・MacBookAir M1

Docker Desctop
・Ver

開発環境
・Apache
・PHP 

#### Dockerの構築フロー
 Dockerfile
 　自分で作る
 　Imageを自作するためのファイル

  ↓　build
 　 
 image
 　コンテナを起動する土台
 　DockerHubで公開されている

  ↓　run

 Container(コンテナ）
 　アプリケーションの実行環境
 　使い捨て可能
 　開始・停止・削除
---

#### Apacheとドキュメントルート
Apache
 Webサーバのソフトウェア
 Webブラウザのリクエストに応じて、ファイルをレスポンスで返す

ドキュメントルート
　外部に公開されたファイルが置かれたディレクトリ
　ドキュメントルートがアクセスの起点になる


#### 手順
Dockerアプリのインストール　別な手順で対応済み
表示するphpファイルなどのフォルダ作成
Dockerfilewo作成
Dockerfilekaraイメージを作成
コンテナ作成・起動

※Dockerfieleに書いておかないと、意図したファイルがひらけない

P1
FROM php:8.1.12-apache
COPY src; /var/www/html

 P2
 公式ドキュメントに
 ドキュメントルート
 　ポート
 が書いてあるのでその通りにやること

 Docker ーーー> PHP serach

 ---

一旦Dockerをストップする
docker-compose down




## 1.  Dockerのインストール
以前対応した手順

## 2.  ディレクトリ・ファイルの準備
今回の環境構築用に、ローカルPCの任意の場所にdocker-phpフォルダを作成

構成
---
docker-php
    ├── docker-compose.yml //ファイル
    ├── html               //フォルダ 一旦やめ
    ├──src                 //フォルダ
        └── index.php      //ファイル
    ├── mysql              //フォルダ
    └── php                //フォルダ
    ├── Dockerfile         //ファイル
    └── php.ini            //ファイル

※上記の通り、Documentrootにindex.phpを配置すること
※また、配置場所とdocker-compose.ymlの記載内容を合わせること

## 3.  Dockerfileの作成
---
FROM php:8.1.12-apache

RUN apt-get update && apt-get install -y libonig-dev && \

docker-php-ext-install pdo_mysql mysqli mbstring
---

前の記載
FROM php:8.1.12-apache
COPY src; /var/www/html
RUN apt-get update && apt-get install -y libonig-dev && \
docker-php-ext-install pdo_mysql mysqli mbstring
---


P Dockerfileとは？
Dockerイメージをビルドするためのテキストファイル
Dockerfile内に記述された手順に従って、Dockerイメージを自動的に作成することができる

p Dockerfileの構文
---
INSTRUCTION arguments
---

Dockerfileでは、Dockerイメージを構築するために必要な手順を指定することが可能
例えば、以下のような手順がある

FROM:       ベースとなるイメージを指定します。
RUN:        コマンドを実行します。
COPY:       ファイルやディレクトリをコピーします。
ADD:        ファイルやディレクトリを追加します。
EXPOSE:     コンテナが使用するポートを指定します。
CMD:        コンテナが起動したときに実行するコマンドを指定します。
ENTRYPOINT: コンテナが起動したときに実行するコマンドを指定します。

Dockerfileは、Dockerコマンドを使用してビルドされ、Dockerイメージが作成される
以下のコマンドでは、Dockerfileが存在するディレクトリへのパスと、イメージの名前を指定している
Dockerは、Dockerfileを解析し、イメージを自動的にビルドする


# 実行例
$ docker build -t <image_name> <path_to_Dockerfile>
---


## 4.  docker-compose.ymlの作成
---
version: '3'
services:

  #MySQL用コンテナ
  mysql:
    container_name: mysql
    image: mysql:5.7
    # for m1 mac
    platform: linux/x86_64

    # 要確認
    volumes:
      - ./mysql:/var/lib/mysq
    ports:
      - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=test
      - MYSQL_USER=test
      - MYSQL_PASSWORD=test
    build:
      context: ./
      dockerfile: Dockerfile
  #phpMyAdmin用コンテナ
  phpmyadmin:
    container_name: phpMyAdmin
    depends_on:
      - mysql
    image: phpmyadmin/phpmyadmin
    environment:
      PMA_HOST: mysql
    restart: always
    ports:
      - "0:80"
    build:
      context: ./
      dockerfile: Dockerfile
  #php用コンテナ
  php:
    container_name: php-apache
    build: ./php

    # 要確認
    volumes:
      - ./html:/var/www/html

    ports:
    # - 0:8080
      - "0:8080"
    depends_on:
      - mysql
    build:
      context: ./
      dockerfile: Dockerfile
---


P docker-compose.yml に以下を入れないとこける

# for m1 mac
platform: linux/x86_64

# ホスト側のポートは0にして自動でポートを割り当てる
# [ホスト側のポート番号]:[コンテナ側のポート番号]
services:
  app:
    image: example/app
    ports:
      - "0:80"
---

確認方法
docker-compose ps

---

 # volumes:    
 # <- Bind mount するディレクトリ。volume。docker run コマンドの-v/--volume に相当
 #  - "$PWD/app-server/src:/usr/src/app"
 # 参考URL https://qiita.com/mk-tool/items/1c7e4929055bb3b7aeda
# COPY ./hogehoge /tmp


## 5.  index.phpの作成
---
<?php
    print("Hello, World");
---

## 6.  コンテナの起動
$ cd docker-php
$ docker-compose up -d

# result
# 数分待った後、以下のメッセージが出れば、ビルド完了
:
:
Creating mysql ... done
Creating php-apache ... done
Creating phpMyAdmin ... done
---

# イメージの確認
$ docker images
REPOSITORY              TAG       IMAGE ID       CREATED              SIZE
docker-php_php          latest    2de314dfa2bc   About a minute ago   450MB
phpmyadmin/phpmyadmin   latest    2de314dfa2bc   About a minute ago   450MB
mysql                   5.7       a118b189427a   2 minutes ago        480MB
nginx                   latest    114aa6a9f203   2 days ago           135MB

$ docker ps



## 7.  動作確認

# 起動したdockerのポート番号を確認
$ docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED         STATUS         PORTS                             NAMES
7290240e5f0b   docker-php_php          "docker-php-entrypoi…"   2 minutes ago   Up 2 minutes   80/tcp, 0.0.0.0:32769->8080/tcp   php-apache
3f88839ba2d4   phpmyadmin/phpmyadmin   "docker-php-entrypoi…"   2 minutes ago   Up 2 minutes   0.0.0.0:32768->80/tcp             phpMyAdmin
a003deb936ae   mysql:5.7               "docker-php-entrypoi…"   2 minutes ago   Up 2 minutes   80/tcp, 0.0.0.0:3306->3306/tcp    mysql

# php-apache
curl http://localhost:32769/
curl: (52) Empty reply from server




# phpMyAdmin
$ curl http://localhost:32768/



# エラー対応

# 作業中のコンテナにシェルで入る
$ docker exec -it CONTAINER_ID bash

# sample

$ docker ps        
CONTAINER ID   IMAGE                   COMMAND                  CREATED         STATUS         PORTS                             NAMES
0f91d9d3adfc   docker-php_php          "docker-php-entrypoi…"   3 minutes ago   Up 3 minutes   80/tcp, 0.0.0.0:32771->8080/tcp   php-apache

$ docker exec -it 0f91d9d3adfc bash

# php -v
PHP 8.1.12 (cli) (built: Nov 15 2022 02:27:47) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.12, Copyright (c) Zend Technologies
---
PHPは起動している


# PHPが正常に起動しているかどうかを確認するために、以下のコマンドを実行
php -r 'echo "Hello, world!";'
正常起動している













# 注意点
コンテナは再利用可能なので、終わったら消す
どっかーデスクトップからでもいいし、コマンドからでもいい







# エラー対応

PHPの環境を構築するもブラウザからうまく見れない
http://localhost:8080 NG
http://localhost It Worksと出る。

curl locaohost
一緒

Local Hostは以下を見ている
/Library/WebServer/Documents/index.html.en

http://localhost/index.html

---


これで切り分け
https://www.udemy.com/course/webphpmysqldocker/learn/lecture/32559446#overview

うまくいかない
docker run -d -p 80:80 --name my-apach-php-app -v ${PWD}:/var/www/html php 7.2-apache
docker run -d -p 8081:80 --name my-apach-php-app -v ${PWD}:/var/www/html php 7.2-apache
docker run -d -p 8081:80 --name my-apach-php-app -v ${PWD}:/var/www/html php 7.3-apache


一旦破棄
docker stop my-apach-php-app
docker rm my-apach-php-app

確認
Zend Engine v4.2.1, Copyright (c) Zend Technologies
    with Zend OPcache v8.2.1, Copyright (c), by Zend Technologies
yoshi@y0513 docker-php % docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                        PORTS     NAMES
0d32c60be736   php       "docker-php-entrypoi…"   47 seconds ago   Exited (127) 46 seconds ago             my-apach-php-app

---



---
avast 止める
 docker-php % sudo lsof -i :80
COMMAND     PID USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
httpd     70586 root    4u  IPv6 0xe96e2e172423ddb5      0t0  TCP *:http (LISTEN)
httpd     70594 _www    4u  IPv6 0xe96e2e172423ddb5      0t0  TCP *:http (LISTEN)
com.avast 70624 root   70u  IPv4 0xe96e2e20c4e50a0d      0t0  TCP 192.168.10.103:59548->ams10-013.ff.avast.com:http (ESTABLISHED)
httpd     72272 _www    4u  IPv6 0xe96e2e172423ddb5      0t0  TCP *:http (LISTEN)
httpd     72275 _www    4u  IPv6 0xe96e2e172423ddb5      0t0  TCP *:http (LISTEN)
httpd     72276 _www    4u  IPv6 0xe96e2e172423ddb5      0t0  TCP *:http (LISTEN)
---


懸念点
ドッカーのポート
ローカルのポート
ファイルの場所
その辺。。。。



