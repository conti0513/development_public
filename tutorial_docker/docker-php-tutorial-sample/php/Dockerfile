FROM php:8.0-fpm

RUN apt-get update &&     apt-get install -y git unzip libicu-dev libzip-dev &&     docker-php-ext-install pdo_mysql mysqli zip intl &&     pecl install xdebug &&     docker-php-ext-enable xdebug

COPY php.ini /usr/local/etc/php/
COPY src /var/www/html/
