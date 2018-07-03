# docker-php-apache
PHP 5 docker container with apache

## Enabled modules:
- rewrite
- headers
- expires
- mysql 
- mysqli 
- pdo 
- pdo_mysql
- gd
- iconv
- mcrypt
- imagick
- mbstring
- zip

## Run with docker

```
docker run --name=web \
  --restart=always \
  -p 80:80 \
  -v <path_to_web>:/var/www/html \
  -v /etc/localtime:/etc/localtime:ro \
  -e APACHE_RUN_USER=#111 \
  -e APACHE_RUN_GROUP=#999 \
  -d humpedli/docker-php-apache
```


## Run with docker-compose

```
version: '3'
services:
  web:
    container_name: "apache-clancore"
    image: "humpedli/docker-php-apache"
    port:
      - "80:80"
    volumes: 
      - "<path_to_web>:/var/www/html"
      - "/etc/localtime:/etc/localtime:ro"
    environment:
      - "APACHE_RUN_USER=#111"
      - "APACHE_RUN_GROUP=#999"
    restart: "always"
```