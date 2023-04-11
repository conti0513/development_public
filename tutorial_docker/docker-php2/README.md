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
## 開発が進んだらどうするかも考慮する
・永続化データでデータは保存される
・新しいパッケージやライブラリを追加する場合は、新たにイメージを作成するのが望ましい。

開発手順
https://harusite.net/20230305-docker-2/#toc14




＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
ここから下はMySQLの記事に掲載する
## サンプルデータのダウンロード　→ インポート方法
MySQLのサンプルデータセットである「world」は、以下の手順でダウンロードできます。

MySQLの公式サイト（https://dev.mysql.com/doc/index-other.html）にアクセス
「Examples」のセクションを展開します。
「World Database」をクリックします。
ページ下部の「Download the world database script」をクリックして、zipファイルをダウンロードします。
ダウンロードしたzipファイルを展開し、world.sqlファイルを取得します。
ダウンロードしたworld.sqlファイルを使用して、MySQLサーバーにサンプルデータをインポートできます。以下のようなコマンドを使用できます。

---


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
　




