{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "nike" = {
        hostname = "nike.cs.uga.edu";
        user = "gma";
        forwardX11 = true;
        forwardX11Trusted = true;
      };
    };
    extraConfig = "AddKeysToAgent yes";
  };
}
