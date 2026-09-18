#!/bin/bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
NERD_FONTS_DIR="/tmp/nerd-fonts"

printf "\n\n=== Install FontForge ===\n\n"
sudo apt-get install -y fontforge

printf "\n\n=== Prepare Nerd Fonts ===\n\n"
rm -rf "$NERD_FONTS_DIR"

git clone \
    --depth 1 \
    https://github.com/ryanoasis/nerd-fonts.git \
    "$NERD_FONTS_DIR"

printf "\n\n=== Prepare Codicons ===\n\n"
cp \
    "$NERD_FONTS_DIR/src/glyphs/codicons/codicon.ttf" \
    "$NERD_FONTS_DIR/src/glyphs/"

printf "\n\n=== Patch Hack ===\n\n"
fontforge \
    -script "$NERD_FONTS_DIR/font-patcher" \
    "$NERD_FONTS_DIR/src/unpatched-fonts/Hack/Regular/Hack-Regular.ttf" \
    -s \
    -c

printf "\n\n=== Install fonts ===\n\n"
mkdir -p "$FONT_DIR"

cp Hack*.ttf "$FONT_DIR/"

printf "\n\n=== Update font cache ===\n\n"
fc-cache -f "$FONT_DIR"

printf "\n\n=== Cleanup ===\n\n"
rm -rf "$NERD_FONTS_DIR"
rm -f Hack*.ttf

printf "\n\n=== Installed Hack fonts ===\n\n"
fc-list | grep -i "Hack" | head -20 || true

printf "\n\nFonts installed successfully.\n\n"

