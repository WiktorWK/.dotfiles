#!/bin/bash

set -e

# create a folder for applications installed as appimages
printf "\n\n make Applications folder \n\n"
mkdir -p $HOME/Applications

# make sure curl is installed
printf "\n\n install curl package \n\n"
sudo apt-get -y install curl

# brave
printf "\n\n install brave browser \n\n"
sudo ./brave.sh

# pgAdmin
printf "\n\n install pg admin \n\n"
sudo ./pg_admin.sh

# update and install necessary packages
printf "\n\n instal necessary packages \n\n"
sudo apt-get update
sudo apt-get -y install git build-essential libssl-dev curl wget rofi zsh build-essential \
    stow fzf pip tmux lm-sensors brave-browser liferea pgadmin4 ripgrep \
    maim xclip xsel feh jq wireshark nmap solaar \
    fuse libfuse2 gimp valgrind gdbserver btop \
    moreutils libpq-dev python3-venv \
    clamav maven

# install tmux tpm
printf "\n\n install tmux tpm \n\n"
rm -rf $HOME/.tmux || true
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# add user to wireshark group, so that it doesn't need to be run as root
printf "\n\n add use to wireshark group \n\n"
sudo usermod -aG wireshark $USER

# install nvim
printf "\n\n install nvim \n\n"
./nvim_install.sh

# install tailscale
printf "\n\n install tailscale \n\n"
curl -fsSL https://tailscale.com/install.sh | sh

# install dev tool managers
printf "\n\n install nvm \n\n"
./nvm_install.sh

#source nvm
printf "\n\n get nvm source \n\n"
source $HOME/.nvm/nvm.sh

# install latest lts node version
printf "\n\n install node lts \n\n"
nvm install --lts node
nvm use --lts

# install sdkman
printf "\n\n install sdkman \n\n"
curl -s "https://get.sdkman.io" | bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk version

# install go
printf "\n\n install go \n\n"
./go_install.sh

# install rust
printf "\n\n install rust \n\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# create a directory for projects
printf "\n\n make $HOME/projects directory \n\n"
rm -rf $HOME/projects || true
mkdir $HOME/projects

# install docker
printf "\n\n install docker \n\n"
sh ./docker_install.sh

# install starship (prompt)
# this may fail on next fresh install
printf "\n\n install starship \n\n"
curl -sS https://starship.rs/install.sh | sh

# install ohmyzsh
printf "\n\n install oh-my-zsh \n\n"
rm -rf $HOME/.oh-my-zsh || true
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install bitwarden CLI
printf "\n\n install bitwarden \n\n"
npm install -g @bitwarden/cli

# install powerlevel10k theme
printf "\n\n install powerlevel10k \n\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# stow configs
printf "\n\n stow .dotfiles \n\n"
rm $HOME/.zshrc || true
cd $HOME/.dotfiles
stow nvim tmux zsh starship

# init zsh
printf "\n\n init ZSH \n\n"
source $HOME/.zshrc
zsh

# install govm
printf "\n\n install govm \n\n"
go install github.com/melkeydev/govm@latest

# install typescript globally (needed by pop shell install)
printf "\n\n install TS \n\n"
npm install --global typescript

# install yarn - needed for some neovim plugins
printf "\n\n install yarn -g \n\n"
npm install --global yarn

# install awsome fonts
printf "\n\n install fonts \n\n"
sh ./font_install.sh

printf "\n\n	You need to login again\n\n"
