FROM php:7.2-fpm
COPY php.ini /usr/local/etc/php/
VOLUME /var/www/html
VOLUME /var/www/src

# 開発ツールをインストール
RUN apt-get update && \
apt-get install -y     git     curl     wget     unzip     zip     tar     gzip     bzip2     nano     vim     tree     telnet     net-tools     iputils-ping     dnsutils     default-mysql-client
