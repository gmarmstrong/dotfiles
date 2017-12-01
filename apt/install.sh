#!/bin/bash
xargs -a "$dotfiles/apt/packages.txt" sudo apt-get install
