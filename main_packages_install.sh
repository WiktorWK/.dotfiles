#!/usr/bin/env bash

set -e

printf '\n\n=== Ubuntu package setup ===\n\n'

install_group() {
    local name="$1"
    shift

    printf '\n\n========================================\n'
    printf ' Installing: %s\n' "$name"
    printf '========================================\n\n'

    sudo apt install -y "$@"

    printf '\n--- GDM status after %s ---\n' "$name"
    systemctl is-active gdm3 || true
    systemctl --no-pager --lines=10 status gdm3 || true

    printf '\n'
}

printf '=== Updating APT ===\n\n'
sudo apt update

# ------------------------------------------------------------
# 1. Base / shell / CLI
# ------------------------------------------------------------

install_group "base and CLI tools" \
    git \
    curl \
    wget \
    build-essential \
    libssl-dev \
    stow \
    zsh \
    fzf \
    ripgrep \
    jq \
    moreutils

# ------------------------------------------------------------
# 2. Development
# ------------------------------------------------------------

install_group "development tools" \
    tmux \
    tmuxp \
    python3-pip \
    python3-venv \
    maven \
    libpq-dev \
    valgrind \
    gdbserver \
    btop

# ------------------------------------------------------------
# 3. X11 / desktop utilities
# ------------------------------------------------------------

install_group "desktop utilities" \
    rofi \
    maim \
    xclip \
    xsel \
    feh \
    lm-sensors \
    solaar

# ------------------------------------------------------------
# 4. Network / diagnostics
# ------------------------------------------------------------

install_group "network tools" \
    wireshark \
    nmap

# ------------------------------------------------------------
# 5. Graphics / desktop applications
# ------------------------------------------------------------

install_group "desktop applications" \
    gimp \
    liferea \
    clamav

# ------------------------------------------------------------
# 6. FUSE
# ------------------------------------------------------------

install_group "FUSE" \
    fuse \
    libfuse2

# ------------------------------------------------------------
# Finish
# ------------------------------------------------------------

printf '\n\n========================================\n'
printf ' Installation complete\n'
printf '========================================\n\n'

printf 'GDM:\n'
systemctl --no-pager --lines=20 status gdm3 || true

printf '\nInstalled NVIDIA packages:\n'
dpkg -l | grep -E '^ii\s+nvidia' || true

printf '\nDone.\n'

