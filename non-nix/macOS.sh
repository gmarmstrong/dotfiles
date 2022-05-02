#!/usr/bin/env zsh

vimrc_src="$HOME/dotfiles/non-nix/vimrc"
vimrc_dest="$HOME/.vimrc"

zshrc_src="$HOME/dotfiles/non-nix/zshrc"
zshrc_dest="$HOME/.zshrc"

zhss_src="https://raw.githubusercontent.com/zsh-users/zsh-history-substring-search/4abed97b6e67eb5590b39bcd59080aa23192f25d/zsh-history-substring-search.zsh"
zhss_dest="$HOME/.zsh-history-substring-search.zsh"

# Link dotfiles
touch ~/.hushlogin

if [[ ! -L "$zshrc_dest" ]]; then
    ln -s "$zshrc_src" "$zshrc_dest"
fi

if [[ ! -L "$vimrc_dest" ]]; then
    ln -s "$vimrc_src" "$vimrc_dest"
fi

# Install zsh-history-substring-search
if [[ ! -e "$zhss_dest" ]]; then
    curl -fsSL "$zhss_src" > "$zhss_dest"
fi

