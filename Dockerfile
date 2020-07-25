FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache shadow

WORKDIR /var/www

RUN rm -rf /var/www/html
RUN ln -s public html
RUN usermod -u 1000 www-data

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_USER=1000

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
