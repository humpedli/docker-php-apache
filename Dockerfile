FROM php:5.6-apache

RUN a2enmod rewrite
RUN docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql