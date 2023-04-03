#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if frontend-app and backend-app directories exists, if not create it
if [ ! -d "$FRONTEND_APP_DIRECTORY" ]; then
    mkdir "$FRONTEND_APP_DIRECTORY"
fi
if [ ! -d "$BACKEND_APP_DIRECTORY" ]; then
    mkdir "$BACKEND_APP_DIRECTORY"
fi

# Check if frontend-app and backend-app directories are empty
if [ -z "$(find $FRONTEND_APP_DIRECTORY -maxdepth 0 -empty)" ]; then
    echo "Error: frontend-app directory not empty."
    exit 1
fi
if [ -z "$(find $BACKEND_APP_DIRECTORY -maxdepth 0 -empty)" ]; then
    echo "Error: backend-app directory not empty."
    exit 1
fi

# Run the container and clone the repository
docker run --rm -v "$FRONTEND_APP_DIRECTORY:/app" --workdir "/app" alpine/git clone https://github.com/Rush-App/angular_boilerplate.git "/app"

# Run the container and clone the repository
docker run --rm -v "$BACKEND_APP_DIRECTORY:/app" --workdir "/app" alpine/git clone https://github.com/Rush-App/laravel_boilerplate.git "/app"
