#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if frontend-app directory exists
if [ ! -d "$FRONTEND_APP_DIRECTORY" ]; then
    echo "Error: frontend-app directory does not exist."
    exit 1
fi

# Check if backend-app directory exists
if [ ! -d "$BACKEND_APP_DIRECTORY" ]; then
    echo "Error: backend-app directory does not exist."
    exit 1
fi
