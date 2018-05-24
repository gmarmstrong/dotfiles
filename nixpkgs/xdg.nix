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

      nixpkgsConfig = {
        target = "nixpkgs/config.nix";
        text = ''
          { allowUnfree = true; }
        '';
      };

      zathuraConfig = {
        target = "zathura/zathurarc";
        text = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/base16-zathura/build_schemes/base16-gruvbox-light-soft.config" ) + ''
          set first-page-column 1:1
          set smooth-scroll "true"
        '';
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
          ext gpg, label editor = "$EDITOR" -- "$@"
          ext pdf, has zathura, X, flag f = zathura -- "$@"
          ext djvu, has zathura, X, flag f = zathura -- "$@"
          ext epub, has ebook-viewer, X, flag f = ebook-viewer -- "$@"
          ext mobi, has ebook-viewer, X, flag f = ebook-viewer -- "$@"
          ext x?html?, has firefox, X, flag f = firefox -- "@"
          mime ^image, has sxiv, X, flag f = sxiv -a -- "$@"
          mime ^video|audio, has vlc, X, flag f = vlc -- "$@"
          mime ^text, label editor = "$EDITOR" -- "$@"
          mime ^text, label pager = "$PAGER" -- "$@"
        '';
      };

      rofiEmoji = {
        target = "rofi/rofiemoji.sh";
        text = builtins.readFile ( "${config.home.homeDirectory}/dotfiles/resources/rofiemoji/rofiemoji.sh" ) ;
        executable = true;
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
