#!/bin/bash

# postzsh.sh

# Set default values
debug=false

# Check for debug flag
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -d|--debug)
            debug=true
            ;;
        *) # Do something with extra options
            echo "Unknown option '$key'"
            ;;
    esac
    shift # Shift after checking all cases to get the next option
done

# Set debug variables
source debug.sh

# Use zshrc from dotfiles repository
export github_username=$(git config --global user.name)
if [ -f dotfiles/zshrc ]; then
    mv ~/.zshrc ~/.zshrc-omz-original
    ln -s dotfiles/zshrc ~/.zshrc
    source ~/.zshrc
fi

# Install X11-related packages
eval "sudo $aptget -y install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro"

# Symlink X11-related dotfiles
if [ -f dotfiles/Xresources ]; then
    ln -s dotfiles/Xresources .Xresources
fi
if [ -f dotfiles/xinitrc ]; then
    ln -s dotfiles/xinitrc .xinitrc
fi
if [ -f dotfiles/i3/config ]; then
    mkdir -p .config/i3
    ln -s dotfiles/i3/config .config/i3/config
fi

# Force logout
sudo $aptget install killall
killall -u $(whoami)
