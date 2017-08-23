# debug.sh

# Toggle command verbosity
if $debug
then
    sshkeygen=(ssh-keygen)
    aptget=(apt-get -y)
    curl=(curl)
    wget=(wget)
    gitclone=(git clone)
    grep=(grep)
    ping=(ping)
else
    sshkeygen=(ssh-keygen -q)
    aptget=(apt-get -y -qq)
    curl=(curl --silent)
    wget=(wget -q)
    gitclone=(git clone -q)
    grep=(grep -q)
    ping=(ping -q)
fi

