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

      rangerConfig = {
        target = "ranger/rc.conf";
        text = ''
          map DD shell trash %s
        '';
      };
      rangerRifle = {
        target = "ranger/rifle.conf";
        text = ''
          ext pdf, has zathura,  X, flag f = zathura -- "$@"
          ext djvu, has zathura,  X, flag f = zathura -- "$@"
        '';
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
  };
}
