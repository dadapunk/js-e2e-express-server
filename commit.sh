#!/bin/bash

# Ensure environment variables are set
if [ -z "$AZUREPAT" ] || [ -z "$AZUSERNAME" ] || [ -z "$AZUSER_EMAIL" ] || [ -z "$AZORG" ]; then
  echo "Error: AZUREPAT, AZUSERNAME, AZUSER_EMAIL, and AZORG environment variables must be set."
  exit 1
fi

echo "Cloning GitHub repository..."
git clone https://github.com/dadapunk/js-e2e-express-server.git
if [ $? -ne 0 ]; then
  echo "Failed to clone GitHub repository"
  exit 1
fi

cd js-e2e-express-server
rm -rf .git
cd ..

# Clone the Azure repository using PAT
GIT_CMD_REPOSITORY="https://$AZUSERNAME:$AZUREPAT@dev.azure.com/irep-tech/Github%20Integration%20test/_git/Github%20Integration%20test"
echo "Cloning Azure repository..."
git clone $GIT_CMD_REPOSITORY
if [ $? -ne 0 ]; then
  echo "Failed to clone Azure repository"
  exit 1
fi

# Copy files from GitHub repository to Azure repository
echo "Copying files..."
cp -r js-e2e-express-server/* "Github Integration test/"
if [ $? -ne 0 ]; then
  echo "Failed to copy files"
  exit 1
fi

# Change to the Azure repository directory
cd TestGitSync

# Configure Git user
echo "Configuring Git user..."
git config --global user.email "$AZUSER_EMAIL"
git config --global user.name "$AZUSERNAME"

# Add, commit, and push changes
echo "Adding files to Git..."
git add .
if [ $? -ne 0 ]; then
  echo "Failed to add files to Git"
  exit 1
fi

echo "Committing changes..."
git commit -m "sync from git to azure"
if [ $? -ne 0 ]; then
  echo "Failed to commit changes"
  exit 1
fi

echo "Pushing changes to Azure repository..."
git push
if [ $? -ne 0 ]; then
  echo "Failed to push changes"
  exit 1
fi

echo "Script completed successfully"