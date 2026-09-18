#!/usr/bin/env bash

set -e

# Always run from the directory containing this script.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

printf '\n\n========================================\n'
printf ' System bootstrap\n'
printf '========================================\n\n'

# ------------------------------------------------------------
# Applications directory
# ------------------------------------------------------------

printf '\n\n=== Applications directory ===\n\n'

mkdir -p "$HOME/Applications"

# ------------------------------------------------------------
# System packages
# ------------------------------------------------------------

printf '\n\n=== Install system packages ===\n\n'

./packages_install.sh

# ------------------------------------------------------------
# Additional packages
# ------------------------------------------------------------

printf '\n\n=== Install additional packages ===\n\n'

./sub_packages_install.sh

# ------------------------------------------------------------
# External applications
# ------------------------------------------------------------

printf '\n\n=== Install Brave Browser ===\n\n'

./brave.sh

printf '\n\n=== Install pgAdmin ===\n\n'

./pg_admin.sh

# ------------------------------------------------------------
# Wireshark permissions
# ------------------------------------------------------------

printf '\n\n=== Add user to wireshark group ===\n\n'

sudo usermod -aG wireshark "$USER"

# ------------------------------------------------------------
# tmux TPM
# ------------------------------------------------------------

printf '\n\n=== Install tmux TPM ===\n\n'

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    git clone \
        https://github.com/tmux-plugins/tpm \
        "$TPM_DIR"
else
    printf 'TPM already installed.\n'
fi

# ------------------------------------------------------------
# Dotfiles - zsh first
#
# .zshrc is managed by Stow.
# Do not remove or overwrite it later in this script.
# ------------------------------------------------------------

printf '\n\n=== Stow zsh configuration ===\n\n'

if [ -d "$HOME/.dotfiles" ]; then
    cd "$HOME/.dotfiles"

    stow --restow zsh
else
    printf '\nWARNING: $HOME/.dotfiles does not exist\n'
    printf 'Skipping zsh stow.\n'
fi

cd "$SCRIPT_DIR"

# ------------------------------------------------------------
# Neovim
# ------------------------------------------------------------

printf '\n\n=== Install Neovim ===\n\n'

./nvim_install.sh

# ------------------------------------------------------------
# Tailscale
# ------------------------------------------------------------

printf '\n\n=== Install Tailscale ===\n\n'

curl -fsSL https://tailscale.com/install.sh | sh

# ------------------------------------------------------------
# NVM
# ------------------------------------------------------------

printf '\n\n=== Install NVM ===\n\n'

./nvm_install.sh

export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
else
    printf '\nERROR: NVM was not installed correctly.\n'
    exit 1
fi

printf '\n\n=== Install Node.js LTS ===\n\n'

nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# ------------------------------------------------------------
# SDKMAN
# ------------------------------------------------------------

printf '\n\n=== Install SDKMAN ===\n\n'

if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
else
    printf 'SDKMAN already installed.\n'
fi

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk version

# ------------------------------------------------------------
# Go
# ------------------------------------------------------------

printf '\n\n=== Install Go ===\n\n'

./go_install.sh

export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

printf '\n\n=== Verify Go ===\n\n'

go version

# ------------------------------------------------------------
# Rust
# ------------------------------------------------------------

printf '\n\n=== Install Rust ===\n\n'

if [ ! -x "$HOME/.cargo/bin/rustc" ]; then
    curl \
        --proto '=https' \
        --tlsv1.2 \
        -sSf \
        https://sh.rustup.rs \
        | sh -s -- -y --no-modify-path
else
    printf 'Rust already installed.\n'
fi

source "$HOME/.cargo/env"

printf '\n\n=== Verify Rust ===\n\n'

rustc --version
cargo --version

# ------------------------------------------------------------
# Projects
# ------------------------------------------------------------

printf '\n\n=== Projects directory ===\n\n'

mkdir -p "$HOME/projects"

# ------------------------------------------------------------
# Docker
# ------------------------------------------------------------

printf '\n\n=== Install Docker ===\n\n'

./docker_install.sh

# ------------------------------------------------------------
# Starship
# ------------------------------------------------------------

printf '\n\n=== Install Starship ===\n\n'

curl -sS https://starship.rs/install.sh | sh -s -- -y

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------

printf '\n\n=== Install Oh My Zsh ===\n\n'

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no \
    CHSH=no \
    sh -c "$(
        curl -fsSL \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    )" "" --unattended
else
    printf 'Oh My Zsh already installed.\n'
fi

# ------------------------------------------------------------
# Powerlevel10k
# ------------------------------------------------------------

printf '\n\n=== Install Powerlevel10k ===\n\n'

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
    git clone \
        --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$P10K_DIR"
else
    printf 'Powerlevel10k already installed.\n'
fi

# ------------------------------------------------------------
# Bitwarden CLI
# ------------------------------------------------------------

printf '\n\n=== Install Bitwarden CLI ===\n\n'

npm install -g @bitwarden/cli

# ------------------------------------------------------------
# TypeScript
# ------------------------------------------------------------

printf '\n\n=== Install TypeScript ===\n\n'

npm install --global typescript

# ------------------------------------------------------------
# Yarn
# ------------------------------------------------------------

printf '\n\n=== Install Yarn ===\n\n'

npm install --global yarn

# ------------------------------------------------------------
# Fonts
# ------------------------------------------------------------

printf '\n\n=== Install fonts ===\n\n'

./font_install.sh

# ------------------------------------------------------------
# Go VM
# ------------------------------------------------------------

printf '\n\n=== Install govm ===\n\n'

go install github.com/melkeydev/govm@latest

# ------------------------------------------------------------
# Dotfiles - remaining configurations
# ------------------------------------------------------------

printf '\n\n=== Stow dotfiles ===\n\n'

if [ -d "$HOME/.dotfiles" ]; then
    cd "$HOME/.dotfiles"

    stow --restow \
        nvim \
        tmux \
        starship \
        solaar \
        zsh
else
    printf '\nWARNING: $HOME/.dotfiles does not exist\n'
    printf 'Skipping stow.\n'
fi

# ------------------------------------------------------------
# Finish
# ------------------------------------------------------------

printf '\n\n========================================\n'
printf ' Installation complete\n'
printf '========================================\n\n'

printf 'You need to log in again for group changes to take effect.\n\n'

printf 'Groups requiring a new login:\n'
printf '  - wireshark\n'
printf '  - docker\n\n'

printf 'After logging in, verify with:\n\n'

printf '  docker run hello-world\n'
printf '  go version\n'
printf '  node --version\n'
printf '  nvim --version\n'
printf '  rustc --version\n'
printf '  cargo --version\n\n'

