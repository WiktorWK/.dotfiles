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

run_script "main_packages_install.sh"

run_script "docker_install.sh"
run_script "brave.sh"
run_script "pg_admin.sh"

run_script "go_install.sh"
run_script "nvm_install.sh"
run_script "nvim_install.sh"

run_script "font_install.sh"
run_script "starship_install.sh"

echo
echo "========================================"
echo " Installation completed successfully"
echo "========================================"
