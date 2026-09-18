#!/bin/bash

set -e

printf "\n\n=== Remove old Docker installations ===\n\n"

sudo apt-get remove -y \
    docker \
    docker.io \
    docker-doc \
    docker-compose \
    podman-docker \
    containerd \
    runc || true

printf "\n\n=== Install Docker prerequisites ===\n\n"

sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl

printf "\n\n=== Add Docker's official GPG key ===\n\n"

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl \
    -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

printf "\n\n=== Add Docker's official repository ===\n\n"

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

printf "\n\n=== Update APT ===\n\n"

sudo apt-get update

printf "\n\n=== Install Docker Engine ===\n\n"

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

printf "\n\n=== Add current user to docker group ===\n\n"

sudo usermod -aG docker "$USER"

printf "\n\n=== Enable and start Docker ===\n\n"

sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

printf "\n\n=== Verify Docker installation ===\n\n"

sudo docker version
sudo docker compose version

printf "\n\n========================================\n"
printf " Docker installation complete\n"
printf "========================================\n\n"

printf "Log out and log in again so the docker group takes effect.\n"
printf "Then test with:\n\n"
printf "    docker run hello-world\n\n"

