{ pkgs, config, ... }:

{
  xdg.configFile.zathura = {
    target = "zathura/zathurarc";
    text = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/base16-zathura/build_schemes/${config.home.sessionVariables.COLORTHEME}.config" ) + ''
      set first-page-column 1:1
      set smooth-scroll "true"
      set recolor "true"
      set statusbar-home-tilde "true"
      set window-title-home-tilde "true"
      set statusbar-basename "true"
      set window-title-basename "true"
      set selection-clipboard clipboard
    '';
  };
}
