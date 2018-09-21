#!/bin/bash

# extracted from https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1
if which docker
then
    echo "docker is already installed."
    exit 1
fi

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
while ! sudo apt-key fingerprint 0EBFCD88 | grep "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
do
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
done
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update'
sudo apt-get install docker-ce
