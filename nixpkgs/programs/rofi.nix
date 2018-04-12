{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    scrollbar = false;
    terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
    separator = "solid";
    colors = {
      window = {
        background = "#ebdbb2";
        border = "#ebdbb2";
        separator = "#f2e5bc";
      };
      rows = {
        normal = {
          background = "#ebdbb2";
          foreground = "#504945";
          backgroundAlt = "#ebdbb2";
          highlight = {
            background = "#ebdbb2";
            foreground = "#282828";
          };
        };
        active = {
          background = "#ebdbb2";
          foreground = "#076678";
          backgroundAlt = "#ebdbb2";
          highlight = {
            background = "#ebdbb2";
            foreground = "#076678";
          };
        };
        urgent = {
          background = "#ebdbb2";
          foreground = "#9d0006";
          backgroundAlt = "#ebdbb2";
          highlight = {
            background = "#ebdbb2";
            foreground = "#9d0006";
          };
        };
      };
    };
  };
}
