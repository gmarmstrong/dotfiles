#!/bin/bash

# System maintenance script

sudo tlmgr update --self
sudo tlmgr update --all

# Upgrade all Python 3 packages
# See https://stackoverflow.com/a/3452888/6791398
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install --quiet --upgrade

if [ -d ~/.vim/plugged ]; then
    vim +PlugInstall +qall
fi

# Operating-specific actions
case "$OSTYPE in
    darwin*)
        brew upgrade
        brew update
        brew bundle
        brew bundle check
        brew doctor
        brew style
        brew prune
        mas upgrade
        ;;
    linux*)
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get clean
        sudo apt-get autoremove
        sudo apt-get check
        ;;
esac
