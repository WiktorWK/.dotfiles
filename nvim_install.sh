#!/usr/bin/env bash

set -euo pipefail

NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
NVIM_APP="$HOME/Applications/nvim"
NVIM_BIN="$HOME/.local/bin/nvim"

echo
echo "=== Cleaning previous Neovim installation ==="
echo

rm -f "$NVIM_APP"
rm -f "$NVIM_BIN"

mkdir -p "$HOME/Applications"
mkdir -p "$HOME/.local/bin"

NVIM_TMP="$(mktemp)"

cleanup() {
    rm -f "$NVIM_TMP"
}

trap cleanup EXIT

echo
echo "=== Download Neovim ==="
echo

curl -fL "$NVIM_URL" -o "$NVIM_TMP"

echo
echo "=== Install Neovim ==="
echo

chmod +x "$NVIM_TMP"
mv "$NVIM_TMP" "$NVIM_APP"

ln -s "$NVIM_APP" "$NVIM_BIN"

echo
echo "=== Verify Neovim ==="
echo

"$NVIM_BIN" --version | head -n 1

echo
echo "Neovim installed:"
echo "  AppImage: $NVIM_APP"
echo "  Binary:   $NVIM_BIN"
