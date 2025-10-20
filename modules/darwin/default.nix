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
          nix.enable = manageNix;
        }
      ];
    };
}
