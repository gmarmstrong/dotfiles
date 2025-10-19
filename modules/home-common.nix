{
  pkgs,
  lib,
  capabilities,
  gitName,
  gitEmail,
  gitSigningKey,
  managedDevice,
  ...
}:

let
  capabilitiesModule = import ./capabilities.nix { inherit pkgs lib; };
  selectedPackages = capabilitiesModule.collectPackages capabilities;

  # Helper to resolve nested package paths like "unixtools.watch"
  getPackage =
    name:
    let
      parts = lib.splitString "." name;
    in
    lib.getAttrFromPath parts pkgs;
in
{
  home.packages = map getPackage selectedPackages;

  programs.git = {
    enable = true;
    userName = gitName;
    userEmail = gitEmail;
    signing = {
      format = "ssh";
      key = gitSigningKey;
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    extraConfig = {
      pull.rebase = true;
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-characterize
      vim-surround
      vim-repeat
    ];
    extraConfig = ''
      set expandtab
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      inoremap jk <Esc>
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file.".hushlogin".text = "";
  home.shell.enableZshIntegration = true;

  home.sessionPath = [ "$HOME/dotfiles/scripts" ];

  home.sessionVariables = lib.mkIf (builtins.elem "terraform" capabilities) {
    TF_PLUGIN_CACHE_DIR = "$HOME/.terraform.d/plugin-cache";
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    historySubstringSearch = {
      enable = true;
    };
    localVariables = {
      HISTORY_SUBSTRING_SEARCH_PREFIXED = true;
    };
    initContent = ''
      bindkey jk vi-cmd-mode
      bindkey -M viins '^?' backward-delete-char
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # Git prompt with dirty indicator
      autoload -Uz vcs_info
      precmd_vcs_info() { vcs_info }
      precmd_functions+=( precmd_vcs_info )
      setopt prompt_subst
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' unstagedstr '*'
      zstyle ':vcs_info:*' stagedstr '*'
      zstyle ':vcs_info:git:*' formats ' (%b%u%c)'
      zstyle ':vcs_info:git:*' actionformats ' (%b%u%c %a)'
      PROMPT='%~''${vcs_info_msg_0_} %# '
    '';
  };

  services.ollama = {
    enable = builtins.elem "ai" capabilities;
  };

  home.stateVersion = "25.05";
}
