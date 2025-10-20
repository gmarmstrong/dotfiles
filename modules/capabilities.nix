{ pkgs, lib, ... }:

let
  # Capability-based package sets
  packageSets = {
    core = [
      "coreutils"
      "gh"
      "git"
      "jq"
      "ncdu"
      "nixfmt-rfc-style"
      "nixfmt-tree"
      "shellcheck"
      "smartmontools"
      "tree"
      "wget"
      "zsh"
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      "unixtools.watch"
    ];

    container = [
      "docker"
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      "colima"
    ];

    ai = [
      "ollama"
    ];

    golang = [
      "go"
      "golangci-lint"
    ];

    terraform = [
      "tenv"
      "terraform-docs"
      "tflint"
    ];

    aws = [
      "aws-vault"
      "awscli2"
      "ssm-session-manager-plugin"
    ];
  };
in
{
  inherit packageSets;

  # Helper function to collect packages based on requested capabilities
  collectPackages =
    capabilities: lib.lists.flatten (map (capability: packageSets.${capability} or [ ]) capabilities);
}
