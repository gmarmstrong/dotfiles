{ pkgs, config, ... }:

{
  services.compton = {
    enable = false;
    shadow = true;
    backend = "xrender";
    shadowExclude = [ "window_type *= 'menu'" "class_g = 'Firefox' && argb" ];
    fadeExclude = [ "window_type *= 'menu'" "class_g = 'Firefox' && argb" ];
    extraOptions = ''
      no-dock-shadow = true;
      xrender-sync = true;
      xrender-sync-fence = true;
      unredir-if-possible = true;
      paint-on-overlay = true;
    '';
  };
}
