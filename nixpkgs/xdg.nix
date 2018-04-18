{ pkgs, config, ... }:

{
  xdg = {
    enable = true;

    configFile = {
      neovimConfig = {
        source = "${config.home.homeDirectory}/dotfiles/nvim/init.vim";
        target = "nvim/init.vim";
      };
      neovimFtplug = {
        recursive = true;
        source = "${config.home.homeDirectory}/dotfiles/nvim/ftplugin";
        target = "nvim/ftplugin";
      };

      rangerCommands = {
        source = "${config.home.homeDirectory}/dotfiles/ranger/commands.py";
        target = "ranger/commands.py";
      };
      rangerConfig = {
        source = "${config.home.homeDirectory}/dotfiles/ranger/rc.conf";
        target = "ranger/rc.conf";
      };
      rangerRifle = {
        source = "${config.home.homeDirectory}/dotfiles/ranger/rifle.conf";
        target = "ranger/rifle.conf";
      };
      rangerScope = {
        source = "${config.home.homeDirectory}/dotfiles/ranger/scope.sh";
        target = "ranger/scope.sh";
      };

      userDirs = {
        target = "user-dirs.dirs";
        text = ''
          XDG_DESKTOP_DIR="${config.home.homeDirectory}/"
          XDG_DOCUMENTS_DIR="${config.home.homeDirectory}/"
          XDG_DOWNLOAD_DIR="${config.home.homeDirectory}/"
          XDG_MUSIC_DIR="${config.home.homeDirectory}/"
          XDG_PICTURES_DIR="${config.home.homeDirectory}/"
          XDG_PUBLICSHARE_DIR="${config.home.homeDirectory}/"
          XDG_TEMPLATES_DIR="${config.home.homeDirectory}/"
          XDG_VIDEOS_DIR="${config.home.homeDirectory}/"
        '';
      };
    };

    dataFile = {
      rofiThemes = {
        recursive = true;
        source = "${config.home.homeDirectory}/dotfiles/resources/base16-rofi/themes";
        target = "rofi/themes";
      };
    };

  };
}
