{ pkgs, config, ... }:

{
  xdg.configFile = {
    userDirs = {
      target = "user-dirs.dirs";
      text = ''
        XDG_DESKTOP_DIR="${config.home.homeDirectory}/Desktop/"
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
}
