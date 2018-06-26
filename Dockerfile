FROM php:5.6-apache

RUN a2enmod rewrite
RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql