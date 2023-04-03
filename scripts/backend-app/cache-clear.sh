docker-compose run --rm backend-app sh -c "cd /var/www/api && php artisan cache:clear && php artisan config:cache && php artisan optimize"
