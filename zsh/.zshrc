# Display Timewarrior and Taskwarrior status
if command -v timew >& /dev/null; then
    timew
fi
if command -v task >& /dev/null; then
    todo_count=$(task status:pending and \(+OVERDUE or due:today or due:tomorrow\) count)
    echo "You have $todo_count tasks due soon."
fi

# Save history to file
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"

BASE16_SHELL=$XDG_DATA_HOME/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Tab completion
zstyle ':completion:*' special-dirs true
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

# Use system antigen
if [ -e /usr/share/zsh-antigen ]
then
    export ADOTDIR=$XDG_DATA_HOME/antigen
    source /usr/share/zsh-antigen/antigen.zsh
    antigen use oh-my-zsh
    antigen theme robbyrussell
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle pass
    antigen apply
fi

# Vi-like shell input
# See: `man zshzle`
bindkey -v # generally be vi-like
bindkey -M viins '^?' backward-delete-char # delete beyond initial character
bindkey -M viins 'jk' vi-cmd-mode # exit vi insert mode with jk
if command -v history-substring-search-up >& /dev/null; then
    bindkey -M vicmd 'k' history-substring-search-up # up with k in normal mode
fi
if command -v history-substring-search-down >& /dev/null; then
    bindkey -M vicmd 'j' history-substring-search-down # down with j in normal mode
fi

source $XDG_CONFIG_HOME/zsh/.zaliases
