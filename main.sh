#!/bin/bash

# TODO Optionally install X11, window manager, terminal emulator, and fonts, and then symlink X11 dotfiles
# TODO Install guest additions if machine is VirtualBox (install and check lshw for machine type)
# TODO Implement logging with variable verbosity

# Set up apt-get
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove

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
mkdir -p .vim/colors
wget https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow.vim
mv Tomorrow.vim .vim/colors
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

# Silence message of the day
touch ~/.hushlogin

# Set up zsh
sudo apt-get -y install zsh zsh-doc

# Set up oh-my-zsh (this must be the last command of this script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

