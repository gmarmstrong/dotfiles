#!/usr/bin/env zsh

# Save history to file
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"
setopt appendhistory # append history instead of overwriting
setopt sharehistory # share history across terminals
setopt incappendhistory # add to history immediately after command
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"

# Color scheme
BASE16_SHELL=$XDG_DATA_HOME/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Tab completion
zstyle ':completion:*' special-dirs true
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

# Prompt
if [ ! -d "$HOME/.zfunctions" ]; then
    mkdir -p "$HOME/.zfunctions"
fi
if [ ! -f "$HOME/.zfunctions/prompt_pure_setup" ]; then
    wget https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh -O "$HOME/.zfunctions/prompt_pure_setup"
fi
if [ ! -f "$HOME/.zfunctions/async" ]; then
    wget https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -O "$HOME/.zfunctions/async"
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

# Syntax highlighting
if [ ! -d "$HOME/.zfunctions/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zfunctions/zsh-syntax-highlighting"
fi
source "$HOME/.zfunctions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
