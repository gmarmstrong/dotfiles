#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Update dotfiles
printf "\n\033[1m>> Updating dotfiles...\033[0m\n\n"
git -C "$HOME/dotfiles" pull

# Update flake inputs
printf "\n\033[1m>> Updating config flake inputs...\033[0m\n\n"
nix flake update --flake "$HOME/.config/nix"

# Rebuild and apply config flake
printf "\n\033[1m>> Rebuilding and applying config flake...\033[0m\n\n"
sudo darwin-rebuild switch --flake "$HOME/.config/nix#mbp"

