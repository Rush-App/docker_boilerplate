#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status code

chmod +x scripts/shared-scripts/*.sh

./scripts/shares-scripts/is-docker-installed.sh

./scripts/shares-scripts/is-app-directories-exists.sh

./scripts/shares-scripts/prepare-docker-env-file.sh

docker-compose up --build
