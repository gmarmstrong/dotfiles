#!/usr/bin/env zsh

# Set directory environment variables
export dotfiles="$HOME/dotfiles"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Set $PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Set $TEXMFHOME
export TEXMFHOME="$XDG_DATA_HOME/texmf"

# Set w3m directory location
export WWW_HOME="$XDG_CONFIG_HOME/w3m"

# Set GnuPG directory location
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Set GPG_TTY
export GPG_TTY=$(tty)

# Set Android SDK location
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"

# Set RubyGems location
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

# Set $XINITRC
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# Set $EDITOR
export EDITOR="nvim"

# Set $ZDOTDIR
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set Vim locations
export VIMDOTDIR="$XDG_DATA_HOME/vim"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Set pass directories
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

# Set Taskwarrior directories
export TASKRC="$XDG_CONFIG_HOME/task/config"
export TASKDATA="$XDG_DATA_HOME/task/"
