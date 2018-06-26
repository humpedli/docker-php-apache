FROM php:5.6-apache

RUN a2enmod rewrite
RUN docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install -qq -y libgd-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip

RUN pecl install imagick-3.4.1 \
    && docker-php-ext-enable imagick