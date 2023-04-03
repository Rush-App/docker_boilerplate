#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if running on Windows
if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win"* ]]; then
  HOSTS_FILE="C:\Windows\System32\drivers\etc\hosts"
else
  HOSTS_FILE="/etc/hosts"
fi

# Check if BACKEND_URL and FRONTEND_URL are set in .env file
if [ -f "$PATH_TO_DOCKER_ENV_FILE" ]; then
  source "$PATH_TO_DOCKER_ENV_FILE"
  if [[ -z "${BACKEND_URL}" || -z "${FRONTEND_URL}" ]]; then
    echo "ERROR: BACKEND_URL or FRONTEND_URL is not set in the .env file."
  fi
else
  echo "CRITICAL ERROR: .env file not found."
  echo "Please create a .env file with the necessary variables."
  exit 1
fi

# Check if backend URL is present in hosts file
if grep -q "$BACKEND_URL" "$HOSTS_FILE"; then
  echo "Backend URL already exists in hosts file."
else
  # Prompt the user if they want to add the backend URL to hosts file
  read -p "Do you want to add the backend URL to the hosts file? (Y/n) " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Adding backend URL to hosts file."
    echo "127.0.0.1 $BACKEND_URL" | sudo tee -a "$HOSTS_FILE" > /dev/null
  else
    echo "Please add the backend URL to the hosts file manually."
  fi
fi

# Check if frontend URL is present in hosts file
if grep -q "$FRONTEND_URL" "$HOSTS_FILE"; then
  echo "Frontend URL already exists in hosts file."
else
  # Prompt the user if they want to add the frontend URL to hosts file
  read -p "Do you want to add the frontend URL to the hosts file? (Y/n) " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Adding frontend URL to hosts file."
    echo "127.0.0.1 $FRONTEND_URL" | sudo tee -a "$HOSTS_FILE" > /dev/null
  else
    echo "Please add the frontend URL to the hosts file manually."
  fi
fi
