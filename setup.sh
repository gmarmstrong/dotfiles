#!/bin/bash

# setup.sh

# Test Debian
if ! [ -f "/etc/debian_version" ];
then
    echo Operating system not Debian, aborting.
    exit 1
fi

# Test connection
if ! ping -q -c 1 google.com
then
    echo Internet connection failed, aborting.
    exit 1
fi

# Download post-install scripts
wget -q https://raw.githubusercontent.com/gmarmstrong/post-install/master/main.sh
wget -q https://raw.githubusercontent.com/gmarmstrong/post-install/master/postzsh.sh

# Set up sudo
export user=$(whoami)
su root -c "apt-get -y -qq install sudo"
su root -c "adduser $user sudo"
