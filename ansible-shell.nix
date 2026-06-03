{
  pkgs ? import <nixpkgs> { },
}:

let
  python = pkgs.python314.withPackages (
    ps: with ps; [
      boto3
      botocore
    ]
  );
in
pkgs.mkShell {
  packages = [
    python
  ];
}
