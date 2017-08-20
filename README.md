# post-install
Post-installation script for personal Debian virtual machines

## Instructions
Create a VirtualBox virtual machine and install Debian (64-bit) stable netinst (https://www.debian.org/CD/netinst/). Power off the system and insert VBoxGuestAdditions.iso into the IDE Secondary Master optical drive. Start the virtual machine and log in to the user account. Now run the following commands and respond to a few prompts along the way.
```
$ wget --no-check-certificate https://raw.githubusercontent.com/gmarmstrong/post-install/master/setup.sh
$ wget --no-check-certificate https://raw.githubusercontent.com/gmarmstrong/post-install/master/main.sh
$ wget --no-check-certificate https://raw.githubusercontent.com/gmarmstrong/post-install/master/postzsh.sh
$ bash setup.sh
$ newgrp sudo
$ newgrp -
$ bash main.sh
$ bash postzsh.sh
$ rm setup.sh main.sh postzsh.sh
```
