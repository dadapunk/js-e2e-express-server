#!/bin/bash

# Set environment variables
AZUREPAT=$AZUREPAT
AZUSERNAME=$AZUSERNAME
AZUSER_EMAIL=$AZUSER_EMAIL
AZORG=$AZORG

# Clone the GitHub repository
git clone https://github.com/dadapunk/js-e2e-express-server
cd js-e2e-express-server
rm -rf .git
cd ..

# Clone the Azure repository
GIT_CMD_REPOSITORY="https://irep-tech@dev.azure.com/irep-tech/Github%20Integration%20test/_git/Github%20Integration%20test"
git clone $GIT_CMD_REPOSITORY

# Copy files from GitHub repository to Azure repository
cp -r js-e2e-express-server/* Github\ Integration\ test/

# Change to the Azure repository directory
cd Github\ Integration\ test

# Configure Git user
git config --global user.email "$AZUSER_EMAIL"
git config --global user.name "$AZUSERNAME"

# Add, commit, and push changes
git add .
git commit -m "sync from git to azure"
git push