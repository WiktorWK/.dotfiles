#!/usr/bin/env bash

set -euo pipefail

DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
DOCKER_SOURCE="/etc/apt/sources.list.d/docker.sources"

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
    "$DOCKER_SOURCE" \
    "$DOCKER_KEYRING"

echo
echo "=== Installing Docker prerequisites ==="
echo

sudo apt-get update

sudo apt-get install -y --no-remove \
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

sudo chmod a+r "$DOCKER_KEYRING"

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

sudo apt-get install -y --no-remove \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo
echo "=== Configure Docker ==="
echo

sudo usermod -aG docker "$USER"

sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

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

echo "Log out and log in again so the docker group takes effect."
