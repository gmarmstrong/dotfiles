{ pkgs, config, ... }:

{
  services.redshift = {
    enable = false;
    latitude = "33.9519";
    longitude = "83.3576";
    tray = true;
    temperature.day = 6500;
  };
}
