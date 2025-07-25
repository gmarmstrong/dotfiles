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
      # Minimal system-level packages
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

      # Used for backwards compatibility; read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
    };

    # macOS-specific settings
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
        # These ones require a restart (or maybe a re-login):
        trackpad.ActuationStrength = 0; # 0 for silent clicking
        trackpad.Clicking = true; # tap trackpad to click
      };
    };

    # home-manager config
    homeManagerConfig = { pkgs, ... }: {
      home.packages = with pkgs; [
        # Dev tools
        aws-vault
        awscli2
        colima
        docker # required by colima
        gh
        git
        go
        ollama
        tree
        wget
        zsh

        # Terraform
        tenv
        terraform-docs
        tflint
      ];

      # User-specific Git settings
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

      # disable MotD
      home.file.".hushlogin".text = "";

      # zsh config and plugins
      home.shell.enableZshIntegration = true;
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

      # ollama service
      services.ollama = {
        enable = true;
      };

      # State version for home-manager
      home.stateVersion = "25.05";
    };

  in
  {
    # MacBook Pro for work
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        # Import the modularized configs
        systemConfig
        macOSConfig

        # Import the main home-manager module
        home-manager.darwinModules.home-manager
        {
          # Configure home-manager settings
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = homeManagerConfig;

          # Define the primary user for the system
          users.users.${username}.home = homeDirectory;
          system.primaryUser = username;

          # Set this to false if you're not using the Nix installer managed by nix-darwin
          # (e.g., if you opted for Determinate Nix instead of vanilla Nix)
          nix.enable = false;
        }
      ];
    };
  };
}
