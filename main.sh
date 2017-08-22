#!/bin/bash

# main.sh

# TODO Link ssh config

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

# Set up apt-get
if $debug
then
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y autoremove
else
    sudo apt-get -y -qq update
    sudo apt-get -y -qq upgrade
    sudo apt-get -y -qq autoremove
fi

# Install VirtualBox guest additions
# FIXME Incomplete
if $debug
then
    sudo apt-get -y install make
    sudo mount -t iso9660 /dev/cdrom /media/cdrom
    cd /media/cdrom
    sudo sh ./VBoxLinuxAdditions.run
else
    sudo apt-get -y -qq install make
    sudo mount -t iso9660 /dev/cdrom /media/cdrom # TODO Possibly silence
    cd /media/cdrom
    sudo sh ./VBoxLinuxAdditions.run # TODO Possibly silence
fi
cd ~

# Install pip and pip3
if $debug
then
    sudo apt-get -y install curl
    curl https://bootstrap.pypa.io/get-pip.py | sudo python
    curl https://bootstrap.pypa.io/get-pip.py | sudo python3
else
    sudo apt-get -y -qq install curl
    curl --silent https://bootstrap.pypa.io/get-pip.py | sudo python
    curl --silent https://bootstrap.pypa.io/get-pip.py | sudo python3
fi

# Set up git and GitHub
if $debug
then
    sudo apt-get -y install git git-flow git-doc git-email
else
    sudo apt-get -y -qq install git git-flow git-doc git-email
fi
read -p "Enter email used for GitHub: " email
read -p "Enter GitHub username: " github_username
read -p "Enter a unique name for your GitHub key: " github_keyname
git config --global user.name "$github_username"
git config --global user.email "$email"

# Generate key and upload to GitHub
if $debug
then
    mkdir .ssh
    ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa_github
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa_github
    curl -u -${github_username} --data '{"title":"'"$github_keyname"'","key":"'"$(cat ~/.ssh/id_rsa_github.pub)"'"}' https://api.github.com/user/keys
else
    mkdir .ssh
    ssh-keygen -q -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa_github
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa_github
    curl -s -u ${github_username} --data '{"title":"'"$github_keyname"'","key":"'"$(cat ~/.ssh/id_rsa_github.pub)"'"}' https://api.github.com/user/keys
fi

# Install vim and vim-plug
# TODO Use either wget or curl, not both
if $debug
then
    sudo apt-get -y install vim
    mkdir -p ~/.vim/colors
    wget -O ~/.vim/colors/Tomorrow.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow.vim
    wget -O ~/.vim/colors/Tomorrow-Night.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    sudo apt-get -y -qq install vim
    mkdir -p ~/.vim/colors
    wget -q -O ~/.vim/colors/Tomorrow.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow.vim
    wget -q -O ~/.vim/colors/Tomorrow-Night.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim
    curl -fLo --silent ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Get dotfiles
if $debug
then
    if curl --head https://github.com/${github_username}/dotfiles.git | head -n 1 | grep -q "HTTP/1.[01] [23].."
    then
        git clone ssh://git@github.com/${github_username}/dotfiles.git
        if curl --head https://github.com/${github_username}/dotfiles/blob/master/vimrc | head -n 1 | grep "HTTP/1.[01] [23].."
        then
            ln -s dotfiles/vimrc ~/.vimrc
        fi
    fi
else
    if curl -s --head https://github.com/${github_username}/dotfiles.git | head -n 1 | grep -q "HTTP/1.[01] [23].."
    then
        git -q clone ssh://git@github.com/${github_username}/dotfiles.git
        if curl -s --head https://github.com/${github_username}/dotfiles/blob/master/vimrc | head -n 1 | grep -q "HTTP/1.[01] [23].."
        then
            ln -s dotfiles/vimrc ~/.vimrc
        fi
    fi
fi

# Install vim plugins
vim +qall
vim +PlugInstall +qall

# Silence message of the day
touch ~/.hushlogin

# Set up zsh
if $debug
then
    sudo apt-get -y install zsh zsh-doc
else
    sudo apt-get -y -qq install zsh zsh-doc
fi

# Set up oh-my-zsh (this must be the last command of this script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

