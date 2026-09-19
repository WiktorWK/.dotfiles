#!/usr/bin/env bash

set -euo pipefail

echo "Installing Brave..."
curl -fsS https://dl.brave.com/install.sh | sudo bash

echo "Installing pgAdmin..."
sudo apt-get install -y --no-remove pgadmin4
