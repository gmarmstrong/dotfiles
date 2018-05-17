#!/usr/bin/env bash

# Confirm Linux operating system
if [[ ! "$OSTYPE" =~  linux* ]]; then
    echo "Operating system not Linux. Aborting."
    exit 1
fi

# Confirm Debian distribution
if [[ ! -f "/etc/debian_version" ]]; then
    echo "Distribution not Debian. Aborting."
    exit 1
fi

# Confirm Internet connection
if ! ping -c 1 google.com >& /dev/null; then
    echo "Internet connection failed. Aborting."
    exit 1
fi

sudo -v                 # Authenticate and update user's cached sudo credentials
sudo apt-get clean      # Clear local repository of retrieved package files
sudo apt-get autoremove # Remove unneeded automatically installed dependency packages
sudo apt-get update     # Resynchronize package index files from their sources
sudo apt-get upgrade    # Install newest versions of currently installed system packages
sudo apt-get check      # Check for broken dependencies
xargs sudo apt-get install < packages.txt	# Install packages from list

# Generate SSH key pair
if [[ ! -e "$HOME/.ssh/id_rsa" ]]; then
    mkdir -p "$HOME/.ssh"
    echo "Generating SSH key pair..."
    read -pr "Enter your email address: " email
    ssh-keygen -t rsa -b 4096 -C "$email"
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_rsa"
fi

# Authenticate with GitHub
if ! ssh -T git@github.com; then
    read -pr "Enter your GitHub username: " github_username
    echo "Uploading public key to GitHub..."
    read -pr "Enter a unique name for your key: " keyname
    myjson='{"title":"'"$keyname"'","key":"'"$(cat "$HOME/.ssh/id_rsa.pub")"'"}'
    eval "curl -u github_username --data '$myjson' https://api.github.com/user/keys"
fi

# Clone passwords
if [[ ! -d "$HOME/.password_store" ]]; then
    read -pr "Enter your password-store GitHub repository name " pw_repo
    git clone git@github.com:"$github_username"/"$pw_repo" "$HOME/.password-store"
fi

# Install Vim plugins
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PlugUpgrade +PlugUpdate +qall
# TODO Import PGP subkey (from where?)
