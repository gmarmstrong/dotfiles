# Save history to file
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

function del() { mv "$@" ~/.Trash/; }

# antigen (does not seem to work on RHEL)
antigen_setup() {
    antigen use oh-my-zsh
    antigen bundle pass
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-syntax-highlighting
    if [[ $OSTYPE =~ darwin* ]]; then
        antigen bundle osx
    fi
    antigen theme refined
    antigen apply
}

# vi-like shell
vi_like_shell() {
    # See: man zshzle
    bindkey -v # generally be vi-like
    bindkey -M viins '^?' backward-delete-char # delete beyond initial character
    bindkey -M viins 'jk' vi-cmd-mode # exit vi insert mode with jk
    if [[ $OSTYPE = darwin* ]]; then
        bindkey -M vicmd 'k' history-substring-search-up # up with k in normal mode
        bindkey -M vicmd 'j' history-substring-search-down # down with j in normal mode
    fi
}

# Tab completion
zstyle ':completion:*' special-dirs true
autoload -Uz compinit
compinit

# System-specific settings
case "$OSTYPE" in
    darwin*)
        # Use iTerm2 shell integration
        export TERM="iterm2"

        # Use Homebrew antigen
        source /usr/local/share/antigen/antigen.zsh
        antigen_setup

        test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
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
            export TERM=linux
        fi
        ;;
esac

# Vi-like shell input
vi_like_shell

# Aliases
alias nike='ssh -x gma@nike.cs.uga.edu'
alias tree="tree -a -I '__pycache__|*.pyc|target|.git|.DS_Store|.Spotlight-V100|.Trashes|.sass-cache'"
alias new="newsbeuter -x reload print-unread"
alias ls="ls -FH"
alias ll="ls -FHA"
alias l="ls -FHAlh"
