# Operating system agnostic configs
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

# Zsh configuration
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# History by substring
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Vi-like shell
bindkey -v
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Aliases
alias nike='ssh gma@nike.cs.uga.edu'
alias gmarmstrong='ssh guthrie@gmarmstrong.org'
alias tree="tree -a -I '__pycache__|.git|*.pyc'"

# Add ~/bin to path
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:$PATH
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Source secondary zshrc appropriate to operating system
case "$OSTYPE" in
    darwin*)    source dotfiles/zshrc-macos ;;
    linux*)     source dotfiles/zshrc-linux ;;
esac

