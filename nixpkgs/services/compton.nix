{ pkgs, config, ... }:

{
  services.compton = {

    # "Whether to enable Compton X11 compositor."
    enable = false;

    # "Draw window shadows."
    shadow = true;

    # "Backend to use: glx or xrender."
    backend = "xrender";

    # "List of conditions of windows that should have no shadow."
    shadowExclude = [ "window_type *= 'menu'" "class_g = 'Firefox' && argb" ];

    # "List of conditions of windows that should not be faded."
    fadeExclude = [ "window_type *= 'menu'" "class_g = 'Firefox' && argb" ];

    # "Additional Compton configuration."
    extraOptions = ''
      no-dock-shadow = true;
      xrender-sync = true;
      xrender-sync-fence = true;
      unredir-if-possible = true;
      paint-on-overlay = true;
    '';
  };
}
