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

  xdg.configFile.rofiPass = {
    target = "rofi-pass/config";
    text = ''
      EDITOR='urxvt -e nvim --'
      default_autotype='pass'
      clip=clipboard
      password_length=16
      _image_viewer () {
          cat > /tmp/sxiv && sxiv /tmp/sxiv && rm /tmp/sxiv
      }
    '';
  };
}
