export PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:$HOME/bin:/usr/local/bin:/usr/local/texlive/2016/bin/x86_64-darwin:/Applications/calibre.app/Contents/console.app/Contents/MacOS:$PATH
export ZSH=/Users/guthriearmstrong/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
alias vim='mvim'
alias julia='/Applications/Julia-0.5.app/Contents/Resources/julia/bin/julia'
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# When using bc, load math lib and ~/.bcrc
export BC_ENV_ARGS="-l $HOME/.bcrc"
export PATH="/usr/local/sbin:$PATH"

PATH="/Users/guthriearmstrong/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/guthriearmstrong/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/guthriearmstrong/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/guthriearmstrong/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/guthriearmstrong/perl5"; export PERL_MM_OPT;
