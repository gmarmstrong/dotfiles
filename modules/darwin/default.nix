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
          programs.zsh.enable = true; # Declaratively manage system-level zsh files
          security.pam.services.sudo_local.touchIdAuth = true;

          networking = inputs.nixpkgs.lib.mkIf (!managedDevice) {
            hostName = hostname;
            computerName = hostname;
          };

          # Homebrew configuration
          homebrew = {
            enable = true;
            onActivation = {
              cleanup = "zap";
              autoUpdate = true;
              upgrade = true;
            };
            casks = [
              "codex"
            ];
          };

          system = {
            primaryUser = username;
            configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
            stateVersion = 6;

            # Automatically handle macOS-restored files that conflict with nix-darwin
            # macOS updates often restore default /etc/zshrc and /etc/zprofile
            activationScripts.preActivation.text = ''
              # Handle files that macOS updates may restore
              for file in /etc/zshrc /etc/zprofile; do
                if [ -f "$file" ] && [ ! -L "$file" ]; then
                  echo "Moving macOS-restored $file to $file.bak"
                  mv -f "$file" "$file.bak"
                fi
              done
            '';
          };
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
