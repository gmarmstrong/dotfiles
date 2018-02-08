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

# Prompt
if [ ! -f "$HOME/.zfunctions/prompt_pure_setup" ]; then
    wget https://github.com/sindresorhus/pure/blob/master/pure.zsh -O "$HOME/.zfunctions/prompt_pure_setup"
fi
if [ ! -f "$HOME/.zfunctions/async" ]; then
    wget https://github.com/sindresorhus/pure/blob/master/async.zsh -O "$HOME/.zfunctions/async"
fi
fpath=( "$HOME/.zfunctions" $fpath )
autoload -Uz promptinit
promptinit
prompt pure

# Vi-like shell input
# See: `man zshzle`
bindkey -v # generally be vi-like
bindkey -M viins '^?' backward-delete-char # delete beyond initial character
bindkey -M viins 'jk' vi-cmd-mode # exit vi insert mode with jk
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

source $XDG_CONFIG_HOME/zsh/.zaliases
