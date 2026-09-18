#!/bin/bash

set -e

printf "\n\n=== Install Brave Browser repository ===\n\n"

# Install prerequisites
sudo apt-get update
sudo apt-get install -y curl

# Install Brave signing key
sudo curl \
    -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

# Add Brave repository
sudo curl \
    -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
    https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

# Update package lists
sudo apt-get update

# Install Brave
sudo apt-get install -y brave-browser

printf "\n\n=== Brave Browser installed ===\n\n"

brave-browser --version

