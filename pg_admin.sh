#!/usr/bin/env bash

set -euo pipefail

sudo install -d -m 0755 /usr/share/keyrings

curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/packages-pgadmin-org.gpg >/dev/null

sudo chmod 0644 /usr/share/keyrings/packages-pgadmin-org.gpg

echo \
    "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" \
    | sudo tee /etc/apt/sources.list.d/pgadmin4.list >/dev/null

sudo apt-get update

sudo apt-get install -y --no-remove pgadmin4-desktop
