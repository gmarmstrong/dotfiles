#!/bin/bash

# Check macOS
if uname | grep -vq Darwin;
then
    echo "ERROR: Operating system is not macOS. Aborting."
    exit 1
else
    # Prevent buyer's remorse, stage one
    echo "Congrats on the new Mac! 😃"
fi

# Check Internet connection
if ! ping -c 1 google.com >& /dev/null;
then
    echo "Internet connection failed. Aborting."
    exit 1
else
    echo "Internet connection successful."
fi

# Disable the "Last login" message
if ! [ -f ~/.hushlogin ]
then
    echo "Disabling the \"Last login\" message."
    touch ~/.hushlogin
fi

# Collect GitHub information and configure Git
read -p "Enter email used for GitHub: " email
read -p "Enter GitHub username: " github_username
git config --global user.name "$github_username"
git config --global user.email "$email"

# Generate key and upload to GitHub
if ! [ -f ~/.ssh/id_rsa ] # Check that no key exists
then
    echo "Generating key."
    mkdir .ssh >& /dev/null
    read -p "Enter a unique name for your GitHub key: " github_keyname
    ssh-keygen -q -t rsa -b 4096 -C "$email" -f "~/.ssh/id_rsa"
    eval "$(ssh-agent -s)" &> /dev/null
    ssh-add "~/.ssh/id_rsa" &> /dev/null
    myjson='{"title":"'"$github_keyname"'","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}'
    echo "Uploading public key to GitHub."
    eval "curl --silent -u $github_username --data '$myjson' https://api.github.com/user/keys"
else
    echo "Key already exists."
fi

# Clone dotfiles repository
if ! [ -e ~/dotfiles ]
then
    echo "Downloading dotfiles."
    git clone git@github.com:gmarmstrong/dotfiles.git
fi

# # Clone scripts repository
# if ! [ -e ~/scripts ]
# then
#     echo "Downloading scripts."
#     git clone git@github.com:gmarmstrong/scripts.git
# fi
#
# # Clone applescripts repository
# if ! [ -e ~/applescripts ]
# then
#     echo "Downloading AppleScripts."
#     git clone git@github.com:gmarmstrong/applescripts.git
# fi

# Install Homebrew
if test ! $(which brew)
then
    echo "Installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew already installed."
fi

# Download all programs
echo "Downloading and updating programs."
brew update
brew upgrade
brew bundle

# Install oh-my-zsh
if ! [ -e ~/.oh-my-zsh ]
then
    echo "Installing oh-my-zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
# FIXME Everything after this point needs to be in a separate script
exit 0

# Symlink dotfiles
echo "Symlinking dotfiles."
mv ~/.zshrc ~/.zshrc-omz
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/zshenv ~/.zshenv
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

# Install zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Point Git to global exclusion file
git config --global core.excludesfile ~/.gitignore_global

# Install vim-plug and plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +qall
vim +PlugInstall +qall

# Prevent buyer's remorse, stage two
echo "All done. Enjoy! 😊"
