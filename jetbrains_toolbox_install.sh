#!/usr/bin/env bash

set -euo pipefail

TOOLBOX_PAGE="https://www.jetbrains.com/toolbox-app/download/"

INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox"
TMP_DIR="$(mktemp -d)"
TOOLBOX_ARCHIVE="$TMP_DIR/jetbrains-toolbox.tar.gz"

cleanup() {
    rm -rf "$TMP_DIR"
}

trap cleanup EXIT

echo
echo "========================================"
echo " Cleaning previous JetBrains Toolbox"
echo "========================================"
echo

pkill -x jetbrains-toolbox 2>/dev/null || true

rm -rf "$INSTALL_DIR"
rm -f "$HOME/.local/share/applications/jetbrains-toolbox.desktop"
rm -f "$HOME/.config/autostart/jetbrains-toolbox.desktop"

echo
echo "========================================"
echo " Detecting latest JetBrains Toolbox"
echo "========================================"
echo

TOOLBOX_URL="$(
    curl -fsSL "$TOOLBOX_PAGE" |
        grep -oP 'https://download\.jetbrains\.com/toolbox/jetbrains-toolbox-[^"]+-linux-x64\.tar\.gz' |
        head -n 1
)"

if [[ -z "$TOOLBOX_URL" ]]; then
    echo "ERROR: Could not determine the latest JetBrains Toolbox download URL."
    exit 1
fi

TOOLBOX_VERSION="$(
    basename "$TOOLBOX_URL" |
        sed -E 's/^jetbrains-toolbox-([0-9.]+)\.tar\.gz$/\1/'
)"

echo "Latest version: $TOOLBOX_VERSION"
echo "Download URL:   $TOOLBOX_URL"

echo
echo "========================================"
echo " Downloading JetBrains Toolbox"
echo "========================================"
echo

curl -fL "$TOOLBOX_URL" \
    -o "$TOOLBOX_ARCHIVE"

echo
echo "========================================"
echo " Installing JetBrains Toolbox"
echo "========================================"
echo

mkdir -p "$INSTALL_DIR"

tar -xzf "$TOOLBOX_ARCHIVE" \
    -C "$INSTALL_DIR" \
    --strip-components=1

echo
echo "========================================"
echo " Starting JetBrains Toolbox"
echo "========================================"
echo

"$INSTALL_DIR/bin/jetbrains-toolbox" &

echo
echo "JetBrains Toolbox $TOOLBOX_VERSION installed."
echo
echo "Installation:"
echo "  $INSTALL_DIR"
