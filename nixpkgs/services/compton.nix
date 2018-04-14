{ pkgs, config, ... }:

{
  services.compton = {
    enable = false;
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" ];
    fadeExclude = [ "window_type *= 'menu'" ];
    extraOptions = ''
      no-dock-shadow = true;
    '';
  };
}
