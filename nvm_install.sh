#!/usr/bin/env bash

set -euo pipefail

NVM_VERSION="v0.40.2"
NVM_DIR="$HOME/.nvm"

echo
echo "=== Install / update NVM ${NVM_VERSION} ==="
echo

if [[ ! -d "$NVM_DIR" ]]; then
    PROFILE=/dev/null \
        curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
        | bash
else
    echo "NVM directory already exists."
    echo "Updating NVM..."

    git -C "$NVM_DIR" fetch --tags origin

    git -C "$NVM_DIR" checkout "$NVM_VERSION"
fi

export NVM_DIR="$HOME/.nvm"

if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    echo "ERROR: nvm.sh was not found."
    exit 1
fi

source "$NVM_DIR/nvm.sh"

echo
echo "NVM:"
nvm --version

echo
echo "=== Install Node.js LTS ==="
echo

nvm install --lts
nvm alias default 'lts/*'
nvm use default

echo
echo "Node.js:"
node --version

echo
echo "npm:"
npm --version

echo
echo "=== Install global npm packages ==="
echo

npm install -g \
    prettier \
    typescript

echo
echo "NVM installation completed."
