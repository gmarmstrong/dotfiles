# Aliases
alias nike='ssh -x gma@nike.cs.uga.edu'
alias tree="tree -a -I '__pycache__|*.pyc|target|.git|.DS_Store|.Spotlight-V100|.Trashes|.sass-cache'"
alias new="newsbeuter -x reload print-unread"

# Add ~/bin to path
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:$PATH
fi

# oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Vi-like shell
bindkey -v
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

# Source secondary zshrc appropriate to operating system
case "$OSTYPE" in
    darwin*)    source ~/dotfiles/zshrc-macos ;;
    linux*)     source ~/dotfiles/zshrc-linux ;;
esac # WARNING: Code after this line will not (necessarily) be loaded.
