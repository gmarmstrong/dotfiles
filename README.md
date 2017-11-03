# dotfiles

This is my dotfiles repository. There are many like it, but this one is mine.

## Global settings

### `gitignore_global`

This file lists global [gitignore](https://git-scm.com/docs/gitignore) rules.
It can be placed or symlinked anywhere, but must be identified with `git config
--global core.excludesfile /path/to/gitignore_global` for Git to recognize it.

This file contains patterns which identify three types of files: confidential,
irrelevant, and compiled. Confidential data includes secret things like
`secring.*` and `id_rsa`. Irrelevant files include automatically generated
files that don't contain information worth saving or sharing (like `*.swp` and
`.DS_Store`.) Compiled files include executables and binary files like
`*.class` (Java output) and `.pdf` (LaTeX output) which can be recompiled from
the tracked source code.

### `janitor`

This file updates package managers. It's more of a maintenance script than a
configuration file. It currently handles `tlmgr`, `pip3`, `vim-plug`, `brew`,
and `apt-get`.

### `newsbeuter/`

These files configure [newsbeuter](https://github.com/akrennmair/newsbeuter), my RSS reader (newsbeuter is unmaintained, I need to switch to [newsboat](https://github.com/newsboat/newsboat)), and list the sites I follow. Its files can be symlinked into `~/.config/newsbeuter/` or into `~/.newsbeuter` (newsboat will use its own name).

### `vimrc`

This file [configures Vim](http://vimhelp.appspot.com/starting.txt.html#vimrc). It should be symlinked to `~/.vimrc`.

### `zshenv` and `zshrc`

These files [configure
Zsh](https://wiki.archlinux.org/index.php/Zsh#Configure_Zsh). The `zshrc` file
contains most settings, while `zshenv` contains vital settings that are loaded
even in non-interactive sessions. They should be symlinked to `~/.zshenv` and
`~/.zshrc`.

## macOS settings

### `Brewfile`

This file bundles [Homebrew](https://brew.sh/) dependencies. It should be symlinked to `~/Brewfile`. It contains five lists: `taps`, `brew`, `cask`, `fonts`, and `mas`.

### `macos`

TODO `macos` executes system setup tasks. It does not need to be symlinked.

## Linux settings

### `xinitrc`

TODO [`xinitrc`](https://wiki.archlinux.org/index.php/Xinit#xinitrc) configures X
startup.

### `Xresources`

TODO [`Xresources`](https://wiki.archlinux.org/index.php/X_resources) configures X
client applications.

### `i3/config`

TODO [`i3/config`](http://i3wm.org/docs/userguide.html#configuring) configures the
i3 window manager.
