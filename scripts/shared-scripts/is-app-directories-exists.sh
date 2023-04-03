#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if frontend-app directory exists
if [ ! -d "$DOCKER_ROOT_DIRECTORY../frontend-app" ]; then
    echo "Error: frontend-app directory does not exist."
    exit 1
fi

# Check if backend-app directory exists
if [ ! -d "$DOCKER_ROOT_DIRECTORY../backend-app" ]; then
    echo "Error: backend-app directory does not exist."
    exit 1
fi
