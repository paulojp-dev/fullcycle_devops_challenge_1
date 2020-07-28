FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache shadow
RUN apk add openrc --no-cache

WORKDIR /var/www

RUN rm -rf /var/www/html

COPY . /var/www

RUN ln -s public html
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer
RUN usermod -u 1000 www-data

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_USER=1000

EXPOSE 9000
ENTRYPOINT ["/var/www/init.sh", "php-fpm"]
