FROM php:7.2-fpm
COPY php.ini /usr/local/etc/php/

# ホストマシンのディレクトリをコンテナ内にマウントする
# ホストマシンのディレクトリ: .docker-php2/php/src
# コンテナ内のディレクトリ: /var/www/html
VOLUME .docker-php2/php/src:/var/www/html

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
        mysql-client
