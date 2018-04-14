{ pkgs, config, ... }:

{
  services.compton = {
    enable = true;
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" ];
    fadeExclude = [ "window_type *= 'menu'" ];
    extraOptions = ''
      no-dock-shadow = true;
    '';
  };
}
