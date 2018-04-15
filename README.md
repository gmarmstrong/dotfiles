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
10. Reload the X resources with `xrdb -load ~/.Xresources`

## Explore

```
dotfiles git/master
❯ tree
.
```

### Git

```
├── git/
│   ├── attributes
│   └── ignore
```

* `git/attributes` defines the `$GIT_DIR/info/gitattributes` file (see `man gitattributes`)
* `git/ignore` defines the `$GIT_DIR/info/exclude` file (see `man gitignore` and [github/gitignore](https://github.com/github/gitignore))

### Home Manager

```
├── home-manager/
```

* submodule of [rycee/home-manager](https://github.com/rycee/home-manager)

### MIT License

```
├── LICENSE
```

* licensed under the [MIT License](https://opensource.org/licenses/MIT)

### NixOS configuration

```
├── nixos/
│   └── configuration.nix
```

* [NixOS](https://nixos.org) configuration file (see [NixOS Manual](https://nixos.org/nixos/manual)), should be symlinked to `/etc/nixos/configuration.nix`

### Home Manager configuration

```
├── nixpkgs/
```

#### `home` options

```
│   ├── home
│   │   ├── file.nix
│   │   └── packages.nix
```

* `home.file` defines an attribute set of files to link into the user home
* `home.packages` defines the set of packages to appear in the user environment

#### Home configuration

```
│   ├── home.nix
```

* primary Home Manager configuration, should be symlinked to `~/.config/nixpkgs/home.nix`
* imports other Home Manager configuration files

##### Program configurations

```
│   ├── programs
│   │   ├── fzf.nix
│   │   ├── git.nix
│   │   ├── htop.nix
│   │   ├── rofi.nix
│   │   └── zsh.nix
```

* defines configuration for [`fzf`](https://github.com/junegunn/fzf), [`git-config`](https://git-scm.com/docs/git-config), [`htop`](https://github.com/hishamhm/htop), [`rofi`](https://github.com/DaveDavenport/rofi), and [`zsh`](https://www.zsh.org/)

##### Service configurations

```
│   ├── services
│   │   ├── compton.nix
│   │   └── polybar.nix
```

* configures the [`compton`](https://github.com/chjj/compton) X11 compositor
* configures the [`polybar`](https://github.com/jaagr/polybar) status bar

#### Xresources

```
│   ├── xresources.nix
```

* configures the X resources and imports a color scheme

#### i3

```
│   └── xsession
│       └── windowManager
│           └── i3.nix
```

* configures the [`i3-gaps`](https://github.com/Airblader/i3) window manager
* defines keybindings, color scheme, and multi-monitor options

### Neovim

```
├── nvim
│   ├── ftplugin
│   │   ├── go.vim
│   │   ├── haskell.vim
│   │   ├── html.vim
│   │   ├── latex.vim
│   │   ├── mail.vim
│   │   ├── markdown.vim
│   │   ├── python.vim
│   │   ├── rst.vim
│   │   ├── sh.vim
│   │   ├── text.vim
│   │   └── zsh.vim
│   └── init.vim
```

* configures the [Neovim](https://neovim.io/) text editor

### ranger

```
├── ranger
│   ├── commands.py
│   ├── rc.conf
│   ├── rifle.conf
│   └── scope.sh
```

* configures the [`ranger`](https://github.com/ranger/ranger) file manager

### README

```
├── README.md
```

* you're reading it

### XDG User Directories

```
└── xdg
    └── user-dirs.dirs
```

* mostly just tells Firefox to stop creating `~/Downloads/`
* symlinked to `~/.config/user-dirs.dirs`
