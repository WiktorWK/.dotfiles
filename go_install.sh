#!/usr/bin/env bash

set -euo pipefail

GO_VERSION="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -n 1)"
GO_VERSION="${GO_VERSION#go}"

GO_ARCH="amd64"
GO_TARBALL="go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

echo
echo "=== Cleaning previous Go installation ==="
echo

sudo rm -rf /usr/local/go

echo
echo "=== Installing Go ${GO_VERSION} ==="
echo

cd /tmp

rm -f "$GO_TARBALL"

curl -fL \
    "$GO_URL" \
    -o "$GO_TARBALL"

sudo tar \
    -C /usr/local \
    -xzf "$GO_TARBALL"

rm -f "$GO_TARBALL"

export PATH="/usr/local/go/bin:$PATH"

echo
echo "=== Verify Go ==="
echo

go version

echo
echo "Go ${GO_VERSION} installed."
echo "Binary: /usr/local/go/bin/go"
