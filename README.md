# post-install
Post-installation script for personal Debian virtual machines

## Instructions
Create a VirtualBox virtual machine and install Debian (64-bit) stable netinst (https://www.debian.org/CD/netinst/). Power off the system and insert VBoxGuestAdditions.iso into the IDE Secondary Master optical drive. Start the virtual machine and log in to the user account. Now run the following commands and respond to a few prompts along the way.
```
$ wget https://goo.gl/iYPSNz -O setup.sh
$ wget https://goo.gl/zQCqoW -O debug.sh
$ bash setup.sh
$ newgrp sudo
$ newgrp -
$ bash main.sh
$ zsh postzsh.sh
$ rm setup.sh main.sh postzsh.sh debug.sh
```
Finally, `startx`!

## Troubleshooting
A few things to note:
* This project is still in early development.
* Most questions can be easily answered by reading the source code.
* You can use the `-d` or `--debug` flags when running the scripts to increase verbosity.
