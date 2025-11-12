{
  description = "Modular system configurations";

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
      nixpkgs,
      ...
    }:
    let
      # Import the darwin system builder
      darwinLib = import ./modules/darwin { inherit inputs; };
      inherit (darwinLib) mkDarwinSystem;

      # Import host configurations
      workMacbookConfig = import ./hosts/work-macbook;

      # Supported systems for checks and formatters
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];

      # Helper to generate attributes for each system
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Helper to get nixpkgs for a system
      nixpkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      # Work computer
      darwinConfigurations.${workMacbookConfig.hostname} = mkDarwinSystem workMacbookConfig;

      # Validation checks for all systems
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          statix = pkgs.runCommand "statix-check" { nativeBuildInputs = [ pkgs.statix ]; } ''
            cd ${self}
            statix check .
            touch $out
          '';

          deadnix = pkgs.runCommand "deadnix-check" { nativeBuildInputs = [ pkgs.deadnix ]; } ''
            cd ${self}
            deadnix --fail .
            touch $out
          '';

          shellcheck = pkgs.runCommand "shellcheck-check" { nativeBuildInputs = [ pkgs.shellcheck ]; } ''
            cd ${self}
            # Check all bash scripts in scripts/ and .githooks/
            find scripts/ .githooks/ -type f \( -executable -o -name '*.sh' \) | while read -r script; do
              echo "Checking $script..."
              shellcheck "$script"
            done
            touch $out
          '';

          # Use nixfmt directly for checks (treefmt can't write in sandbox)
          formatting =
            pkgs.runCommand "formatting-check" { nativeBuildInputs = [ pkgs.nixfmt-rfc-style ]; }
              ''
                cd ${self}
                # Format all .nix files and check for changes
                find . -name '*.nix' -type f -not -path '*/flake.lock' -exec nixfmt --check {} +
                touch $out
              '';
        }
        # Only check darwin configurations on darwin systems
        // nixpkgs.lib.optionalAttrs (nixpkgs.lib.hasSuffix "darwin" system) {
          work-macbook = self.darwinConfigurations.${workMacbookConfig.hostname}.system;
        }
      );

      # Formatter for `nix fmt`
      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt-tree);
    };
}
