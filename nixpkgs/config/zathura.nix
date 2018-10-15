{ pkgs, config, ... }:

{
  xdg.configFile.zathura = {
    target = "zathura/zathurarc";
    text = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/base16-zathura/build_schemes/base16-gruvbox-light-soft.config" ) + ''
      set first-page-column 1:1
      set smooth-scroll "true"
      set recolor "true"
      set statusbar-home-tilde "true"
      set window-title-home-tilde "true"
      set selection-clipboard clipboard
    '';
  };
}
