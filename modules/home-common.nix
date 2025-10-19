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
  getPackage = name:
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
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
    '';
  };

  services.ollama = {
    enable = builtins.elem "ai" capabilities;
  };

  home.stateVersion = "25.05";
}

