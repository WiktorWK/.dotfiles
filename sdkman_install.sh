#!/usr/bin/env bash

set -euo pipefail

echo "Installing SDKMAN..."

if command -v sdk >/dev/null 2>&1 || [[ -d "$HOME/.sdkman" ]]; then
    echo "SDKMAN is already installed."
    exit 0
fi

curl -s "https://get.sdkman.io" | bash

echo "SDKMAN installed successfully."
echo
echo "Restart your shell or run:"
echo "  source \"$HOME/.sdkman/bin/sdkman-init.sh\""
