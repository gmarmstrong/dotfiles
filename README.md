# post-install
Post-installation script for personal Debian virtual machines

## Instructions
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
