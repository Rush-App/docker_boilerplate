#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status code

chmod +x shared-scripts/*.sh frontend-app/*.sh backend-app/*.sh

./shared-scripts/is-docker-installed.sh
./shared-scripts/clone-apps.sh
./shared-scripts/prepare-docker-env-file.sh
./backend-app/setup-app.sh
./backend-app/cache-clear.sh
./frontend-app/setup-app.sh
./shared-scripts/is-urls-in-hosts-file.sh

echo "The installation was successful. Now you can run the running.sh script"
