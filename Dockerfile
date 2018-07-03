FROM php:5-apache

# install gd and imagick mcrypt system requirements
RUN apt-get update -y && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev && \
    apt-get install -y --no-install-recommends libmagickwand-dev && \
    apt-get install -y libmcrypt-dev && \
	apt-get install -y libpng-dev zlib1g-dev     
RUN pecl install imagick-3.4.3

# enable standart modules, like: rewrite, headers, expires
RUN a2enmod rewrite headers expires

# enable mysql support
RUN docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql

# enable gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  &&  \
    docker-php-ext-install -j$(nproc) gd

# enable iconv
RUN docker-php-ext-install -j$(nproc) iconv

# enable mcrypt
RUN docker-php-ext-install -j$(nproc) mcrypt

# enable imagick
RUN docker-php-ext-enable imagick

# enable mbstring
RUN docker-php-ext-install -j$(nproc) mbstring

# enable zip
RUN docker-php-ext-install -j$(nproc) zip

# add custom logformat to display proxied IP in access log
RUN echo 'LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %{X-Forwarded-For}i" combined-proxy' >>  /etc/apache2/apache2.conf 

# add docker user and group
RUN groupadd -g 999 docker
RUN useradd -u 111 -g 999 -d /dev/null -s /usr/sbin/nologin docker