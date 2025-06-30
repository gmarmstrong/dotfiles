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
    configuration = { pkgs, ... }: {
      imports = [ home-manager.darwinModules.home-manager ];

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            pkgs.neovim
            pkgs.ollama
            pkgs.tenv
            pkgs.terraform-docs
            pkgs.tflint
            pkgs.awscli2
            pkgs.aws-vault
            pkgs.git
            pkgs.gh
            pkgs.smartmontools
            pkgs.wget
            pkgs.tree
            pkgs.zsh
        ];

      # Shell aliases
      environment.shellAliases = {
        vim = "nvim";
      };

      # Run ollama as a background service
      launchd.user.agents.ollama-serve = {
        command = "${pkgs.ollama}/bin/ollama serve";
        serviceConfig = {
          KeepAlive = true;
          RunAtLoad = true;
          StandardOutPath = "/tmp/ollama_guthrie.out.log";
          StandardErrorPath = "/tmp/ollama_guthrie.err.log";
        };
      };

      # Since we're using Determinate Nix
      nix.enable = false;

      # Allow non-FOSS packages
      nixpkgs.config.allowUnfree = true;

      # Enable nix-index and its command-not-found helper
      programs.nix-index.enable = true;

      programs.zsh.shellInit = "source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";

      # Define users
      users.users."guthrie" = {
        home = "/Users/guthrie";
      };

      # System preferences
      system.primaryUser = "guthrie";
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
        # These don't seem to work unless done manually:
        # trackpad.ActuationStrength = 0; # 0 for silent clicking
        # trackpad.Clicking = true; # tap trackpad to click
      };

      # Enable Touch ID for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # home-manager configuration
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."guthrie" = { pkgs, ... }: {
        home.stateVersion = "25.05";
        home.username = "guthrie";
        home.homeDirectory = "/Users/guthrie";
        programs.git = {
          enable = true;
          userName = "Guthrie McAfee Armstrong";
          userEmail = "guthrie.armstrong@coalitioninc.com";
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
