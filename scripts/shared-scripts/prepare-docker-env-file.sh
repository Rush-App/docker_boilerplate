#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Prompt for environment selection
read -p "Do you want to run in 'Prod' or 'Dev' environment? [P/d]: " environment
environment=${environment:-P}

# Set env file path based on environment selection
if [[ $environment =~ ^[Dd](ev)*$ ]]; then
    env_file="$PATH_TO_DOCKER_ENV_FILE.dev"
else
    env_file="$PATH_TO_DOCKER_ENV_FILE.prod"
fi

# Check if the file exists
if [ ! -f "$env_file" ]; then
  echo "$env_file does not exist. Creating it now."
  touch "$env_file"
fi

set_variable() {
  local key="$1"
  local value="$2"
  if grep -q "^$key=" "$env_file"; then
    current_value="$(grep "^$key=" "$env_file" | cut -d= -f2-)"
    if [ -z "$current_value" ]; then
      echo "Enter value for $key (without http:// or https:// prefix):"
      read value
      sed -i "s/^$key=.*/$key=$value/" "$env_file"
    fi
  else
    echo "Enter value for $key (without http:// or https:// prefix):"
    read value
    echo "$key=$value" >> "$env_file"
  fi
}

set_variable "BACKEND_DOMAIN_NAME"
set_variable "FRONTEND_DOMAIN_NAME"

# Set the APP_URL variable to the value of BACKEND_DOMAIN_NAME
APP_URL="$BACKEND_DOMAIN_NAME"
set_variable "APP_URL" "$APP_URL"

# Set the USER_FRONT_URL variable based on the value of FRONTEND_DOMAIN_NAME and the environment
if [[ $environment =~ ^[Pp](rod)*$ ]]; then
  USER_FRONT_URL="https://$FRONTEND_DOMAIN_NAME"
else
  USER_FRONT_URL="http://$FRONTEND_DOMAIN_NAME"
fi
set_variable "USER_FRONT_URL" "$USER_FRONT_URL"

if [[ $environment =~ ^[Pp](rod)*$ ]]; then
  set_variable "CERTBOT_EMAIL"
fi

# Check if .env file exists and is not empty
if [ -s "$PATH_TO_DOCKER_ENV_FILE" ]; then
  # Prompt the user to replace the .env file with the selected environment file
  read -p "Do you want to replace .env with $env_file? [y/N]: " confirm
  if [[ ! $confirm =~ ^[yY](es)*$ ]]; then
      cp "$env_file" "$PATH_TO_DOCKER_ENV_FILE"
  fi
else
  # Replace .env with the selected environment file
  cp "$env_file" "$PATH_TO_DOCKER_ENV_FILE"
fi
