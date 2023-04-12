# PATH
~/Development/development_public/tutorial_docker/README.md

# DIR構成
docker-php-tutorial-sample
├── README.md
├── docker-compose.yml
├── nginx
│   ├── Dockerfile
│   └── default.conf
├── php
│   ├── Dockerfile
│   ├── html
│   │   └── aaa.html
│   ├── php.ini
│   └── src
│       └── aaa.php
└── phpmyadmin
    └── Dockerfile

# Git URL
https://github.com/conti0513/development_public/tree/main/tutorial_docker



# 手順

## ファイルとディレクトリを作成
・workディレクトリに移動
・docker-php-tutorial-sampleディレクトリを作成する
・シェルで作成する
・シェル名：build_env_php-tutorial.sh
・README.mdを作成する
  $ vim README.md

・ディレクトリ構造を出力
  $ brew install tree
  $ tree .

  docker-php-tutorial-sampleディレクトリに移動する。
  必要なファイルを作成する。
---
.
├── README.md
├── docker-compose.yml
├── nginx
│   ├── Dockerfile
│   └── default.conf
├── php
│   ├── Dockerfile
│   ├── html
│   │   └── aaa.html
│   ├── php.ini
│   └── src
│       └── aaa.php
└── phpmyadmin
    └── Dockerfile
---

Dockerイメージをビルドする。
コンテナを起動する。
以上の手順をリスト形式で出力すると以下のようになります。

# 1. プロジェクト用ディレクトリを作成し、移動する
mkdir docker-php-tutorial-sample
cd docker-php-tutorial-sample

# 2. 必要なファイルとディレクトリを作成する
touch README.md
touch php.ini
mkdir nginx && touch nginx/default.conf
mkdir php && touch php/Dockerfile && mkdir php/html && echo "<?php phpinfo();" > php/html/aaa.html
mkdir phpmyadmin && touch phpmyadmin/Dockerfile

# 3. docker-compose.ymlを作成する
touch docker-compose.yml

# 4. Dockerイメージをビルドする
docker-compose build

# 5. コンテナを起動する
docker-compose up -d
---








