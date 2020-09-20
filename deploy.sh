#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/id_rsa # Allow read access to the private key
ssh-add .travis/id_rsa # Add the private key to SSH

git config --global push.default matching
git remote add deploy ssh://git@77.68.127.191/var/www/sites/docker-react
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying. # Change apps@
ssh git@77.68.127.191 <<EOF
  cd /var/www/sites/docker-react
  docker build -t mosimane/docker-react .
  docker stop $(docker ps -aq)
  docker run -p 80:80 mosimane/docker-react
EOF
