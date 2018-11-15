{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = ''
      modi: "window,run,ssh,drun";*/
    '';
    theme = "${config.home.homeDirectory}/dotfiles/resources/base16-rofi/themes/${config.home.sessionVariables.COLORTHEME}.rasi";
    terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
  };

  xdg.configFile.rofiEmoji = {
    executable = true;
    target = "rofi/rofiemoji.sh";
    text = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/rofiemoji/rofiemoji.sh" );
  };
}
