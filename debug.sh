#!/bin/bash

# debug.sh

# Toggle command verbosity
if $debug
then
    export sshkeygen="ssh-keygen"
    export aptget="apt-get -y"
    export curl="curl"
    export wget="wget"
    export gitclone="git clone"
    export grep="grep"
    export ping="ping"
else
    export sshkeygen="ssh-keygen -q"
    export aptget="apt-get -y -qq"
    export curl="curl --silent"
    export wget="wget -q"
    export gitclone="git clone -q"
    export grep="grep -q"
    export ping="ping -q"
fi

