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
      theme = "refined";
    };

    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      GOPATH = "$HOME/go";
      dotfiles = "$HOME/dotfiles";
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };

    shellAliases = {
      bup = "sudo rsync --verbose --delete-excluded -aAXv --exclude={\"/home/*/.cache/*\",\"/home/*/nextcloud\",\"/home/*/.local/share/Trash/*\"} /home /run/media/$USER/ca3036f2-022d-4b6e-bb03-ed762403fd3b";
      l = "LC_COLLATE=C ls --color=auto -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --color=auto -FHA -w 80";
      ls = "LC_COLLATE=C ls --color=auto -FH -w 80";
      nike = "ssh -x gma@nike.cs.uga.edu";
      nikex = "ssh -Y gma@nike.cs.uga.edu";
      space = "find -maxdepth 1 -exec du -sh '{}' \; | sort -h";
      suspace = "sudo find -maxdepth 1 -exec du -sh '{}' \; | sort -h";
    };
  };
}
