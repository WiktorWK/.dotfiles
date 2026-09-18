#!/bin/bash

set -e

GO_VERSION="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -n 1)"
GO_VERSION="${GO_VERSION#go}"
GO_ARCH="amd64"
GO_TARBALL="go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

printf "\n\n=== Install Go ${GO_VERSION} ===\n\n"

printf "Downloading Go...\n"

cd /tmp

rm -f "$GO_TARBALL"

wget "$GO_URL"

printf "\n\n=== Remove previous Go installation ===\n\n"

sudo rm -rf /usr/local/go

printf "\n\n=== Install Go ===\n\n"

sudo tar \
    -C /usr/local \
    -xzf "$GO_TARBALL"

rm -f "$GO_TARBALL"

printf "\n\n=== Verify Go installation ===\n\n"

export PATH="/usr/local/go/bin:$PATH"

go version

printf "\n\n========================================\n"
printf " Go ${GO_VERSION} installed\n"
printf "========================================\n\n"

printf "Make sure /usr/local/go/bin is in PATH.\n"

