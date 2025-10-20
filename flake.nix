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
          capabilities ? [ ],
          managedDevice ? false,
          homeStateVersion,
        }:
        let
          homeDirectory = "/Users/${username}";
        in
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            # System configuration
            (
              { pkgs, ... }:
              {
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

            # Additional macOS defaults for non-managed devices
            # (settings that MDM restricts on work computers)
            (
              { lib, ... }:
              lib.mkIf (!managedDevice) {
                system.defaults = {
                };
              }
            )

            # Home Manager
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  managedDevice
                  capabilities
                  gitName
                  gitEmail
                  gitSigningKey
                  ;
              };
              home-manager.users.${username} = {
                imports = [ ./modules/home-common.nix ];
                home.stateVersion = homeStateVersion;
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
        managedDevice = true;
        homeStateVersion = "25.05";
        gitName = "Guthrie McAfee Armstrong";
        gitEmail = "guthrie.armstrong@coalitioninc.com";
        gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFExjJSzkWHd1Qi92WE/AENwHKVRwPFfYo/K83LsIkQ7";
        capabilities = [
          "core"
          "container"
          "ai"
          "golang"
          "terraform"
          "aws"
        ];
      };
    };
}
