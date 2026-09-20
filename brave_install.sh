#!/usr/bin/env bash

set -euo pipefail

KEYRING="/etc/apt/keyrings/brave-browser-archive-keyring.gpg"
SOURCE="/etc/apt/sources.list.d/brave-browser-release.list"

echo
echo "=== Cleaning previous Brave installation ==="
echo

sudo rm -f \
    /etc/apt/sources.list.d/brave-browser-release.list \
    /etc/apt/sources.list.d/brave-browser.sources \
    /etc/apt/keyrings/brave-browser-archive-keyring.gpg \
    /usr/share/keyrings/brave-browser-archive-keyring.gpg

sudo apt-get update

echo
echo "=== Installing Brave repository ==="
echo

sudo install -d -m 0755 /etc/apt/keyrings

curl -fsS \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    | sudo tee "$KEYRING" >/dev/null

sudo chmod 0644 "$KEYRING"

echo \
    "deb [signed-by=$KEYRING] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | sudo tee "$SOURCE" >/dev/null

sudo apt-get update

echo
echo "=== Installing Brave ==="
echo

sudo apt-get install -y --no-remove brave-browser

echo
echo "Brave installed successfully."
