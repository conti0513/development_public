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