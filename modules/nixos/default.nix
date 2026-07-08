{ inputs, ... }:
{
  # Helper function to create a NixOS configuration
  mkNixosSystem =
    {
      hostname,
      username,
      system ? "x86_64-linux",
      gitName,
      gitEmail,
      gitSigningKey,
      shellAliases ? { },
      capabilities ? [ ],
      managedDevice ? false,
      homeStateVersion,
      systemStateVersion,
      hardwareModules ? [ ],
      cpuVendor ? null,
      desktop ? true,
      timeZone ? "America/New_York",
      ...
    }:
    let
      inherit (inputs.nixpkgs) lib;
      homeDirectory = "/home/${username}";
      hasCapability = capability: lib.elem capability capabilities;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = hardwareModules ++ [
        (_: {
          nixpkgs.config.allowUnfree = true;

          system = {
            configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
            stateVersion = systemStateVersion;
          };

          nix.settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
          };

          boot = {
            kernelPackages = lib.mkDefault inputs.nixpkgs.legacyPackages.${system}.linuxPackages_latest;
            loader = {
              systemd-boot.enable = lib.mkDefault true;
              efi.canTouchEfiVariables = lib.mkDefault true;
            };
          };

          networking = {
            hostName = hostname;
            networkmanager.enable = true;
          };

          time.timeZone = timeZone;
          i18n.defaultLocale = "en_US.UTF-8";

          hardware = {
            bluetooth = {
              enable = true;
              powerOnBoot = true;
            };
            cpu = {
              amd.updateMicrocode = lib.mkIf (cpuVendor == "amd") true;
              intel.updateMicrocode = lib.mkIf (cpuVendor == "intel") true;
            };
            enableRedistributableFirmware = true;
            graphics.enable = true;
          };

          services = {
            fwupd.enable = true;
            power-profiles-daemon.enable = true;
            thermald.enable = lib.mkDefault (cpuVendor == "intel");
            xserver = lib.mkIf desktop {
              enable = true;
              displayManager.gdm.enable = true;
              desktopManager.gnome.enable = true;
            };
            pipewire = {
              enable = true;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
            };
            printing.enable = desktop;
            ollama.enable = hasCapability "local-ai";
          };

          security.rtkit.enable = true;

          virtualisation.docker.enable = hasCapability "container";

          programs = {
            command-not-found.enable = false;
            zsh.enable = true;
            nix-index.enable = true;
          };

          users.users.${username} = {
            isNormalUser = true;
            description = gitName;
            extraGroups = [
              "audio"
              "networkmanager"
              "video"
              "wheel"
            ]
            ++ lib.optionals (hasCapability "container") [
              "docker"
            ];
            shell = inputs.nixpkgs.legacyPackages.${system}.zsh;
          };
        })

        inputs.home-manager.nixosModules.home-manager
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
                shellAliases
                ;
            };
            users.${username} = {
              imports = [ ../home-common.nix ];
              home = {
                inherit homeDirectory;
                stateVersion = homeStateVersion;
              };
            };
          };
        }
      ];
    };
}
