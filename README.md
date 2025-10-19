# dotfiles

This is my dotfiles repository. It uses [Nix](https://nixos.org/) with flakes
to manage my macOS system configuration. [There are many like
it](https://dotfiles.github.io/), but this one is mine. [**You won't want to
clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation on macOS

1. Install [Determinate Nix](https://determinate.systems/nix-installer/)
2. Clone these dotfiles to `~/dotfiles`
3. Run initial installation: `nix run nix-darwin -- switch --flake ~/dotfiles#`

Subsequent updates: use `system-update`
