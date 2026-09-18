# Initialization code that may require console input (password prompts,
# confirmations, etc.) must go above this block; everything else may go below.

# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/Applications:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    git
    history-substring-search
    fzf
    ssh-agent
    aws
    nvm
    golang
    node
    sdk
    mvn
)

# ssh-agent config
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities id_rsa id_ed25519
zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent quiet yes

# ------------------------------------------------------------
# NVM
# ------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

zstyle :omz:plugins:nvm lazy yes

# ------------------------------------------------------------
# Rust
# ------------------------------------------------------------

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ------------------------------------------------------------
# Oh My Zsh initialization
# ------------------------------------------------------------

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------
# Keyboard / history
# ------------------------------------------------------------

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey -e

# ------------------------------------------------------------
# Neovim
# ------------------------------------------------------------

# export MANPAGER='nvim --appimage-extract-and-run -c "set ft=man"'
# export MANPATH="/usr/local/man:$MANPATH"

# ------------------------------------------------------------
# Go
# ------------------------------------------------------------

export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
export PATH="$HOME/.govm/shim:$PATH"

# ------------------------------------------------------------
# Pico SDK
# ------------------------------------------------------------

export PICO_SDK_PATH="$HOME/pico/pico-sdk"

# ------------------------------------------------------------
# Android SDK
# ------------------------------------------------------------

export ANDROID_HOME="$HOME/Android/Sdk"

export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# ------------------------------------------------------------
# Android Studio
# ------------------------------------------------------------

export PATH="$PATH:$HOME/android-studio/bin"

# ------------------------------------------------------------
# Java
# ------------------------------------------------------------

if command -v java >/dev/null 2>&1; then
    export JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
    export PATH="$PATH:$JAVA_HOME/bin"
fi

# ------------------------------------------------------------
# ESP-IDF
# ------------------------------------------------------------

alias get_idf='. "$HOME/esp/esp-idf/export.sh"'

# ------------------------------------------------------------
# Utilities
# ------------------------------------------------------------

webm2gif() {
    ffmpeg -y -i "$1" -vf palettegen palette.png
    ffmpeg -y -i "$1" -i palette.png \
        -filter_complex paletteuse \
        -r 10 \
        "${1%.webm}.gif"
    rm -f palette.png
}

# ------------------------------------------------------------
# Editor
# ------------------------------------------------------------

if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR="vim"
else
    export EDITOR="nvim"
fi

# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------

alias freecad="$HOME/Applications/freecad"

alias ll='ls -alF'
alias lg='lazygit'

# ------------------------------------------------------------
# Starship
# ------------------------------------------------------------

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# ------------------------------------------------------------
# SDKMAN
#
# This must remain near the end of the file.
# ------------------------------------------------------------

export SDKMAN_DIR="$HOME/.sdkman"

if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# ------------------------------------------------------------
# Google Cloud SDK
# ------------------------------------------------------------

if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
