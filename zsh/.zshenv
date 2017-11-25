# Set $PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Set Android SDK location
export ANDROID_SDK_HOME="$HOME/.local/share/android"

# Set RubyGems location
export GEM_HOME="$HOME/.local/share/gem"
export GEM_SPEC_CACHE="$HOME/.cache/gem"

# Set $XINITRC
export XINITRC="$HOME/.config/X11/xinitrc"

# Set $EDITOR
export EDITOR="vim"

# Set $ZDOTDIR
export ZDOTDIR="$HOME/.config/zsh"

# Set Vim locations
export VIMDOTDIR="$HOME/.local/share/vim"
export VIMINIT='let $MYVIMRC="$HOME/.config/vim/vimrc" | source $MYVIMRC'

# Set pass directories
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Set Taskwarrior directories
export TASKRC="$HOME/.config/task/config"
export TASKDATA="$HOME/.local/share/task/"
