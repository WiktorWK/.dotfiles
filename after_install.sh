#!/bin/bash

set -e

# create a folder for applications installed as appimages
mkdir -p ~/Applications

# make sure curl is installed
sudo apt-get -y install curl

# brave
sudo ./brave.sh

# pgAdmin
sudo ./pg_admin.sh

# update and install necessary packages
# ripgrep is needed for nvim telescope to work properly and used as nvim's grepprg
# fuse and libfuse2 are needed to support AppImages
# needed to install python3.12-venv as a depency for platformIO install - package missing on ubuntu24.04
sudo apt-get update
sudo apt-get -y install apt-transport-https \
    git make libssl-dev curl wget zsh rofi build-essential \
    stow fzf pip tmux lm-sensors brave-browser liferea pgadmin4 ripgrep \
    maim xclip xsel feh compton jq wireshark nmap solaar \
    fuse libfuse2 gimp valgrind gdbserver btop brightnessctl \
    moreutils libpq-dev python3-venv

# install tmux tpm
rm -rf ~/.tmux || true
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# add user to wireshark group, so that it doesn't need to be run as root
sudo usermod -aG wireshark $USER

# install nvim
./nvim_install.sh

# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# install dev tool managers
./nvm_install.sh

#source nvm
source ~/.nvm/nvm.sh

# install latest lts node version
nvm install --lts node
nvm use --lts

# install go
./go_install.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# create a directory for projects
rm -rf ~/projects || true
mkdir ~/projects

# install docker
sh ./docker_install.sh

# install starship (prompt)
# this may fail on next fresh install
curl -sS https://starship.rs/install.sh | sh

# install ohmyzsh
rm -rf /home/wiktor/.oh-my-zsh || true
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install bitwarden CLI
npm install -g @bitwarden/cli

# install powerlevel10k theme
printf "\n\n install powerlevel10k \n\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# stow configs
printf "\n\n stow .dotfiles \n\n"
rm ~/.zshrc || true
cd ~/.dotfiles
stow nvim tmux zsh

# install govm
printf "\n\n install govm \n\n"
exec zsh
source ~/.zshrc
go install github.com/melkeydev/govm@latest

systemctl --user daemon-reload

# install typescript globally (needed by pop shell install)
printf "\n\n install TS \n\n"
npm install -g typescript

# install yarn - needed for some neovim plugins
printf "\n\n install yarn -g \n\n"
npm install --global yarn

# install awsome fonts
printf "\n\n install fonts \n\n"
sh ./font_install.sh

printf "\n\n	You need to login again\n\n"
