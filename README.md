# dotfiles

This is my dotfiles repository. It defines a [NixOS](https://nixos.org/)
personal computer. [There are many like it](https://dotfiles.github.io/), but
this one is mine. [**You won't want to clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation on NixOS

1. Install Git with `nix-env -i git`
2. Clone these dotfiles with `git clone "git@github.com:gmarmstrong/dotfiles"
   "$HOME/dotfiles"`
3. Symlink the system configuration with `ln -s
   "$HOME/dotfiles/nixos/configuration.nix" "/etc/nixos/configuration.nix"`
4. Apply the system configuration with `sudo nixos-rebuild switch`
5. Symlink the user configuration with `ln -s "$HOME/dotfiles/nixpkgs/home.nix"
   "$HOME/.config/nixpkgs/home.nix"`
6. Install [home-manager](https://github.com/rycee/home-manager) with
   `nix-shell "$HOME/dotfiles/home-manager" -A install`
7. Apply the home configuration with `home-manager switch`

## Routine maintenance

1. Upgrade system with `sudo nixos-rebuild switch --upgrade`
2. Upgrade user environment with `home-manager switch --upgrade`
3. Upgrade Neovim plugins with `nvim +PlugUpgrade +PlugUpdate +qall`
