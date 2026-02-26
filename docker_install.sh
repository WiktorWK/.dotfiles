#!/bin/bash

set -e

# installs docker engine and docker-compose following official instructions
printf "\n\n Remove old installations \n\n"

sudo apt-get remove docker docker.io docker-doc docker-compose podman-docker containerd runc

printf "\n\n Add Docker's official GPG key \n\n"

sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

printf "\n\n Add Docker's official GPG key \n\n"

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

printf "\n\n Adding current user to docker group.\n\n"

sudo usermod -aG docker $USER

printf "\n\n Enabling docker services.\n\n"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

printf "\n\n Log in again for the group changes to take effect.\n After that you can run docker run hello-world to check your installation.\n"
