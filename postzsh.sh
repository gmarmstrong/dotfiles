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

# Toggle command verbosity
if $debug
then
    export aptget="apt-get -y"
    export curl="curl"
    export grep="grep"
else
    export aptget="apt-get -y -qq"
    export curl="curl --silent"
    export grep="grep -q"
fi

# Use zshrc from dotfiles repository
export github_username=$(git config --global user.name)
if $curl --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | $grep "HTTP/1.[01] [23].."
then
    mv ~/.zshrc ~/.zshrc-omz-original
    ln -s dotfiles/zshrc-linux ~/.zshrc
    source ~/.zshrc
fi

# Set up X11
sudo $aptget -y install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/xinitrc .xinitrc
mkdir -p .config/i3
ln -s dotfiles/i3/config .config/i3/config
