```bash
#!/bin/bash

set -e

NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
NVIM_PATH="$HOME/Applications/nvim"
NVIM_TMP="/tmp/nvim-linux-x86_64.appimage"

printf "\n\n=== Install Neovim ===\n\n"

# ------------------------------------------------------------
# Applications directory
# ------------------------------------------------------------

mkdir -p "$HOME/Applications"

# ------------------------------------------------------------
# Download
# ------------------------------------------------------------

printf "Downloading latest Neovim AppImage...\n"

rm -f "$NVIM_TMP"

curl -fL \
    "$NVIM_URL" \
    -o "$NVIM_TMP"

# ------------------------------------------------------------
# Install
# ------------------------------------------------------------

printf "\nInstalling Neovim...\n"

rm -f "$NVIM_PATH"

mv "$NVIM_TMP" "$NVIM_PATH"

chmod +x "$NVIM_PATH"

# ------------------------------------------------------------
# Verify
# ------------------------------------------------------------

printf "\n\n=== Verify Neovim ===\n\n"

"$NVIM_PATH" --version | head -n 1

printf "\n\n========================================\n"
printf " Neovim installed\n"
printf "========================================\n\n"

printf "Binary: %s\n" "$NVIM_PATH"
```
