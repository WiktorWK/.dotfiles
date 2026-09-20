#!/usr/bin/env bash

set -euo pipefail

echo
echo "=== Installing / updating Starship ==="
echo

curl -sS https://starship.rs/install.sh | sh -s -- -y

echo
echo "Starship version:"
echo

starship --version

echo
echo "Starship installation completed."
