# Save history to file
HISTFILE="$HOME/.zsh_history"

# Add ~/bin to path
if [ -d $HOME/bin ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add ~/.zfunctions to $fpath
fpath=( "$HOME/.zfunctions" $fpath )

# Aliases
alias nike='ssh -x gma@nike.cs.uga.edu'
alias tree="tree -a -I '__pycache__|*.pyc|target|.git|.DS_Store|.Spotlight-V100|.Trashes|.sass-cache'"
alias new="newsbeuter -x reload print-unread"
alias ls="ls -FH"
alias ll="ls -FHA"
alias l="ls -FHAlh"

function del() { mv "$@" ~/.Trash/; }

# Vi-like shell
bindkey -v
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode

# pure zsh prompt
autoload -U promptinit; promptinit
prompt pure

# System-specific settings
case "$OSTYPE" in
    darwin*)
        # Add python3 to PATH
        export PATH="/usr/local/opt/python/libexec/bin:$PATH"

        # Set TERM to iTerm2
        export TERM="iterm2"

        # iTerm2 shell integration
        test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

        ;;
    linux*)
        # Set appropriate TERM
        if (ps -e | grep X)
        then
            export TERM=rxvt-unicode-256color
        else
            export TERM=xterm-256color
        fi
        ;;
esac
