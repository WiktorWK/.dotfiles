#!/usr/bin/env bash

set -e

printf '\n\n=== Installing extra packages ===\n\n'

# ------------------------------------------------------------
# Brave Browser
# ------------------------------------------------------------

printf '\n=== Brave Browser ===\n\n'

if ! command -v brave-browser >/dev/null 2>&1; then
    curl -fsS https://dl.brave.com/install.sh | sudo bash
else
    printf 'Brave is already installed.\n'
fi

# ------------------------------------------------------------
# pgAdmin 4
# ------------------------------------------------------------

printf '\n=== pgAdmin 4 ===\n\n'

sudo apt install -y pgadmin4

# ------------------------------------------------------------
# Final
# ------------------------------------------------------------

printf '\n\n========================================\n'
printf ' Extra packages installed\n'
printf '========================================\n\n'

printf 'Brave:\n'
command -v brave-browser || true

printf '\npgAdmin4:\n'
dpkg -l | grep -E '^ii\s+pgadmin4' || true

printf '\nDone.\n'

