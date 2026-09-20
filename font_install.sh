#!/usr/bin/env bash

set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"

echo
echo "=== Cleaning previous Hack fonts ==="
echo

rm -f \
    "$FONT_DIR"/Hack*.ttf \
    "$FONT_DIR"/Hack*.otf

echo
echo "=== Installing Hack Nerd Font ==="
echo

curl -fsSL \
    https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh \
    | bash -s -- install Hack

echo
echo "=== Update font cache ==="
echo

fc-cache -f "$FONT_DIR"

echo
echo "=== Installed Hack fonts ==="
echo

fc-list | grep -i "Hack" | head -20 || true

echo
echo "Fonts installed successfully."
