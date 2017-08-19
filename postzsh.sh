#!/bin/bash

if curl -s --head https://github.com/$github_username/dotfiles/blob/master/zshrc | head -n 1 | grep -q "HTTP/1.[01] [23].."
then
    mv ~/.zshrc ~/.zshrc-omz-original
    ln -s dotfiles/zshrc-linux ~/.zshrc
    source ~/.zshrc
fi

