#!/bin/bash

# main.sh

# TODO Implement logging with variable verbosity

# Set up apt-get
sudo apt-get -y -qq update
sudo apt-get -y -qq upgrade
sudo apt-get -y -qq autoremove

# Install VirtualBox guest additions
# FIXME Incomplete
sudo apt-get -qq install make
sudo mount -t iso9660 /dev/cdrom /media/cdrom
cd /media/cdrom
sudo sh ./VBoxLinuxAdditions.run
cd ~

# Install pip and pip3
sudo apt-get -y -qq install curl
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python3

# Set up git and GitHub
sudo apt-get -y -qq install git git-flow git-doc git-email
read -p "Enter email used for GitHub: " email
read -p "Enter GitHub username: " github_username
read -p "Enter a unique name for your GitHub key: " github_keyname
git config --global user.name "$github_username"
git config --global user.email "$email"

# Generate key and upload to GitHub
ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa_github
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
curl -u $github_username --data '{"title":"'"$github_keyname"'","key":"'"$(cat ~/.ssh/id_rsa_github.pub)"'"}' https://api.github.com/user/keys

# Install vim and vim-plug
sudo apt-get -y -qq install vim
mkdir -p ~/.vim/colors
wget -q -O ~/.vim/colors/Tomorrow.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow.vim
wget -q -O ~/.vim/colors/Tomorrow-Night.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim
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
vim +qall
vim +PlugInstall +qall

# Silence message of the day
touch ~/.hushlogin

# Set up zsh
sudo apt-get -y -qq install zsh zsh-doc

# Set up oh-my-zsh (this must be the last command of this script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

