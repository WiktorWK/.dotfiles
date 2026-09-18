#!/bin/bash

set -e

PGADMIN_KEYRING="/usr/share/keyrings/packages-pgadmin-org.gpg"
PGADMIN_SOURCE="/etc/apt/sources.list.d/pgadmin4.list"

printf "\n\n=== Install pgAdmin 4 ===\n\n"

# ------------------------------------------------------------
# Prerequisites
# ------------------------------------------------------------

printf "\n=== Install prerequisites ===\n\n"

sudo apt-get update

sudo apt-get install -y \
    curl \
    gnupg \
    lsb-release

# ------------------------------------------------------------
# Repository signing key
# ------------------------------------------------------------

printf "\n=== Add pgAdmin repository key ===\n\n"

curl -fsS \
    https://www.pgadmin.org/static/packages_pgadmin_org.pub \
    | sudo gpg \
        --dearmor \
        --yes \
        -o "$PGADMIN_KEYRING"

# ------------------------------------------------------------
# Repository
# ------------------------------------------------------------

printf "\n=== Add pgAdmin repository ===\n\n"

CODENAME="$(lsb_release -cs)"

sudo tee "$PGADMIN_SOURCE" > /dev/null <<EOF
deb [signed-by=$PGADMIN_KEYRING] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$CODENAME pgadmin4 main
EOF

# ------------------------------------------------------------
# Install
# ------------------------------------------------------------

printf "\n=== Install pgAdmin 4 desktop ===\n\n"

sudo apt-get update

sudo apt-get install -y pgadmin4-desktop

# ------------------------------------------------------------
# Verify
# ------------------------------------------------------------

printf "\n\n=== Verify pgAdmin installation ===\n\n"

dpkg -l pgadmin4-desktop | grep '^ii'

printf "\n\n========================================\n"
printf " pgAdmin 4 installed\n"
printf "========================================\n\n"

