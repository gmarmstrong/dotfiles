{ pkgs, config, ... }:

{
  home.file = {

    nvim-ftplugin = {
      recursive = true;
      target = ".config/nvim/ftplugin/";
      source = "${config.home.homeDirectory}/dotfiles/nvim/ftplugin/";
    };
    nvim-gnupg = {
      target = ".config/nvim/gnupg.vim";
      source = "${config.home.homeDirectory}/dotfiles/nvim/gnupg.vim";
    };
    nvim-init = {
      target = ".config/nvim/init.vim";
      source = "${config.home.homeDirectory}/dotfiles/nvim/init.vim";
    };
    nvim-init-secure = {
      target = ".config/nvim/vimrc_secure";
      source = "${config.home.homeDirectory}/dotfiles/nvim/vimrc_secure";
    };

    ranger-commands = {
      target = ".config/ranger/commands.py";
      source = "${config.home.homeDirectory}/dotfiles/ranger/commands.py";
    };
    ranger-rc = {
      target = ".config/ranger/rc.conf";
      source = "${config.home.homeDirectory}/dotfiles/ranger/rc.conf";
    };
    ranger-rifle = {
      target = ".config/ranger/rifle.conf";
      source = "${config.home.homeDirectory}/dotfiles/ranger/rifle.conf";
    };
    ranger-scope = {
      target = ".config/ranger/scope.sh";
      source = "${config.home.homeDirectory}/dotfiles/ranger/scope.sh";
    };

    user-dirs = {
      target = ".config/user-dirs.dirs";
      text = ''
        XDG_DESKTOP_DIR="$HOME/"
        XDG_DOCUMENTS_DIR="$HOME/"
        XDG_DOWNLOAD_DIR="$HOME/"
        XDG_MUSIC_DIR="$HOME/"
        XDG_PICTURES_DIR="$HOME/"
        XDG_PUBLICSHARE_DIR="$HOME/"
        XDG_TEMPLATES_DIR="$HOME/"
        XDG_VIDEOS_DIR="$HOME/"
      '';
    };
  };
}
