#!/usr/bin/env bash

set -euo pipefail

KEYRING="/usr/share/keyrings/packages-pgadmin-org.gpg"
SOURCE="/etc/apt/sources.list.d/pgadmin4.list"
CODENAME="$(lsb_release -cs)"

echo
echo "=== Cleaning previous pgAdmin repository ==="
echo

sudo rm -f \
    "$SOURCE" \
    "$KEYRING"

sudo apt-get update

echo
echo "=== Installing pgAdmin repository ==="
echo

sudo install -d -m 0755 /usr/share/keyrings

curl -fsS \
    https://www.pgadmin.org/static/packages_pgadmin_org.pub \
    | gpg --dearmor \
    | sudo tee "$KEYRING" >/dev/null

sudo chmod 0644 "$KEYRING"

echo \
    "deb [signed-by=$KEYRING] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$CODENAME pgadmin4 main" \
    | sudo tee "$SOURCE" >/dev/null

sudo apt-get update

echo
echo "=== Installing pgAdmin ==="
echo

sudo apt-get install -y --no-remove pgadmin4-desktop

echo
echo "pgAdmin installed successfully."
