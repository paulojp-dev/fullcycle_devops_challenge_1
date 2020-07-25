FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache shadow

COPY . /var/www
WORKDIR /var/www

RUN rm -rf /var/www/html
RUN ln -s public html
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer
RUN usermod -u 1000 www-data

RUN composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan config:cache

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_USER=1000

ADD init.sh init.sh

EXPOSE 9000
ENTRYPOINT ["init", "php-fpm"]
