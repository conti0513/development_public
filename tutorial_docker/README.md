# このDIRについて

## PATH
~/Development/development_public/tutorial_docker

## DIR構成
tutorial_docker
 ├── README.md
 ├── docker-php-only
 ├── docker-php2
 ├── docker-terraform
 ├── other DIRs
 ├── build_LEMP-env.sh # 今回使用する環境構築用シェル
 ├── docker-LEMP       # 今回作成するDIR


## Git URL
https://github.com/conti0513/development_public/tree/main/tutorial_docker

## 手順ブログ記事
8回　PHPの環境構築／docker-composeで複数コンテナを一括で起動(適宜修正)
https://harusite.net/20230305-docker-2/



# LEMP DIRを作成する

## LEMP DIRで環境でできること
### 前提
・DockerをローカルPCにインストールしておく
・WORK-DIRを作成しておく（今回はtutorial_docker）

### Docker上でできること
・PHP（LEMP環境）で簡単なWEBアプリを開発する
  ※LEMP環境　Linux Nginx MySQL PHP

・PHPでコンソール上で動くプログラムを開発する
　ex) じゃんけんアプリやバッチファイルなど

・myphpadminでMySQLを使った開発をする
　ex) GUI上でRDBMSの開発が可能
　※RDBMS
　リレーショナル・データベース・マネジメント・システム
　Relational Database Management System
　関係データベースを管理するためのシステムのこと

---

## 環境構築手順

### docker-LEMPで構築する環境
・WEBサーバー　Nginx
・開発環境　　 PHP
・DB         myphpadmin
・OS         ubuntu

### docker-LEMP で構築するDIR構成
docker-LEMP/
├── docker-compose.yml
├── mysql/
│   └── data/
├── nginx/
│   └── nginx.conf
├── php/
│   ├── Dockerfile
│   ├── mysql/
│   └── src/
└── www/
    └── html/
        └── index.php



### ignoreするファイル
---
docker-LEMP/mysql/mysql
docker-LEMP/mysql/data
docker-LEMP/mysql/
docker-LEMP/php/src
docker-LEMP/php/mysql
---


### 構築手順
※開発が進んだ場合はどうなる？
・永続化データでデータは保存される
・新しいパッケージやライブラリを追加する場合は、新たにイメージを作成するのが望ましい


#### Git HubでISSUEを立てる（任意）
・ISSUEを立てる
・タスク内容に応じたブランチを作成する
・ローカルでブランチを移動する
git fetch origin
git checkout <feature_任意のブランチ名>

---



#### 起動


・手動で対応する場合は以下を実施
---
# 1. プロジェクト用ディレクトリを作成し、移動する

---
# 手動
$ mkdir ~/work/docker-LEMP
$ cd docker-LEMP

# 自動
# ワークディレクトリで以下のシェルを起動すれば、自動で環境構築可能
$ bash build_LEMP-env.sh 
Creating network "docker-lemp_default" with the default driver
Creating docker-lemp_db_1 ... done
Creating docker-lemp_php_1        ... done
Creating docker-lemp_phpmyadmin_1 ... done
Creating docker-lemp_nginx_1      ... done

$ ls -la
drwxr-xr-x   7 yoshi  staff    224 Apr 15 18:10 docker-LEMP
---

# 2. 必要なファイルとディレクトリを作成する
# 手動　手動で作成
# 自動　「build_LEMP-env.sh」で作成される
---

# 3. docker-compose.ymlを作成する
# 手動　手動で作成
$ touch docker-compose.yml

# 自動　「build_LEMP-env.sh」で作成される
---

# 4. Dockerイメージをビルドする
$ cd docker-LEMP 
$ docker-compose build

# 5. コンテナを起動する
$ docker-compose up -d
---


# 6. 動作確認
# Nginx
curl http://localhost:8080

# phpmyadmin
curl http://localhost:8888

ID   root
PASS secret
---

# インストール後の確認

---
ex)
# APサーバーのコンテナIDを確認
$ docker ps

# APサーバーにログイン
$ docker exec -it <コンテナIDまたは名前> bash
# dpkg --list | grep nginx

# reslt
ii  nginx                     1.23.4-1~bullseye              arm64        high performance web server
ii  nginx-module-geoip        1.23.4-1~bullseye              arm64        nginx GeoIP dynamic modules
ii  nginx-module-image-filter 1.23.4-1~bullseye              arm64        nginx image filter dynamic module
ii  nginx-module-njs          1.23.4+0.7.11-1~bullseye       arm64        nginx njs dynamic modules
ii  nginx-module-xslt         1.23.4-1~bullseye              arm64        nginx xslt dynamic module

---

# 7.動作確認に問題なければ、開発を実施

・開発中で作成したコード基本的に永続化される
・念の為のバックアップは以下のシェルを実行すればバックアップされる
　bkup_src.sh


