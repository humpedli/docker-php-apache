FROM php:5.6-apache

RUN a2enmod rewrite headers expires
RUN docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql

RUN apt-get update -y && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev && \
    apt-get install -y --no-install-recommends libmagickwand-dev && \
	apt-get install -y libpng-dev zlib1g-dev     

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  &&  \
    docker-php-ext-install gd

RUN pecl install imagick-3.4.1

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-enable imagick

RUN echo 'LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %{X-Forwarded-For}i" combined-proxy' >>  /etc/apache2/apache2.conf 