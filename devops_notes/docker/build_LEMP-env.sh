#!/bin/zsh

# create directories
mkdir -p docker-LEMP/{nginx,php/mysql,www/html,php/src}

# create files
touch docker-compose.yml
touch docker-LEMP/nginx/nginx.conf
touch docker-LEMP/php/Dockerfile docker-LEMP/php/php.ini
touch docker-LEMP/www/html/index.php

# write docker-compose.yml
cat <<EOT >> docker-compose.yml
version: '3'
services:
  nginx:
    image: nginx:latest
    ports:
      - 8080:80
    volumes:
      - ./docker-LEMP/nginx/nginx.conf:/etc/nginx/conf.d/default.conf
      - ./docker-LEMP/www/html:/var/www/html
    depends_on:
      - php
 
  php:
    build: ./docker-LEMP/php
    volumes:
      - ./docker-LEMP/www/html:/var/www/html
      - ./docker-LEMP/php/src:/var/www/src
    depends_on:
      - db
 
  db:
    image: mysql:latest
    ports:
      - 13306:3306
    volumes:
      - ./docker-LEMP/mysql/data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret
    # for m1 mac
    platform: linux/x86_64
 
  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8888:80
    depends_on:
      - db
EOT

# write nginx.conf
cat <<EOT >> docker-LEMP/nginx/nginx.conf
server {
    listen 80;
    server_name _;
 
    root  /var/www/html;
    index index.php index.html;
 
    access_log /var/log/nginx/access.log;
    error_log  /var/log/nginx/error.log;
 
    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }
 
    location ~ \.php$ {
        fastcgi_pass php:9000;
        fastcgi_index index.php;    
        fastcgi_param SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
        include       fastcgi_params;
    }
}
EOT

# write Dockerfile
cat <<EOT >> docker-LEMP/php/Dockerfile
FROM php:7.2-fpm
COPY php.ini /usr/local/etc/php/
VOLUME /var/www/html
VOLUME /var/www/src

# 開発ツールをインストール
RUN apt-get update && \\
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
    default-mysql-client
EOT

# write php.ini
cat <<EOT >> docker-LEMP/php/php.ini
date.timezone = "Asia/Tokyo"
EOT

# write index.php
echo "<?php phpinfo(); ?>" > docker-LEMP/www/html/index.php

# build and run containers
docker-compose up -d

