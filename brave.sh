#!/usr/bin/env bash

set -euo pipefail

sudo install -d -m 0755 /etc/apt/keyrings

curl -fsS https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    | sudo tee /etc/apt/keyrings/brave-browser-archive-keyring.gpg >/dev/null

sudo chmod 0644 /etc/apt/keyrings/brave-browser-archive-keyring.gpg

echo \
    "deb [signed-by=/etc/apt/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null

sudo apt-get update

sudo apt-get install -y --no-remove brave-browser
