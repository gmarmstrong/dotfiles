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
    extraConfig = builtins.readFile ( pkgs.fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-xresources";
      rev = "79e6e1de591f7444793fd8ed38b67ce7fce25ab6";
      sha256 = "1nnj5py5n0m8rkq3ic01wzyzkgl3g9a8q5dc5pcgj3qr47hhddbw";
    } + "/xresources/base16-default-light.Xresources");
  };
}

