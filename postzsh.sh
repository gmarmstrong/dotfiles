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
gitfunc() { eval "$curl --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | $grep 'HTTP/1.[01] [23]..'"; }
if gitfunc; then
    mv ~/.zshrc ~/.zshrc-omz-original
    ln -s dotfiles/zshrc ~/.zshrc
    source ~/.zshrc
fi

# Set up X11
eval "sudo $aptget -y install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro"
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/xinitrc .xinitrc
mkdir -p .config/i3
ln -s dotfiles/i3/config .config/i3/config

# Force logout to change default shell
user=$(whoami)
killall -u $user
