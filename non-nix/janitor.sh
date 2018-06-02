#!/usr/bin/env bash

# Confirm essential programs
command -v curl || echo "MISSING: curl" || exit
command -v git || echo "MISSING: git" || exit
command -v gpg2 || echo "MISSING: gpg2" || exit
command -v vim || echo "MISSING: vim" || exit
command -v ssh || echo "MISSING: ssh" || exit

# Confirm Internet connection
if ! ping -c 1 google.com >& /dev/null; then
    echo "Internet connection failed. Aborting."
    exit 1
fi

# Link dotfiles
ln -s "$HOME/dotfiles/non-nix/bashrc" "$HOME/.bashrc"
ln -s "$HOME/dotfiles/non-nix/inputrc" "$HOME/.inputrc"
ln -s "$HOME/dotfiles/non-nix/vimrc" "$HOME/.vimrc"

# Generate SSH key pair
if [[ ! -e "$HOME/.ssh/id_rsa" ]]; then
    mkdir -p "$HOME/.ssh"
    echo "Generating SSH key pair..."
    read -rp "Enter your email address: " email
    ssh-keygen -t rsa -b 4096 -C "$email"
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_rsa"
fi

# Authenticate with GitHub
if ssh -T git@github.com; then
    read -rp "Enter your GitHub username: " github_username
    echo "Uploading public key to GitHub..."
    read -rp "Enter a unique name for your key: " keyname
    myjson='{"title":"'"$keyname"'","key":"'"$(cat "$HOME/.ssh/id_rsa.pub")"'"}'
    eval "curl -u ${github_username} --data '$myjson' https://api.github.com/user/keys"
fi

# Install vim-plug
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins
vim +qall
vim +PlugUpgrade +PlugUpdate +qall
