#!/bin/sh

# have wsl 2 + ubuntu installed on windows already
# boot into ubuntu and execute this script

sudo apt update && sudo apt upgrade

sudo apt remove docker docker-engine docker.io containerd runc

sudo apt install --no-install-recommends apt-transport-https ca-certificates curl gnupg2

. /etc/os-release

curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc

echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

# choose a free groups id
# get used id's: getent group | cut -d: -f3 | grep -E '^[0-9]{4}' | sort -g
sudo groupmod -g 1001 docker

# prepare a shared directory
DOCKER_DIR=/mnt/wsl/shared-docker
mkdir -pm o=,ug=rwx "$DOCKER_DIR"
chgrp docker "$DOCKER_DIR"

# Configure dockerd to use the shared directory
echo "{ "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"] }" | sudo tee /etc/docker/daemon.json

# TODO: add to visudo
# %docker ALL=(ALL)  NOPASSWD: /usr/bin/dockerd

# TODO: add to .bashrc:
# . $HOME/bin/docker-service.sh Ubuntu
# copy 'docker-service.sh' to '$HOME/bin/docker-service.sh'
# make executable
