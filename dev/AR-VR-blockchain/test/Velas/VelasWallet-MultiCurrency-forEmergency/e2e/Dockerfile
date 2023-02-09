# FROM mcr.microsoft.com/playwright

# COPY package*.json ./
# RUN npm ci --only=production
# COPY . .

FROM ubuntu:bionic

# Install node14
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Upgrade to NPM7 (see https://github.com/microsoft/playwright/pull/8915)
RUN npm install -g npm@7

# Feature-parity with node.js base images.
RUN apt-get update && apt-get install -y --no-install-recommends git ssh && \
    npm install -g yarn

# Create the pwuser (we internally create a symlink for the pwuser and the root user)
RUN adduser pwuser

COPY package*.json ./
RUN npm i
RUN npx playwright install chrome
COPY . .
