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

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # Helper function to create a macOS configuration
      mkDarwinSystem =
        {
          hostname,
          username,
          system ? "aarch64-darwin",
          gitName,
          gitEmail,
          gitSigningKey,
          isWorkMachine ? false,
        }:
        let
          homeDirectory = "/Users/${username}";

          # Common packages for all systems
          commonPackages = [
            "colima"
            "docker"
            "gh"
            "go"
            "golangci-lint"
            "nixfmt-rfc-style"
            "ollama"
            "shellcheck"
          ];

          # Work-specific packages
          workPackages = [
            "aws-vault"
            "awscli2"
            "ssm-session-manager-plugin"
            "tenv"
            "terraform-docs"
            "tflint"
          ];

          # Select packages based on machine type
          selectedPackages =
            commonPackages ++ (if isWorkMachine then workPackages else [ ]);

        in
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            # System configuration
            (
              { pkgs, ... }:
              {
                environment.systemPackages = [
                  pkgs.coreutils
                  pkgs.git
                  pkgs.jq
                  pkgs.ncdu
                  pkgs.smartmontools
                  pkgs.tree
                  pkgs.unixtools.watch
                  pkgs.wget
                  pkgs.zsh
                ];

                nixpkgs.config.allowUnfree = true;
                programs.nix-index.enable = true;
                security.pam.services.sudo_local.touchIdAuth = true;
                system.configurationRevision = self.rev or self.dirtyRev or null;
                system.stateVersion = 6;
              }
            )

            # macOS defaults
            (
              { ... }:
              {
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
              }
            )

            # Home Manager
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} =
                { pkgs, lib, ... }:
                {
                  home.packages = map (name: pkgs.${name}) selectedPackages;

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

                  home.sessionVariables = lib.mkIf isWorkMachine {
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

              users.users.${username}.home = homeDirectory;
              system.primaryUser = username;

              # Determinate Nix manages the Nix installation itself
              nix.enable = false;
            }
          ];
        };

    in
    {
      # Work computer
      darwinConfigurations."101206-F724N5WGX2" = mkDarwinSystem {
        hostname = "101206-F724N5WGX2";
        username = "guthrie";
        gitName = "Guthrie McAfee Armstrong";
        gitEmail = "guthrie.armstrong@coalitioninc.com";
        gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFExjJSzkWHd1Qi92WE/AENwHKVRwPFfYo/K83LsIkQ7";
        isWorkMachine = true;
      };
    };
}
