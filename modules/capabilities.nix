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
      pkgs.git
      pkgs.jq
      pkgs.ncdu
      pkgs.nixfmt-rfc-style
      pkgs.nixfmt-tree
      pkgs.shellcheck
      pkgs.smartmontools
      pkgs.tree
      pkgs.wget
      pkgs.zsh
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

    gui = lib.optionals (!managedDevice) [
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
