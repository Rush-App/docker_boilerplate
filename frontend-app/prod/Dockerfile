# Base image
FROM node:16.18.0-alpine AS builder

# Set working directory
WORKDIR /builder

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy other files
COPY . .

# Build Angular app for production
RUN npm run build:ssr

FROM node:16.18.0-alpine

WORKDIR /var/www/frontend

COPY --from=builder /builder/dist/rushapp_boilerplate ./dist/rushapp_boilerplate

# Expose port
EXPOSE 4000

SHELL ["/bin/bash", "-c"]

# Start the app
CMD ["node", "dist/rushapp_boilerplate/server/main.js"]