# 8.GitHub上でPRをマージ・関連ブランチを削除・Issueをクローズ

■ GitHub上で以下の手順を実施
■■ GitHub上でPRをマージする場合
1) プルリクエストを開く
2) "Merge"ボタンをクリック
3) マージしたいベースブランチを選択
4) "Confirm merge"ボタンをクリック
5) マージが完了すると、マージされたコミットがベースブランチに反映される

■■ 関連するブランチを削除する手順
1) リポジトリのページを開く
2) Pull requestsタブをクリック
3) 削除したいブランチを選択
4) 右側の「Delete branch」をクリックする
5) 確認メッセージが出るので、Deleteをクリック
6) これでIssueがクローズされ、関連するブランチが削除される

■■ Issueをクローズ（一般的な方法）
1) Issueページを開く
2) 右側の「Close issue」をクリック
3) 確認メッセージが出るので、問題が解決された旨を記入して、Close issueをクリック
4) Issueをクローズしたら、そのIssueに関連するブランチを削除することができる
※GitHubの場合、ブランチ削除はPull Requestがマージされた後に行うことが推奨されている

【注意点】
・Issueをクローズする場合、問題が解決した旨を記入する代わりに、クローズ理由を簡潔に記述することが推奨される
・GitHubでは通常、ブランチを削除する前にリモートリポジトリからブランチを削除することが推奨されている
・これにより、ローカルリポジトリのブランチが不要になっても、リモートリポジトリに残らないようになる
---

■ ローカルで不要なブランチを削除する手順
# 1) 不要なブランチを確認
$ git branch

# 2) 削除したいブランチを選択し、以下のコマンドを実施
$ git branch -d <ブランチ名>

# 3) 削除されたことを確認
$ git branch 

【注意点】
・削除対象のブランチが現在チェックアウトされている場合は、-d オプションでは削除できないため、-D オプションを使用する必要がある
---


# 9.開発が終了したら、Dockerの環境をリセット

ーーー
# Docker Compose で作成したすべてのコンテナを停止し、削除

１　docker-compose down
 - Docker Composeで作成されたコンテナ・ネットワーク・ボリュームを削除

２　docker stop $(docker ps -aq)
 - 現在実行されている全てのコンテナを停止します。

３　docker rm -f $(docker ps -aq)
 - 停止した全てのコンテナを削除します。

これらのコマンドを実行することで、Dockerの環境をリセットできる
ただし、データボリュームを使用していて、再利用しない場合は、
docker volumeコマンドを使用してボリュームも削除する必要がある

これらのコマンドを実行すると、全てのコンテナやネットワーク、ボリュームが完全に削除される

# 作成したDIR(今回はdocker-LEMP)を削除
$ cd ../
$ rm -rf docker-LEMP
---


# 8.GitHubに


# 次回再開発したい場合
---
# 1 手動で環境を作成する、または環境構築用のシェルを起動する
　※　build_LEMP-env.sh

# 2. Dockerイメージをビルドする
docker-compose build

# 3. コンテナを起動する
docker-compose up -d


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

# DB接続エラー
色々やったが、再起動したら一発で解消した。
コンテナ削除もした
---





#### PHPの開発
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



## 手動でパッケージを一括インストール

---
# APサーバーにログイン
docker exec -it <コンテナIDまたは名前> bash

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




#### MySQLの開発
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


以下をWEBサーバー（docker-php2_php_1:）に適用していく



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
---


# 参考
# 開発したデータをローカルの別なDIRにバックアップするシェル
---
#!/bin/zsh

# コピー元とコピー先のパスをハードコードで指定する
## コピー元
src_dir=~/Development/development_public/tutorial_docker/docker-LEMP/php/src

## コピー先
dest_dir=~/Development/src/docker-LEMP/php/

# コピー元のファイルが存在しない場合はエラーを表示して終了する
if [ ! -d "$src_dir" ]; then
  echo "コピー元のディレクトリが存在しません。"
  exit 1
fi

# コピー先のファイルが存在する場合は、更新日時を比較して上書きするかどうかの確認をする
if [ -d "$dest_dir" ]; then
  src_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$src_dir")
  dest_mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$dest_dir")

  if [ "$src_mtime" != "$dest_mtime" ]; then
    read -p "コピー先のディレクトリはすでに存在します。上書きしますか？(Y/N): " confirm
    if [ "$confirm" != "Y" -a "$confirm" != "y" ]; then
      echo "コピーを中止しました。"
      exit 1
    fi
  fi
fi

# ディレクトリを再帰的にコピーする
cp -r "$src_dir" "$dest_dir"

# コピーが成功した場合に、メッセージを表示する
if [ $? -eq 0 ]; then
  echo "コピーが完了しました。"
fi



