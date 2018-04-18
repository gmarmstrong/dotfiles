{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    scrollbar = false;
    separator = "solid";
    terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
    theme = "${config.xdg.dataHome}/rofi/themes/base16-default-light.rasi";
  };
}
