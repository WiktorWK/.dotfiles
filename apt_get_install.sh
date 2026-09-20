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
    build-essential \
    rsync \
    jq \
    bc

# ------------------------------------------------------------
# Development
# ------------------------------------------------------------

install_group "Development" \
    gcc \
    g++ \
    make \
    pkg-config \
    libssl-dev \
    libffi-dev \
    shellcheck \
    shfmt

# ------------------------------------------------------------
# Python
# ------------------------------------------------------------

install_group "Python" \
    python3 \
    python3-pip \
    python3-venv

# ------------------------------------------------------------
# Java
# ------------------------------------------------------------

install_group "Java" \
    default-jdk \
    maven

# ------------------------------------------------------------
# Terminal / shell
# ------------------------------------------------------------

install_group "Terminal" \
    tmux \
    tmuxp \
    ripgrep \
    fd-find \
    tree \
    htop \
    btop \
    ncdu \
    file

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
    p7zip-full

# ------------------------------------------------------------
# Network
# ------------------------------------------------------------

install_group "Network" \
    openssh-client \
    openssh-server \
    net-tools \
    dnsutils \
    traceroute \
    nmap \
    wireshark

# ------------------------------------------------------------
# Graphics / applications
# ------------------------------------------------------------

install_group "Graphics / applications" \
    ffmpeg \
    imagemagick

# ------------------------------------------------------------
# Security
# ------------------------------------------------------------

install_group "Security" \
    clamav \
    clamav-daemon

# ------------------------------------------------------------
# FUSE compatibility
# ------------------------------------------------------------

install_group "FUSE compatibility" \
    libfuse2t64

# ------------------------------------------------------------
# Final verification
# ------------------------------------------------------------

check_desktop_packages

echo
echo "========================================"
echo " Package installation completed"
echo "========================================"
