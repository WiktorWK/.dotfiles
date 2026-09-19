#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

run_script() {
    local script="$1"

    echo
    echo "========================================"
    echo " Running: $script"
    echo "========================================"

    "$SCRIPT_DIR/$script"
}

echo "Starting system setup..."
echo "Script directory: $SCRIPT_DIR"

# ------------------------------------------------------------
# Base packages
# ------------------------------------------------------------

run_script "packages_install.sh"

# ------------------------------------------------------------
# Additional packages / repositories
# ------------------------------------------------------------

run_script "sub_packages_install.sh"

# ------------------------------------------------------------
# Applications
# ------------------------------------------------------------

run_script "brave.sh"
run_script "pg_admin.sh"

# ------------------------------------------------------------
# Starship
# ------------------------------------------------------------

echo
echo "Installing Starship..."

curl -sS https://starship.rs/install.sh | sh -s -- -y

# ------------------------------------------------------------
# Node / global packages
# ------------------------------------------------------------

echo
echo "Installing global npm packages..."

if command -v npm >/dev/null 2>&1; then
    npm install -g \
        prettier \
        typescript
else
    echo "WARNING: npm is not installed, skipping global npm packages."
fi

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo
echo "========================================"
echo " Installation completed successfully"
echo "========================================"
