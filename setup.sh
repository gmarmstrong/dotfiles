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

# Set up sudo
export user=$(whoami)
su root -c "apt-get -y -qq install sudo"
su root -c "adduser $user sudo"
