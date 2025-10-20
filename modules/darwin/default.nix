{ inputs, ... }:
{
  # Helper function to create a macOS configuration
  mkDarwinSystem =
    {
      username,
      system ? "aarch64-darwin",
      gitName,
      gitEmail,
      gitSigningKey,
      capabilities ? [ ],
      managedDevice ? false,
      homeStateVersion,
      # Control whether nix-darwin manages the Nix installation (daemon, nix.conf, etc.)
      # Disable (manageNix = false) when using alternative Nix installers that manage
      # their own daemon and conflict with nix-darwin's Nix management, such as:
      #   - DeterminateSystems/nix-installer
      #   - NixOS/experimental-nix-installer
      # Keep enabled (default) for standard Nix installations.
      manageNix ? true,
      ...
    }:
    let
      homeDirectory = "/Users/${username}";
    in
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # System configuration
        (_: {
          nixpkgs.config.allowUnfree = true;
          programs.nix-index.enable = true;
          security.pam.services.sudo_local.touchIdAuth = true;
          system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
          system.stateVersion = 6;
        })

        # macOS defaults
        (_: {
          system.defaults = {
            controlcenter = {
              BatteryShowPercentage = true;
              Sound = true;
            };
            menuExtraClock = {
              ShowAMPM = true;
              ShowDate = 1;
              ShowDayOfWeek = true;
              ShowSeconds = true;
            };
            NSGlobalDomain = {
              AppleShowAllExtensions = true;
              "com.apple.mouse.tapBehavior" = 1;
            };
            finder = {
              NewWindowTarget = "Home";
              ShowPathbar = true;
              ShowStatusBar = true;
              _FXShowPosixPathInTitle = true;
              _FXSortFoldersFirst = true;
            };
            trackpad = {
              ActuationStrength = 0;
              Clicking = true;
            };
          };
        })

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
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit
                managedDevice
                capabilities
                gitName
                gitEmail
                gitSigningKey
                ;
            };
            users.${username} = {
              imports = [ ../home-common.nix ];
              home.stateVersion = homeStateVersion;
            };
          };

          users.users.${username}.home = homeDirectory;
          system.primaryUser = username;

          nix.enable = manageNix;
        }
      ];
    };
}
