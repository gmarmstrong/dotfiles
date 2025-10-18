{
  description = "Custom nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    username = "guthrie";
    homeDirectory = "/Users/${username}";

    systemConfig = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.smartmontools
        pkgs.ncdu
      ];

      # Allow non-FOSS packages
      nixpkgs.config.allowUnfree = true;

      # Enable nix-index for command-not-found lookups
      programs.nix-index.enable = true;

      # Enable Touch ID for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.stateVersion = 6;
    };

    macOSConfig = { ... }: {
      system.defaults = {
        controlcenter.BatteryShowPercentage = true;
        controlcenter.Sound = true;
        menuExtraClock.ShowAMPM = true;
        menuExtraClock.ShowDate = 1;
        menuExtraClock.ShowDayOfWeek = true;
        menuExtraClock.ShowSeconds = true;
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
        finder.NewWindowTarget = "Home";
        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;
        finder._FXShowPosixPathInTitle = true;
        finder._FXSortFoldersFirst = true;
        trackpad.ActuationStrength = 0;
        trackpad.Clicking = true;
      };
    };

    homeManagerConfig = { pkgs, ... }: {
      home.packages = [
        pkgs.aws-vault
        pkgs.awscli2
        pkgs.ssm-session-manager-plugin
        pkgs.colima
        pkgs.docker
        pkgs.gh
        pkgs.git
        pkgs.go
        pkgs.golangci-lint
        pkgs.jq
        pkgs.ollama
        pkgs.shellcheck
        pkgs.tree
        pkgs.wget
        pkgs.zsh
        pkgs.unixtools.watch
        pkgs.tenv
        pkgs.terraform-docs
        pkgs.tflint
      ];


      programs.git = {
        enable = true;
        userName = "Guthrie McAfee Armstrong";
        userEmail = "guthrie.armstrong@coalitioninc.com";
        signing = {
          format = "ssh";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFExjJSzkWHd1Qi92WE/AENwHKVRwPFfYo/K83LsIkQ7";
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
      
      home.sessionPath = [
        "$HOME/dotfiles/scripts"
      ];

      home.sessionVariables = {
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
        enable = true;
      };
      home.stateVersion = "25.05";
    };

  in
  {
    # Work computer
    darwinConfigurations."101206-F724N5WGX2" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        systemConfig
        macOSConfig
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = homeManagerConfig;
          users.users.${username}.home = homeDirectory;
          system.primaryUser = username;

          # Determinate Nix manages the Nix installation itself, so disable nix-darwin’s own Nix management.
          # https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#prerequisites
          nix.enable = false;
        }
      ];
    };
  };
}
