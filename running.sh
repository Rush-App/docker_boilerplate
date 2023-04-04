#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status code

chmod +x scripts/shared-scripts/*.sh scripts/backend-app/*.sh

./scripts/shared-scripts/is-docker-installed.sh

./scripts/shared-scripts/is-app-directories-exists.sh

./scripts/shared-scripts/prepare-docker-env-file.sh

./scripts/backend-app/cache-clear.sh

docker-compose up --build
