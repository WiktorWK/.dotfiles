#!/bin/bash

set -e

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

mv nvim.appimage ~/Applications/nvim
chmod +x ~/Applications/nvim
rm -rf shasum.txt
