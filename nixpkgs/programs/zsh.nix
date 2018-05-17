{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    dotDir = ".config/zsh";

    initExtra = ''
      command -v nvim >/dev/null 2>&1 && alias vim="nvim" && alias vi="nvim"
      bindkey -v
      bindkey -M viins '^?' backward-delete-char
      bindkey -M viins 'jk' vi-cmd-mode
      bindkey -M vicmd 'k' history-beginning-search-backward
      bindkey -M vicmd 'j' history-beginning-search-forward
      export GNUPGHOME="$XDG_DATA_HOME/gnupg"
      export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "pass" ];
      theme = "";
    };

    plugins = [
      {
        name = "async";
        file = "async.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "a90b1bc04a2aecdb421493207080b88a6a2a414c";
          sha256 = "1agspki7p8v8ppw1102i9jnk5gawrj90va22m3wnpa1m2s6rqx01";
        };
      }
      {
        name = "pure";
        file = "pure.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "a90b1bc04a2aecdb421493207080b88a6a2a414c";
          sha256 = "1agspki7p8v8ppw1102i9jnk5gawrj90va22m3wnpa1m2s6rqx01";
        };
      }
    ];

    sessionVariables = {
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
      PATH = "$HOME/.local/bin/scripts:$PATH";
      dotfiles = "${config.home.homeDirectory}/dotfiles";
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };

    shellAliases = {
      bup = "sudo rsync --verbose --delete-excluded -aAXv --exclude={\"/home/*/.cache/*\",\"/home/*/nextcloud\",\"/home/*/.local/share/Trash/*\"} /home /run/media/$USER/ca3036f2-022d-4b6e-bb03-ed762403fd3b";
      l = "LC_COLLATE=C ls --group-directories-first -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --group-directories-first -FHA -w 80";
      ls = "LC_COLLATE=C ls --group-directories-first -FH -w 80";
      space = "find -maxdepth 1 -exec du -sh '{}' \\; | sort -h";
      suspace = "sudo find -maxdepth 1 -exec du -sh '{}' --exclude='proc' \\; | sort -h";
    };
  };
}
