#!/usr/bin/env bash

set -euo pipefail

DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
DOCKER_SOURCE="/etc/apt/sources.list.d/docker.sources"
DOCKER_USER="${SUDO_USER:-$USER}"

echo
echo "=== Cleaning previous Docker installation ==="
echo

sudo systemctl disable --now docker.service 2>/dev/null || true
sudo systemctl disable --now containerd.service 2>/dev/null || true

sudo apt-get remove -y \
    docker \
    docker-engine \
    docker.io \
    docker-doc \
    docker-compose \
    docker-compose-v2 \
    podman-docker \
    containerd \
    runc || true

sudo rm -f \
    /etc/apt/sources.list.d/docker.list \
    /etc/apt/sources.list.d/docker.sources \
    /etc/apt/keyrings/docker.asc \
    /etc/apt/keyrings/docker.gpg \
    /usr/share/keyrings/docker-archive-keyring.gpg

echo
echo "=== Installing Docker prerequisites ==="
echo

sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl

echo
echo "=== Adding Docker GPG key ==="
echo

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl \
    -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o "$DOCKER_KEYRING"

sudo chmod 0644 "$DOCKER_KEYRING"

echo
echo "=== Adding Docker repository ==="
echo

sudo tee "$DOCKER_SOURCE" >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: $DOCKER_KEYRING
EOF

sudo apt-get update

echo
echo "=== Installing Docker Engine ==="
echo

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo
echo "=== Configure Docker ==="
echo

sudo usermod -aG docker "$DOCKER_USER"

sudo systemctl enable --now docker.service

echo
echo "=== Verify Docker ==="
echo

sudo docker version
sudo docker compose version

echo
echo "========================================"
echo " Docker installation complete"
echo "========================================"
echo

echo "Docker user: $DOCKER_USER"
echo "Log out and log in again so the docker group takes effect."
