{
  pkgs,
  lib,
  config,
  capabilities,
  gitName,
  gitEmail,
  gitSigningKey,
  managedDevice,
  ...
}:

let
  capabilitiesModule = import ./capabilities.nix { inherit pkgs lib managedDevice; };
  selectedPackages = capabilitiesModule.collectPackages capabilities;
in
{
  home = {
    packages = selectedPackages;

    file.".hushlogin".text = "";

    # https://nix-community.github.io/home-manager/options.xhtml#opt-home.shell.enableZshIntegration
    shell.enableZshIntegration = true;

    sessionPath = [ "${config.home.homeDirectory}/dotfiles/scripts" ];

    sessionVariables = lib.mkIf (lib.elem "terraform" capabilities) {
      TF_PLUGIN_CACHE_DIR = "${config.home.homeDirectory}/.terraform.d/plugin-cache";
    };
  };

  programs = {
    git = {
      enable = true;
      userName = gitName;
      userEmail = gitEmail;
      signing = {
        format = "ssh";
        key = gitSigningKey;
        signByDefault = true;
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      extraConfig = {
        pull.rebase = true;
      };
    };

    ssh = {
      enable = true;
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      matchBlocks."*" = {
        identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
      };
    };

    neovim = {
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

    zsh = {
      enable = true;
      defaultKeymap = "viins";
      historySubstringSearch = {
        enable = true;
      };
      localVariables = {
        HISTORY_SUBSTRING_SEARCH_PREFIXED = true;
      };
      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.initContent
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
  };

  services.ollama.enable = pkgs.stdenv.isDarwin && lib.elem "ai" capabilities;
}
