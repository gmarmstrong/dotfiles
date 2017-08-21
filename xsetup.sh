#!/bin/bash

# xsetup.sh

sudo apt-get -y -qq install i3 suckless-tools rxvt-unicode-256color xinit xorg ttf-anonymous-pro
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/xinitrc .xinitrc
ln -s dotfiles/i3/config .config/i3/config

