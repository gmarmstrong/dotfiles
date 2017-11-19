# Save history to file
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.local/share/zsh/zsh_history"
export LESSHISTFILE="$HOME/.cache/less/history"
export LESSKEY="$HOME/.config/less/keys"

# Vim XDG conventions
export VIMDOTDIR="$HOME/.local/share/vim"
export VIMINIT='let $MYVIMRC="$HOME/.config/vim/vimrc" | source $MYVIMRC'

# password-store XDG conventions
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Taskwarrior XDG conventions
export TASKRC="$HOME/.config/task/config"
export TASKDATA="$HOME/.local/share/task/"

BASE16_SHELL=$HOME/.local/share/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Tab completion
zstyle ':completion:*' special-dirs true
autoload -Uz compinit
compinit -d $HOME/.cache/zsh/zcompdump

# Use system antigen
if [ -e /usr/share/zsh-antigen ]
then
    export ADOTDIR=$HOME/.local/share/antigen
    source /usr/share/zsh-antigen/antigen.zsh
    antigen use oh-my-zsh
    antigen bundle pass
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen apply
fi

# Set appropriate TERM
if (ps -e | grep X) &> /dev/null
then
    if command -v urxvt > /dev/null
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

# Vi-like shell input
# See: `man zshzle`
bindkey -v # generally be vi-like
bindkey -M viins '^?' backward-delete-char # delete beyond initial character
bindkey -M viins 'jk' vi-cmd-mode # exit vi insert mode with jk
bindkey -M vicmd 'k' history-substring-search-up # up with k in normal mode
bindkey -M vicmd 'j' history-substring-search-down # down with j in normal mode

# Aliases
alias nike='ssh -x gma@nike.cs.uga.edu'
alias nikex='ssh -Y gma@nike.cs.uga.edu'
alias tree="tree -a -I '__pycache__|*.pyc|target|.git|.sass-cache'"
alias new="newsboat -x reload print-unread"
alias news="newsboat"
alias ls="LC_COLLATE=C ls -GFH -w 80"
alias ll="LC_COLLATE=C ls -GFHA -w 80"
alias l="LC_COLLATE=C ls -GFHAlh -w 80"
alias feh="feh --image-bg black --scale-down --auto-zoom"

function rm() {
    echo "Woah, there! Use trash instead."
}
