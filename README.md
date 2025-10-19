# dotfiles

This is my dotfiles repository. It describes my [NixOS](https://nixos.org/)
personal computers. [There are many like it](https://dotfiles.github.io/), but
this one is mine. [**You won't want to clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation on NixOS

1. Install Git with `nix-env -i git`
2. Clone these dotfiles with `git clone "git@github.com:gmarmstrong/dotfiles"
   "$HOME/dotfiles"`
3. Back up system configuration with `sudo mv /etc/nixos /etc/nixos.bak`
3. Symlink the system configuration with `sudo ln -s "$HOME/dotfiles/nixos"
   "/etc"`
4. Apply the system configuration with `sudo nixos-rebuild switch`
5. Symlink the user configuration with `ln -s "$HOME/dotfiles/nixpkgs/home.nix"
   "$HOME/.config/nixpkgs/home.nix"`
6. Install [home-manager](https://github.com/rycee/home-manager) with
   `nix-shell "$HOME/dotfiles/resources/home-manager" -A install`
7. Apply the home configuration with `home-manager switch`

## Installation on macOS

1. Install [Determinate Nix](https://determinate.systems/nix-installer/)
2. Clone these dotfiles to `~/dotfiles`
3. Run initial installation: `nix run nix-darwin -- switch --flake ~/dotfiles#`

Subsequent updates: use `scripts/system-update`
