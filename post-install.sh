#!/bin/bash

# TODO Optionally install X11, window manager, terminal emulator, and fonts, and then symlink X11 dotfiles
# TODO Install guest additions if machine is VirtualBox (install and check lshw for machine type)
# TODO Implement logging with variable verbosity

# Test Debian
if ! [ -f "/etc/debian_version" ];
    echo Operating system not Debian, aborting.
    exit 1
fi

# Test connection
if ! ping -q -c 1 google.com
then
    echo Internet connection failed, aborting.
    exit 1
fi

# Set up sudo and apt-get
export user=$(whoami)
su
apt-get update
apt-get upgrade
apt-get autoremove
apt-get -y install sudo
adduser $user sudo
exit

# Join sudo group without logging in again or opening a new shell, then set default group as primary
newgrp sudo
newgrp -

# Install pip and pip3
sudo apt-get -y install curl
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python3

# Set up git and GitHub
sudo apt-get -y install git git-flow git-doc git-email
read -p "Enter email used for GitHub: " email
read -p "Enter GitHub username: " github_username
read -p "Enter a unique name for your GitHub key: " github_keyname
git config --global user.name "$github_username"
git config --global user.email "$email"

# Generate key and upload to GitHub
ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa_github
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
curl -u $github_username --data '{"title":"$github_keyname","key":"'"$(cat ~/.ssh/id_rsa_github.pub)"'"}' https://api.github.com/user/keys

# Install vim and vim-plug
sudo apt-get -y install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Get dotfiles
if curl -s --head https://github.com/$github_username/dotfiles.git | head -n 1 | grep -q "HTTP/1.[01] [23].."
then
    git clone ssh://git@github.com/$github_username/dotfiles.git
    if curl -s --head https://github.com/$github_username/dotfiles/blob/master/vimrc | head -n 1 | grep -q "HTTP/1.[01] [23].."
    then
        ln -s dotfiles/vimrc ~/.vimrc
    fi
fi

# Install vim plugins
vim +PlugInstall +qall

# Set up zsh
sudo apt-get -y install zsh zsh-doc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if curl -s --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | grep -q "HTTP/1.[01] [23].."
then
    mv ~/.zshrc ~/.zshrc-omz-original
    ln -s dotfiles/zshrc-linux ~/.zshrc
    source ~/.zshrc
fi

# Silence message of the day
touch ~/.hushlogin

