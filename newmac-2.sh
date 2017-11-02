#!/bin/bash

# Move ~/.zshrc if not symlinked (i.e., if oh-my-zsh was just installed)
if ! [ -h ~/.zshrc ]
then
    echo "~/.zshrc was not a symbolic link. Moved it to ~/.zshrc-old."
    mv ~/.zshrc ~/.zshrc-old
fi

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

# Install base16-tomorrow.itermcolors
wget https://raw.githubusercontent.com/martinlindhe/base16-iterm2/master/itermcolors/base16-tomorrow.itermcolors
open base16-tomorrow.itermcolors
rm base16-tomorrow.itermcolors

# Install base16-shell
if [ ! -d "$HOME/.config/base16-shell" ]; then
    git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"
fi

# Install zsh-history-substring-search
if ! [ -e ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]
then
    "Installing zsh-history-substring-search."
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

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
