{ inputs, ... }:
{
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
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # System configuration
        (
          { pkgs, ... }:
          {
            nixpkgs.config.allowUnfree = true;
            programs.nix-index.enable = true;
            security.pam.services.sudo_local.touchIdAuth = true;
            system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
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
        inputs.home-manager.darwinModules.home-manager
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
            imports = [ ../home-common.nix ];
            home.stateVersion = homeStateVersion;
          };

          users.users.${username}.home = homeDirectory;
          system.primaryUser = username;

          # Disable nix-darwin's Nix management if an alternative Nix installer is in use
          # Both DeterminateSystems/nix-installer and NixOS/experimental-nix-installer
          # create /nix/receipt.json and manage their own daemon/services
          nix.enable = !builtins.pathExists /nix/receipt.json;
        }
      ];
    };
}
