FROM php:7.3.6-fpm-alpine3.9

RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache shadow
RUN apk add openrc --no-cache

RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

ENV DOCKERIZE_VERSION v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www

RUN usermod -u 1000 www-data

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_USER=1000

RUN rm -rf /var/www/html

COPY . /var/www

RUN composer install
RUN cp .env.example .env
RUN php artisan key:generate
RUN php artisan config:cache

RUN chown -R www-data:www-data /var/www

RUN ln -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
