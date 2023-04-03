FROM php:8.1-fpm-buster

ARG USER_ID

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mbstring pdo pdo_pgsql pgsql zip intl redis pcntl

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y nano

ENV TZ=Europe/Tallinn
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN adduser --uid ${USER_ID} --ingroup www-data developer --shell /bin/bash

USER developer

WORKDIR /var/www/api

SHELL ["/bin/bash", "-c"]

EXPOSE 9000
