# docker-php2
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

# 8回　PHPの環境構築／docker-composeで複数コンテナを一括で起動
https://harusite.net/20230305-docker-2/





# issue 1-01_docker-php2

# 基本手順
【Docker第8回】ハンズオン／PHPの環境構築／docker-composeで複数コンテナを一括で起動
https://harusite.net/20230305-docker-2/


## 起動手順サマリー

Dockerデスクトップを起動

コマンド
% cd tutorial_docker/docker-php2
% docker-compose up -d

確認
http://localhost:8888/

ログイン情報例
root
secret
---

## サンプルデータのダウンロード　→ インポート方法
MySQLのサンプルデータセットである「world」は、以下の手順でダウンロードできます。

MySQLの公式サイト（https://dev.mysql.com/doc/index-other.html）にアクセス
「Examples」のセクションを展開します。
「World Database」をクリックします。
ページ下部の「Download the world database script」をクリックして、zipファイルをダウンロードします。
ダウンロードしたzipファイルを展開し、world.sqlファイルを取得します。
ダウンロードしたworld.sqlファイルを使用して、MySQLサーバーにサンプルデータをインポートできます。以下のようなコマンドを使用できます。

---


# 開発が進んだらどうするかも考慮する

## ローカルの永続ストレージ
上記に保管されていれば特に新しいコンテナを作らなくてもOK
Dockerは永続化ストレージを利用することで、コンテナを停止してもデータが保持される
そのため、特に新しいコンテナイメージを作る必要はない。
ただし、新しいパッケージやライブラリを追加する場合など、コンテナイメージを更新する必要がある場合もある

コマンド
docker stop 0c946400dc5c 17769fe4650b 12290bc283e5 24677637f7e3

---
# コンテナIDの確認
$ docker ps

# コンテナを停止
$ docker stop CONTAINER ID 

---



## 現在動いている Docker 環境から新しいコンテナを作成する手順

Docker コンテナの現在の状態を確認
$ docker ps

現在のコンテナの情報をもとに、Docker イメージを作成
コンテナの ID や名前を使用して、次のコマンドを実行
$ docker commit [CONTAINER_ID] [NEW_IMAGE_NAME]
---


新しいイメージを使用して新しいコンテナを作成します。
$ docker run --name [NEW_CONTAINER_NAME] -p [HOST_PORT]:[CONTAINER_PORT] -d [NEW_IMAGE_NAME]

  [NEW_CONTAINER_NAME] は、新しいコンテナの名前を指定
  [HOST_PORT] は、Docker コンテナを公開するポートを指定
  [CONTAINER_PORT] は、Docker コンテナで公開されているポートを指定

---



# 構築が完了したら、ブログを更新する









