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

# Set debug variables
source debug.sh

# Test Debian
if ! [ -f "/etc/debian_version" ];
then
    echo Operating system not Debian, aborting.
    exit 1
fi

# Test connection
if ! $ping -c 1 google.com
then
    echo Internet connection failed, aborting.
    exit 1
fi

# Download post-install scripts
$wget https://raw.githubusercontent.com/gmarmstrong/post-install/master/main.sh
$wget https://raw.githubusercontent.com/gmarmstrong/post-install/master/postzsh.sh

# Set up sudo
export user=$(whoami)
su root -c "$aptget -y install sudo"
su root -c "adduser $user sudo"

