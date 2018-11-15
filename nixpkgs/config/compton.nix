{ pkgs, config, ... }:

{
  services.compton = {
    enable = false;
    shadow = false;
    backend = "xrender";
    shadowExclude = [
      "window_type *= 'menu'"
      "name = 'polybar-basebar_eDP1'"
      "name = 'polybar-basebar_HDMI1'"
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
      respect-prop-shadow = true;
      xinerama-shadow-crop = true;
    '';
  };
}
