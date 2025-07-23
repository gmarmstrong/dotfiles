#!/usr/bin/env bash

set -u

# Update dotfiles
git -C "$HOME/dotfiles" pull

# Update flake inputs
sudo nix flake update --flake "$HOME/.config/nix"

# Rebuild and apply config flake
sudo darwin-rebuild switch --flake "$HOME/.config/nix#mbp"

