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

# Use zshrc from dotfiles repository
if $debug
then
    export github_username=$(git config --global user.name)
    if curl --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | grep "HTTP/1.[01] [23].."
    then
        mv ~/.zshrc ~/.zshrc-omz-original
        ln -s dotfiles/zshrc-linux ~/.zshrc
        source ~/.zshrc
    fi
else
    export github_username=$(git config --global user.name)
    if curl -s --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | grep -q "HTTP/1.[01] [23].."
    then
        mv ~/.zshrc ~/.zshrc-omz-original
        ln -s dotfiles/zshrc-linux ~/.zshrc
        source ~/.zshrc
    fi
fi

# Set up X11
if $debug
then
    sudo apt-get -y install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro
else
    sudo apt-get -y -qq install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro
fi
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/xinitrc .xinitrc
mkdir -p .config/i3
ln -s dotfiles/i3/config .config/i3/config

