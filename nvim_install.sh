#!/bin/bash

set -e

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

mv nvim-linux-x86_64.appimage $HOME/Applications/nvim
chmod +x $HOME/Applications/nvim
rm -rf shasum.txt
