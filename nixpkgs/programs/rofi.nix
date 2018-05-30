{ pkgs, config, ... }:

{
  programs.rofi = {

    # "Whether to enable Rofi"
    enable = true;

    # "Whether to show a scrollbar."
    scrollbar = false;

    # "Separator style"
    separator = "solid";

    # "Path to the terminal which will be used to run console applications"
    terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";

    # "Name of theme or path to theme file in rasi format."
    theme = "${config.home.homeDirectory}/dotfiles/resources/base16-rofi/themes/base16-gruvbox-light-soft.rasi";
  };
}
