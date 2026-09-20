#!/usr/bin/env bash

set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"
NERD_FONTS_DIR="/tmp/nerd-fonts"

echo
echo "=== Cleaning previous generated Hack fonts ==="
echo

rm -f \
    "$FONT_DIR"/Hack*.ttf \
    "$FONT_DIR"/Hack*.otf

rm -rf "$NERD_FONTS_DIR"

echo
echo "=== Clone Nerd Fonts ==="
echo

git clone \
    --depth 1 \
    https://github.com/ryanoasis/nerd-fonts.git \
    "$NERD_FONTS_DIR"

echo
echo "=== Prepare Codicons ==="
echo

cp \
    "$NERD_FONTS_DIR/src/glyphs/codicons/codicon.ttf" \
    "$NERD_FONTS_DIR/src/glyphs/"

echo
echo "=== Patch Hack ==="
echo

cd "$NERD_FONTS_DIR"

fontforge \
    -script "$NERD_FONTS_DIR/font-patcher" \
    "$NERD_FONTS_DIR/src/unpatched-fonts/Hack/Regular/Hack-Regular.ttf" \
    -s \
    -c

echo
echo "=== Install fonts ==="
echo

mkdir -p "$FONT_DIR"

cp Hack*.ttf "$FONT_DIR/"

echo
echo "=== Update font cache ==="
echo

fc-cache -f "$FONT_DIR"

echo
echo "=== Cleanup ==="
echo

rm -rf "$NERD_FONTS_DIR"

echo
echo "=== Installed Hack fonts ==="
echo

fc-list | grep -i "Hack" | head -20 || true

echo
echo "Fonts installed successfully."
