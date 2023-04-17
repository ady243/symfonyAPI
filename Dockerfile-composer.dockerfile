FROM php:8.1-fpm-alpine

RUN apk add --no-cache \
    curl \
    icu-dev \
    libzip-dev \
    unzip \
    git \
    mariadb-client

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) \
    intl \
    opcache \
    pdo \
    pdo_mysql \
    zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/symfony

CMD composer install ; php -S 0.0.0.0:8000 -t public