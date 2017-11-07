# Save history to file
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"

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

# antigen
antigen_setup() {
    antigen use oh-my-zsh
    antigen bundle zsh-users/zsh-history-substring-search
    antigen apply
}

# pure zsh prompt
autoload -U promptinit; promptinit
prompt pure

# System-specific settings
case "$OSTYPE" in
    darwin*)
        # Use iTerm2 shell integration
        export TERM="iterm2"

        # Use Homebrew antigen
        source /usr/local/share/antigen/antigen.zsh
        ;;
    linux*)
        # Set appropriate TERM
        if (ps -e | grep X)
        then
            if [ command -v rxvt-unicode-256color ]
            then
                export TERM=rxvt-unicode-256color
            else
                export TERM=xterm-256color
            fi
        elif [ $SSH_CLIENT ]
        then
            export TERM=$TERM
        else
            export TERM=xterm
        fi
        source "$HOME/.antigen.zsh"
        ;;
esac

antigen_setup
vi_like_shell
