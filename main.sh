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

# Set debug variables
source debug.sh

# Set up apt-get
eval "sudo $aptget update"
eval "sudo $aptget upgrade"
eval "sudo $aptget autoremove"

# # Install VirtualBox guest additions
# # FIXME Incomplete
# if $debug
# then
#     sudo apt-get -y install make
#     sudo mount -t iso9660 /dev/cdrom /media/cdrom
#     cd /media/cdrom
#     sudo sh ./VBoxLinuxAdditions.run
# else
#     sudo apt-get -y -qq install make
#     sudo mount -t iso9660 /dev/cdrom /media/cdrom # TODO Possibly silence
#     cd /media/cdrom
#     sudo sh ./VBoxLinuxAdditions.run # TODO Possibly silence
# fi
# cd ~

# Install pip and pip3
eval "sudo $aptget install curl"
eval "$curl https://bootstrap.pypa.io/get-pip.py | sudo python"
eval "$curl https://bootstrap.pypa.io/get-pip.py | sudo python3"

# Set up git and GitHub
eval "sudo $aptget install git git-flow git-doc git-email"
read -p "Enter email used for GitHub: " email
read -p "Enter GitHub username: " github_username
read -p "Enter a unique name for your GitHub key: " github_keyname
git config --global user.name "$github_username"
git config --global user.email "$email"

# Generate key and upload to GitHub
mkdir .ssh
eval "$sshkeygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa_github"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
eval "$curl -u $github_username --data '{"title":"'"$github_keyname"'","key":"'"$(cat ~/.ssh/id_rsa_github.pub)"'"}' https://api.github.com/user/keys"

# Install vim and vim-plug
# TODO Use either wget or curl, not both
eval "sudo $aptget install vim"
mkdir -p ~/.vim/colors
eval "$wget -O ~/.vim/colors/Tomorrow.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow.vim"
eval "$wget -O ~/.vim/colors/Tomorrow-Night.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim"
eval "$curl -fL -o ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# Get dotfiles
gitfunc() { $curl --head https://github.com/$github_username/dotfiles.git | head -n 1 | grep "HTTP/1.[01] [23].."; }
gitfunc2() { $curl --head https://github.com/$github_username/dotfiles/blob/master/vimrc | head -n 1 | $grep "HTTP/1.[01] [23].."; }
if gitfunc; then
    eval "$gitclone ssh://git@github.com/$github_username/dotfiles.git"
    if gitfunc2; then
        ln -s dotfiles/vimrc ~/.vimrc
    fi
fi

# Install vim plugins
vim +qall
vim +PlugInstall +qall

# Silence message of the day
touch ~/.hushlogin

# Set up zsh
eval "sudo $aptget install zsh zsh-doc"

# Set up oh-my-zsh (this must be the last command of this script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

