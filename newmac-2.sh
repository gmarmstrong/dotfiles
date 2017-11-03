#!/bin/bash

# Symlink dotfiles
echo "Symlinking dotfiles."
ln -s ~/dotfiles/zshrc ~/.zshrc >& /dev/null
ln -s ~/dotfiles/vimrc ~/.vimrc >& /dev/null
ln -s ~/dotfiles/zshenv ~/.zshenv >& /dev/null
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global >& /dev/null

# Symlink iCloud Drive
if ! [ -d ~/iCloud ]
then
    echo "Creating iCloud Drive shortcut."
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Personal ~/iCloud
fi

# Point Git to global exclusion file
git config --global core.excludesfile ~/.gitignore_global

# Install vim-plug
if ! [ -e ~/.vim/autoload/plug.vim ]
then
    echo "Installing vim-plug."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Vim plugins
echo "Installing Vim plugins."
vim +qall
vim +PlugInstall +qall

# Prevent buyer's remorse, stage two
echo "All done. Enjoy! 😊"
