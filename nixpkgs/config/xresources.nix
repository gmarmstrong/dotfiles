{ pkgs, config, ... }:

{
  xresources = {
    properties = {
      "URxvt.termName" = "rxvt-unicode-256color";
      "URxvt.iso14755" = false;
      "URxvt.internalBorder" = 30;
      "URxvt.scrollBar" = false;
      "URxvt.scrollTtyOutput" = false;
      "URxvt.scrollWithBuffer" = true;
      "URxvt.scrollTtyKeypress" = true;
      "URxvt.secondaryScreen" = 1;
      "URxvt.secondaryScroll" = 0;
      "URxvt.perl-ext" = "";
      "URxvt.perl-ext-common" = "font-size";
      "URxvt.font" = "xft:DejaVu Sans Mono:size=11";
      "URxvt.keysym.C-plus" = "font-size:increase";
      "URxvt.keysym.C-minus" = "font-size:decrease";
      "URxvt.keysym.C-equal" = "font-size:reset";
      "URxvt.keysym.C-slash" = "font-size:show";
      "Xft.autohint" = 1;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };
    extraConfig = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/base16-xresources/xresources/${config.home.sessionVariables.COLORTHEME}.Xresources" );
  };
}
