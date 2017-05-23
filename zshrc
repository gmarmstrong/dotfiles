# Zsh configuration
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh
plugins=(git git-flow osx)

# Don't let zsh set the terminal title
DISABLE_AUTO_TITLE="true"

# Use vi mode with jk bound to <esc>
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# When using bc, load math lib and ~/.bcrc
export BC_ENV_ARGS="-l $HOME/.bcrc"
export PATH="/usr/local/sbin:$PATH"

# iCloud shortcut (macOS only)
alias icloud='cd /Users/guthriearmstrong/Library/Mobile\ Documents/com\~apple\~CloudDocs/Personal\ files'
