#!/usr/bin/env bash

set -euo pipefail

install_group() {
    local name="$1"
    shift

    echo
    echo "========================================"
    echo " Installing: $name"
    echo "========================================"

    sudo apt-get install -y --no-remove "$@"
}

check_desktop_packages() {
    local packages=(
        ubuntu-session
        ubuntu-desktop
        ubuntu-desktop-minimal
        fuse3
    )

    echo
    echo "Checking critical desktop packages..."

    for package in "${packages[@]}"; do
        if dpkg-query -W -f='${Status}' "$package" 2>/dev/null \
            | grep -q 'install ok installed'; then
            echo "  OK: $package"
        else
            echo "  ERROR: $package is not installed!"
            exit 1
        fi
    done
}

echo "Updating APT..."
sudo apt-get update

# ------------------------------------------------------------
# Base / CLI
# ------------------------------------------------------------

install_group "Base / CLI" \
    curl \
    wget \
    git \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz-utils \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    build-essential

# ------------------------------------------------------------
# Development
# ------------------------------------------------------------

install_group "Development" \
    gcc \
    g++ \
    make \
    pkg-config \
    libssl-dev \
    libffi-dev

# ------------------------------------------------------------
# Fonts
# ------------------------------------------------------------

install_group "Font tools" \
    fontforge

# ------------------------------------------------------------
# Desktop utilities
# ------------------------------------------------------------

install_group "Desktop utilities" \
    gnome-tweaks \
    gnome-shell-extension-manager \
    p7zip-full \
    file \
    htop \
    btop \
    tree \
    ncdu

# ------------------------------------------------------------
# Network
# ------------------------------------------------------------

install_group "Network" \
    openssh-client \
    openssh-server \
    net-tools \
    dnsutils \
    traceroute \
    nmap

# ------------------------------------------------------------
# Graphics / applications
# ------------------------------------------------------------

install_group "Graphics / applications" \
    ffmpeg \
    imagemagick

# ------------------------------------------------------------
# FUSE
# ------------------------------------------------------------
#
# IMPORTANT:
# Do NOT install the "fuse" package on Ubuntu 24.04.
#
# "fuse" can conflict with fuse3 and cause APT to remove:
#   ubuntu-session
#   ubuntu-desktop
#   ubuntu-desktop-minimal
#
# libfuse2 is the compatibility library required by some
# older AppImages.
# ------------------------------------------------------------

install_group "FUSE compatibility" \
    libfuse2

# ------------------------------------------------------------
# Final verification
# ------------------------------------------------------------

check_desktop_packages

echo
echo "========================================"
echo " Package installation completed"
echo "========================================"
