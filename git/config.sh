#!/usr/bin/env bash

# Comply with XDG Base Directory Specification
git_config_dir="$XDG_CONFIG_HOME/git"

# Reset Git config directory
rm -rf "$git_config_dir"
mkdir -p "$git_config_dir"

# Generate new git config
git config --file "$git_config_dir/config" user.name gmarmstrong
git config --file "$git_config_dir/config" user.email guthrie.armstrong@gmail.com
git config --file "$git_config_dir/config" core.excludesFile "$dotfiles/git/ignore"
git config --file "$git_config_dir/config" core.attributesFile "$dotfiles/git/attributes"
git config --file "$git_config_dir/config" diff.gpg.textconv "gpg --no-tty --decrypt --quiet"
git config --file "$git_config_dir/config" user.signingkey 100B37EAF2164C8B
git config --file "$git_config_dir/config" commit.gpgsign true
git config --file "$git_config_dir/config" gpg.program gpg
