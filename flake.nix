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
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # Import the darwin system builder
      darwinLib = import ./modules/darwin { inherit inputs; };
      mkDarwinSystem = darwinLib.mkDarwinSystem;

      # Import host configurations
      workMacbookConfig = import ./hosts/work-macbook;
    in
    {
      # Work computer
      darwinConfigurations.${workMacbookConfig.hostname} = mkDarwinSystem workMacbookConfig;

      # Validation checks
      checks.aarch64-darwin.work-macbook = self.darwinConfigurations.${workMacbookConfig.hostname}.system;

      # Formatter for `nix fmt`
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
