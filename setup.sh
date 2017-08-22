#!/bin/bash

# setup.sh

# Set default values
debug=false

# Check for debug flag
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -d|--debug)
            debug=true
            ;;
        *) # Do something with extra options
            echo "Unknown option '$key'"
            ;;
    esac
    shift # Shift after checking all cases to get the next option
done

# Test Debian
if ! [ -f "/etc/debian_version" ];
then
    echo Operating system not Debian, aborting.
    exit 1
fi

# Test connection
if $debug
then
    if ! ping -c 1 google.com
    then
        echo Internet connection failed, aborting.
        exit 1
    fi
else
    if ! ping -q -c 1 google.com
    then
        echo Internet connection failed, aborting.
        exit 1
    fi
fi

# Download post-install scripts
if $debug
then
    wget https://raw.githubusercontent.com/gmarmstrong/post-install/master/main.sh
    wget https://raw.githubusercontent.com/gmarmstrong/post-install/master/postzsh.sh
else
    wget -q https://raw.githubusercontent.com/gmarmstrong/post-install/master/main.sh
    wget -q https://raw.githubusercontent.com/gmarmstrong/post-install/master/postzsh.sh
fi

# Set up sudo
export user=$(whoami)
if $debug
then
    su root -c "apt-get -y install sudo"
    su root -c "adduser $user sudo"
else
    su root -c "apt-get -y -qq install sudo"
    su root -c "adduser $user sudo"
fi

