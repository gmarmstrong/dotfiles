#!/bin/bash

# Comply with XDG Base Directory Specification
git_config_dir="$HOME/.config/git"

# Reset Git config directory
rm -rf "$git_config_dir"
mkdir -p "$git_config_dir"

git config --file "$git_config_dir/config" user.name gmarmstrong
git config --file "$git_config_dir/config" user.email guthrie.armstrong@gmail.com
git config --file "$git_config_dir/config" core.excludesFile "$HOME/dotfiles/git/ignore"
git config --file "$git_config_dir/config" core.attributesFile "$HOME/dotfiles/git/attributes"
git config --file "$git_config_dir/config" diff.gpg.textconv "gpg --no-tty --decrypt --quiet"