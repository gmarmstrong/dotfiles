{
  pkgs,
  lib,
  managedDevice,
  ...
}:

let
  # Capability-based package sets
  packageSets = {
    core = [
      pkgs.coreutils
      pkgs.gh
      pkgs.jq
      pkgs.ncdu
      pkgs.nixfmt-tree
      pkgs.shellcheck
      pkgs.smartmontools
      pkgs.tree
      pkgs.wget
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      pkgs.unixtools.watch
    ]
    ++ lib.optionals (!managedDevice) [
      pkgs._1password
    ];

    container = [
      pkgs.docker
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      pkgs.colima
    ];

    ai = [
      pkgs.ollama
    ];

    golang = [
      pkgs.go
      pkgs.golangci-lint
    ];

    terraform = [
      pkgs.tenv
      pkgs.terraform-docs
      pkgs.tflint
    ];

    aws = [
      pkgs.aws-vault
      pkgs.awscli2
      pkgs.ssm-session-manager-plugin
    ];

    gui = [
      # Blocked (on macOS) by https://github.com/NixOS/nixpkgs/blob/6faeb062ee4cf4f105989d490831713cc5a43ee1/pkgs/by-name/gh/ghostty/package.nix#L191
      # pkgs.ghostty
      pkgs.dejavu_fonts
      pkgs.source-code-pro
    ]
    ++ lib.optionals (!managedDevice) [
      pkgs._1password-gui
    ];
  };
in
{
  inherit packageSets;

  # Helper function to collect packages based on requested capabilities
  collectPackages =
    capabilities: lib.concatMap (capability: packageSets.${capability} or [ ]) capabilities;
}
