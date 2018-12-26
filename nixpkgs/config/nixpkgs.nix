{ pkgs, config, ... }:

{
  xdg.configFile.nixpkgsConfig = {
    target = "nixpkgs/config.nix";
    text = ''
      {
        allowUnfree = true;
        android_sdk.accept_license = true;
      }
    '';
  };
}
