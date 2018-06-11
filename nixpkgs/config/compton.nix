{ pkgs, config, ... }:

{
  services.compton = {
    enable = true;
    shadow = false;
    backend = "xrender";
    shadowExclude = [
      "window_type *= 'menu'"
      "name = 'polybar-topbar_eDP1'"
      "name = 'polybar-altbar_HDMI1'"
      "class_g = 'Firefox' && argb"
      "focused = 0"
    ];
    fadeExclude = [
      "window_type *= 'menu'"
      "class_g = 'Firefox' && argb"
    ];
    extraOptions = ''
      no-dock-shadow = true;
      xrender-sync = true;
      xrender-sync-fence = true;
      unredir-if-possible = true;
      paint-on-overlay = true;
      respect-prop-shadow = true;
      xinerama-shadow-crop = true;
    '';
  };
}
