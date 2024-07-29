AZUREPAT=$AZUREPAT
AZUSERNAME=$AZUSERNAME
AZUSER_EMAIL=$AZUSER_EMAIL
AZORG=$AZORG
git clone https://github.com/dadapunk/js-e2e-express-server
cd js-e2e-express-server
rm -rf .git

cd ..

GIT_CMD_REPOSITORY="https://irep-tech@dev.azure.com/irep-tech/Github%20Integration%20test/_git/Github%20Integration%20test"
git clone $GIT_CMD_REPOSITORY

cp -r testAzureDevops/* js-e2e-express-server/

cd js-e2e-express-server

git config --global user.email "$AZUSER_EMAIL"
git config --global user.name "$AZUSERNAME"

git add .
git commit -m "sync from git to azure"

git push