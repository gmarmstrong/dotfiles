# dotfiles

This is my dotfiles repository. [There are many like
it](https://dotfiles.github.io/), but this one is mine. [**You won't want to
clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation

These installation steps are more conceptual than practical. There are
intermediary steps that go unmentioned for the sake of brevity.

1. [Fork this repository](https://help.github.com/articles/fork-a-repo/)
1. [Install NixOS](https://nixos.org/nixos/manual/index.html#ch-installation)
3. Install Git with `nix-env -i git`
4. Clone your fork with `git clone git@github.com:$(git config
   user.name)/dotfiles`
5. Symlink `nixos/configuration.nix` to `/etc/nixos/configuration.nix`
6. Apply the system configuration with `sudo nixos-rebuild switch`
7. Symlink `nixpkgs/home.nix` to `~/.config/nixpkgs/home.nix`
8. Install [home-manager](https://github.com/rycee/home-manager) with
   `nix-shell $HOME/dotfiles/home-manager -A install`
9. Apply the home configuration with `home-manager switch`
