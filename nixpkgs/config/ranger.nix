{ pkgs, config, ... }:

{
  xdg.configFile.rangerConfig = {
    target = "ranger/rc.conf";
    text = ''
      map DD shell trash %s
      set vcs_aware true
      set draw_borders true
    '';
  };

  xdg.configFile.rangerRifle = {
    target = "ranger/rifle.conf";
    text = ''
      ext gpg, label editor = "nvim" -- "$@"
      ext pdf, has zathura, X, flag f = zathura -- "$@"
      ext djvu, has zathura, X, flag f = zathura -- "$@"
      ext epub, has zathura, X, flag f = zathura -- "$@"
      ext mobi, has ebook-viewer, X, flag f = ebook-viewer -- "$@"
      ext x?html?, has firefox, X, flag f = firefox -- "$@"
      mime ^image, has sxiv, X, flag f = sxiv -a -- "$@"
      mime ^video|audio, has vlc, X, flag f = "${pkgs.vlc}/bin/vlc" -- "$@"
      mime ^text, label editor = "nvim" -- "$@"
      mime ^text, label pager = "$PAGER" -- "$@"
    '';
  };

}
