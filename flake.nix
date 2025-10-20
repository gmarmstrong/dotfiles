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
    in
    {
      # Work computer
      darwinConfigurations.${workMacbookConfig.hostname} = mkDarwinSystem workMacbookConfig;

      # Validation checks
      checks.aarch64-darwin = {
        work-macbook = self.darwinConfigurations.${workMacbookConfig.hostname}.system;

        statix =
          nixpkgs.legacyPackages.aarch64-darwin.runCommand "statix-check"
            {
              nativeBuildInputs = [ nixpkgs.legacyPackages.aarch64-darwin.statix ];
            }
            ''
              cd ${self}
              statix check .
              touch $out
            '';

        deadnix =
          nixpkgs.legacyPackages.aarch64-darwin.runCommand "deadnix-check"
            {
              nativeBuildInputs = [ nixpkgs.legacyPackages.aarch64-darwin.deadnix ];
            }
            ''
              cd ${self}
              deadnix --fail .
              touch $out
            '';
      };

      # Formatter for `nix fmt`
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
