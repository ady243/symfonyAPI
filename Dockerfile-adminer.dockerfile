FROM alpine:latest

# Installation des dépendances
RUN apk --no-cache add \
    php7 \
    php7-fpm \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-json \
    php7-session \
    php7-mbstring \
    php7-gd \
    php7-opcache \
    php7-zip \
    nginx \
    supervisor

# Téléchargement d'Adminer
ENV ADMINER_VERSION 4.8.1
ADD https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php /var/www/adminer/index.php

# Configuration de Nginx
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Configuration de Supervisor
COPY supervisord.conf /etc/supervisord.conf

# Port d'écoute
EXPOSE 80

# Démarrage des services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]