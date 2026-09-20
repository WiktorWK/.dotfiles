#!/usr/bin/env bash

set -euo pipefail

CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
CHROME_TMP="/tmp/google-chrome-stable_current_amd64.deb"

echo
echo "=== Cleaning previous Google Chrome installation ==="
echo

sudo apt-get remove -y google-chrome-stable 2>/dev/null || true
rm -f "$CHROME_TMP"

echo
echo "=== Download Google Chrome ==="
echo

curl -fL "$CHROME_URL" -o "$CHROME_TMP"

echo
echo "=== Install Google Chrome ==="
echo

sudo apt-get install -y "$CHROME_TMP"

rm -f "$CHROME_TMP"

echo
echo "=== Verify Google Chrome ==="
echo

google-chrome --version

echo
echo "Google Chrome installed."
