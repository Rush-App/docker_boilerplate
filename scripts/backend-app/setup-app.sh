docker-compose run --rm backend-app sh -c "\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    cd /var/www/api && \
    composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan cache:clear && php artisan config:cache && php artisan optimize
    php artisan migrate\
"


##!/bin/bash
#
#SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#source "$SCRIPT_DIR/constants.sh"
#
## Go to the backend-app directory
#cd "$BACKEND_APP_DIRECTORY"
#
## Run composer install
#docker run --rm -v "$(pwd):/app" composer install
#
## Copy .env.example to .env
#cp .env.example .env
#
## Generate the application key
#docker run --rm -v "$(pwd):/app" -w "/app" php:8.1-cli php artisan key:generate
#
## Run the database migrations
#docker-compose run --rm app php artisan migrate
