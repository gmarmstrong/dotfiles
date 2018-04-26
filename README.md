# dotfiles

This is my dotfiles repository. It defines a [NixOS](https://nixos.org/)
personal computer. [There are many like it](https://dotfiles.github.io/), but
this one is mine. [**You won't want to clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation

1. [Install NixOS](https://nixos.org/nixos/manual/index.html#ch-installation)
2. Install Git with `nix-env -i git`
3. Clone these dotfiles with `git clone git@github.com:gmarmstrong/dotfiles`
4. Symlink `nixos/configuration.nix` to `/etc/nixos/configuration.nix`
5. Apply the system configuration with `sudo nixos-rebuild switch`
6. Symlink `nixpkgs/home.nix` to `~/.config/nixpkgs/home.nix`
7. Install [home-manager](https://github.com/rycee/home-manager) with
   `nix-shell ~/dotfiles/home-manager -A install`
8. Apply the home configuration with `home-manager switch`
