{ pkgs, config, ... }:

{
  programs.zsh = {

    # "Whether to enable Z shell."
    enable = true;

    # "Enable zsh completion."
    enableCompletion = true;

    # "Directory where the zsh configurations and more should be located."
    dotDir = ".config/zsh";

    # "Extra commands that should be added to .zshrc."
    initExtra = ''
      command -v nvim >/dev/null 2>&1 && alias vim="nvim" && alias vi="nvim"
      bindkey -v
      bindkey -M viins '^?' backward-delete-char
      bindkey -M viins 'jk' vi-cmd-mode
      bindkey -M vicmd 'k' history-beginning-search-backward
      bindkey -M vicmd 'j' history-beginning-search-forward
      export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
    '';

    oh-my-zsh = { # "Options to configure oh-my-zsh."
      enable = true; # "Whether to enable oh-my-zsh."
      plugins = [ "git" "pass" ]; # "List of oh-my-zsh plugins"
      theme = ""; # "Name of the theme to be used by oh-my-zsh."
    };

    # "Plugins to source in .zshrc."
    plugins = [
      {
        name = "async"; # "The name of the plugin."
        file = "async.zsh"; # "The plugin script to source."
        src = pkgs.fetchFromGitHub { # "Path to the plugin folder."
          owner = "sindresorhus";
          repo = "pure";
          rev = "a90b1bc04a2aecdb421493207080b88a6a2a414c";
          sha256 = "1agspki7p8v8ppw1102i9jnk5gawrj90va22m3wnpa1m2s6rqx01";
        };
      }
      {
        name = "pure"; # "The name of the plugin."
        file = "pure.zsh"; # "The plugin script to source."
        src = pkgs.fetchFromGitHub { # "Path to the plugin folder."
          owner = "sindresorhus";
          repo = "pure";
          rev = "a90b1bc04a2aecdb421493207080b88a6a2a414c";
          sha256 = "1agspki7p8v8ppw1102i9jnk5gawrj90va22m3wnpa1m2s6rqx01";
        };
      }
    ];

    # "Environment variables that will be set for zsh session."
    sessionVariables = {
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
      PATH = "$HOME/.local/bin/scripts:$PATH";
      dotfiles = "${config.home.homeDirectory}/dotfiles";
    };

    # "An attribute set that maps aliases to command strings or directly to
    # build outputs."
    shellAliases = {
      bup = "sudo rsync --verbose --delete-excluded -aAXv --exclude={\"/home/*/.cache/*\",\"/home/*/nextcloud\",\"/home/*/virtualbox\",\"/home/*/.local/share/Trash/*\",\"/home/*/.cache/mozilla/*/OfflineCache\",\"/home/*/.cache/mozilla/*/cache2\"} /home /run/media/$USER/ca3036f2-022d-4b6e-bb03-ed762403fd3b";
      l = "LC_COLLATE=C ls --group-directories-first -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --group-directories-first -FHA -w 80";
      ls = "LC_COLLATE=C ls --group-directories-first -FH -w 80";
      space = "find -maxdepth 1 -exec du -sh '{}' \\; | sort -h";
      suspace = "sudo find -maxdepth 1 -exec du -sh '{}' --exclude='proc' \\; | sort -h";
    };
  };
}
