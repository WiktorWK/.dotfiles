#!/usr/bin/env bash

set -euo pipefail

NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
NVIM_PATH="$HOME/Applications/nvim"
NVIM_TMP="/tmp/nvim-linux-x86_64.appimage"

echo
echo "=== Cleaning previous Neovim installation ==="
echo

rm -f "$NVIM_PATH"
rm -f "$NVIM_TMP"

mkdir -p "$HOME/Applications"

echo
echo "=== Download Neovim ==="
echo

curl -fL \
    "$NVIM_URL" \
    -o "$NVIM_TMP"

echo
echo "=== Install Neovim ==="
echo

mv "$NVIM_TMP" "$NVIM_PATH"
chmod +x "$NVIM_PATH"

echo
echo "=== Verify Neovim ==="
echo

"$NVIM_PATH" --version | head -n 1

echo
echo "Neovim installed:"
echo "$NVIM_PATH"
