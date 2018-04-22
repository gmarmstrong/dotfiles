{ pkgs, config, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "33.9519";
    longitude = "83.3576";
    tray = true;
  };
}
