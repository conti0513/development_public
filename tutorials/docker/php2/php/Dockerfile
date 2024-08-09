FROM php:7.4-fpm

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
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
    mariadb-client \
    postgresql-client \
    sqlite3

# PHP拡張モジュールをインストール
RUN docker-php-ext-install pdo_mysql mysqli pdo_pgsql pdo_sqlite

# PHP-FPMの設定ファイルをコピー
COPY php.ini /usr/local/etc/php/

