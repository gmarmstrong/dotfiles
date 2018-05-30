{ pkgs, config, ... }:

{
  services.redshift = {

    # "Enable Redshift to change you screen's colour temperature depending on
    # the time of day."
    enable = true;

    # "Your current latitude, between -90.0 and 90.0."
    latitude = "33.9519";

    # "Your current longitude, between -180.0 and 180.0."
    longitude = "83.3576";

    # "Start the redshift-gtk tray applet."
    tray = true;
  };
}
