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
    echo "ERROR: Internet connection failed. Aborting."
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
# TODO Only do this if Git is not configured.
read -p "Enter email used for GitHub: " gh_email
read -p "Enter GitHub username: " github_username
git config --global user.name "$github_username"
git config --global user.email "$gh_email"

# Generate key and upload to GitHub
mkdir ~/.ssh
if ! [ -e ~/.ssh/id_rsa ] # Check that no key exists
then
    echo "Generating key."
    read -p "Enter a unique name for your GitHub key: " github_keyname
    echo "Generating SSH key."
    ssh-keygen -q -t rsa -b 4096 -C "$gh_email"
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

# Clone scripts repository
if ! [ -e ~/scripts ]
then
    echo "Downloading scripts."
    git clone git@github.com:gmarmstrong/scripts.git
fi

# Clone applescripts repository
if ! [ -e ~/applescripts ]
then
    echo "Downloading AppleScripts."
    git clone git@github.com:gmarmstrong/applescripts.git
fi

# Install Homebrew
if test ! $(which brew)
then
    echo "Installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew already installed."
fi

# Sign in to Mac App Store
# TODO Skip if already signed in to Mac App Store
echo "Signing in to the Mac App Store"
brew install mas
read -p "Enter email used for Mac App Store: " mas_email
mas signin "$(mas_email)"

# Download all programs
echo "Downloading and updating programs."
brew update
brew upgrade
brew bundle

# Download OpenVPN configuration files (for Private Internet Access)
if [ -e "/Applications/Tunnelblick.app" ]
then
    echo "Downloading OpenVPN configuration files."
    open "/Applications/Tunnelblick.app"
    wget https://www.privateinternetaccess.com/openvpn/openvpn.zip
    unzip openvpn.zip -d openvpn
    open openvpn/*
    rm openvpn.zip
    # TODO Automate this. Watch how Tunnelblick does it (each configuration gets its own subdirectory.)
    echo "Opened the configuration files for manual installation."
    echo "You can delete ~/openvpn/ when you're done."
fi

# Install oh-my-zsh
if ! [ -e ~/.oh-my-zsh ]
then
    echo "Installing oh-my-zsh."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
