export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export ZSH=/Users/guthrie/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
plugins=(git git-flow osx)
source $ZSH/oh-my-zsh.sh
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/Personal\ files'
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

