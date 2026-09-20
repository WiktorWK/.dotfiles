#!/usr/bin/env bash

set -euo pipefail

COMPASS_PAGE="https://www.mongodb.com/try/download/compass"
TMP_DIR="$(mktemp -d)"
COMPASS_DEB="$TMP_DIR/mongodb-compass.deb"

cleanup() {
    rm -rf "$TMP_DIR"
}

trap cleanup EXIT

echo
echo "========================================"
echo " Cleaning previous MongoDB Compass"
echo "========================================"
echo

sudo apt-get remove -y mongodb-compass 2>/dev/null || true

echo
echo "========================================"
echo " Detecting latest MongoDB Compass"
echo "========================================"
echo

COMPASS_VERSION="$(
    curl -fsSL "$COMPASS_PAGE" |
        grep -oP '\d+\.\d+\.\d+(?= \(Stable\))' |
        head -n 1
)"

if [[ -z "$COMPASS_VERSION" ]]; then
    echo "ERROR: Could not determine MongoDB Compass version."
    exit 1
fi

echo "Latest version: $COMPASS_VERSION"

COMPASS_URL="https://downloads.mongodb.com/compass/mongodb-compass_${COMPASS_VERSION}_amd64.deb"

echo
echo "Download:"
echo "  $COMPASS_URL"
echo

echo
echo "========================================"
echo " Downloading MongoDB Compass"
echo "========================================"
echo

curl -fL "$COMPASS_URL" \
    -o "$COMPASS_DEB"

echo
echo "========================================"
echo " Installing MongoDB Compass"
echo "========================================"
echo

sudo apt-get install -y "$COMPASS_DEB"

echo
echo "========================================"
echo " Verifying MongoDB Compass"
echo "========================================"
echo

mongodb-compass --version

echo
echo "MongoDB Compass $COMPASS_VERSION installed successfully."

set -euo pipefail

COMPASS_VERSION="1.50.0"
COMPASS_URL="https://downloads.mongodb.com/compass/mongodb-compass_${COMPASS_VERSION}_amd64.deb"
COMPASS_TMP="/tmp/mongodb-compass.deb"

echo
echo "=== Cleaning previous MongoDB Compass installation ==="
echo

sudo apt-get remove -y mongodb-compass 2>/dev/null || true
rm -f "$COMPASS_TMP"

echo
echo "=== Download MongoDB Compass ${COMPASS_VERSION} ==="
echo

curl -fL "$COMPASS_URL" -o "$COMPASS_TMP"

echo
echo "=== Install MongoDB Compass ==="
echo

sudo apt-get install -y "$COMPASS_TMP"

rm -f "$COMPASS_TMP"

echo
echo "=== Verify MongoDB Compass ==="
echo

mongodb-compass --version

echo
echo "MongoDB Compass installed."
