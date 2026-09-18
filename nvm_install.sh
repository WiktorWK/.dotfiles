#!/usr/bin/env bash

set -e

NVM_VERSION="v0.40.2"
NVM_DIR="$HOME/.nvm"

printf '\n\n=== Install NVM %s ===\n\n' "$NVM_VERSION"

if [ ! -d "$NVM_DIR" ]; then
    PROFILE=/dev/null \
        curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
        | bash
else
    printf 'NVM is already installed.\n'
fi

export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
else
    printf '\nERROR: nvm.sh was not found.\n'
    exit 1
fi

printf '\nNVM version:\n'
nvm --version

printf '\n\n========================================\n'
printf ' NVM installed\n'
printf '========================================\n\n'

printf 'NVM directory: %s\n' "$NVM_DIR"

