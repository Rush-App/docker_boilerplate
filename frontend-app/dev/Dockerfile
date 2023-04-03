# Base image
FROM node:16.18.0-alpine

# Set working directory
WORKDIR /var/www/frontend

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy other files
COPY . .

SHELL ["/bin/bash", "-c"]

## Set the environment variables
#ENV PORT=4200
#ENV HOST=0.0.0.0

# Expose the default port for the Angular application
EXPOSE 4200

# Start the Angular development server with live reload
CMD ["npm", "run", "start", "--", "--host", "0.0.0.0", "--disable-host-check"]
