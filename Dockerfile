FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    git curl unzip libpq-dev postgresql-client \
    icu-dev oniguruma-dev

# PHP extensions
RUN docker-php-ext-configure intl \
 && docker-php-ext-install -j$(nproc) intl pdo_pgsql

# opcache
RUN docker-php-ext-install opcache

# composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# currently code is mounted via volume in docker-compose. use this to run inside container.
# RUN composer install --no-interaction --prefer-dist --no-dev

CMD ["php-fpm", "-F"]
