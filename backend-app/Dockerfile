FROM php:8.1-cli-buster

ARG USER_ID

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mbstring pdo pdo_pgsql pgsql zip intl redis pcntl

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y supervisor nano

RUN chmod -R 777 /tmp /var/tmp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

RUN adduser --uid ${USER_ID} --ingroup www-data developer --shell /bin/bash

WORKDIR /var/www/api

SHELL ["/bin/bash", "-c"]

CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
