# Operating system agnostic configs
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME=robbyrussell
source $ZSH/oh-my-zsh.sh

# Custom functions
function trash() { mv "$@" ~/.Trash } # FIXME

# Vi-like shell
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# SSH aliases
alias nike='ssh gma@nike.cs.uga.edu'
alias gmarmstrong='ssh guthrie@gmarmstrong.org'

# Add ~/bin to path
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:$PATH
fi

# Source zshrc appropriate to operating system
case "$OSTYPE" in
    darwin*)    source dotfiles/zshrc-macos ;;
    linux*)     source dotfiles/zshrc-linux ;;
esac


