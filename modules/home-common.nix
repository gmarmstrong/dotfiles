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

    # Ghostty configuration
    file.".config/ghostty/config".text = ''
      # Ghostty configuration
      # See https://ghostty.org/docs/config for all options

      # Theme configuration
      # On macOS: automatically switches between light/dark themes based on system appearance
      # On Linux: defaults to dark theme
      theme = light:GitHub Light High Contrast,dark:GitHub Dark High Contrast

      # Font configuration
      font-family = DejaVu Sans Mono
      font-size = 14

      # Window padding
      window-padding-x = 10
      window-padding-y = 10
    '';

    # https://nix-community.github.io/home-manager/options.xhtml#opt-home.shell.enableZshIntegration
    shell.enableZshIntegration = true;

    sessionPath = [
      "${config.home.homeDirectory}/dotfiles/scripts"
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];

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
        identityAgent = ''"${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
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

  targets.darwin.defaults = lib.mkIf pkgs.stdenv.isDarwin {
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
      Sound = true;
    };
    "com.apple.menuextra.clock" = {
      ShowAMPM = true;
      ShowDate = 1;
      ShowDayOfWeek = true;
      ShowSeconds = true;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      "com.apple.mouse.tapBehavior" = 1;
    };
    "com.apple.finder" = {
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };
    "com.apple.AppleMultitouchTrackpad" = {
      ActuationStrength = 0;
      Clicking = true;
    };
  };

  services.ollama.enable = pkgs.stdenv.isDarwin && lib.elem "ai" capabilities;
}
