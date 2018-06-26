FROM php:5.6-apache

RUN a2enmod rewrite
RUN docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends libmagickwand-dev && \
	apt-get install -y libpng-dev zlib1g-dev     

RUN pecl install imagick-3.4.1

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-enable imagick


