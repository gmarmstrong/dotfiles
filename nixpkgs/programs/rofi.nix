{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    scrollbar = false;
    separator = "solid";
    terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
    theme = "${config.home.homeDirectory}/dotfiles/resources/base16-rofi/themes/base16-gruvbox-light-soft.rasi";
  };
}
