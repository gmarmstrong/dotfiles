{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    home-manager = {
      enable = true;
      path = "https://github.com/rycee/home-manager/archive/release-17.09.tar.gz";
    };
  };

  home.packages = with pkgs; [
    androidsdk
    ardour
    byzanz
    calc
    calibre
    dict
    diction
    feh
    figlet
    firefox
    gnome3.gnome_keyring
    hugo
    imagemagick
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    libreoffice
    maven
    neovim
    nextcloud-client
    openjdk
    openssh
    pandoc
    pass
    polybar
    postgresql
    python
    python3
    ranger
    rofi
    rofi-pass
    rsync
    rxvt_unicode_with-plugins
    signal-desktop
    slack
    spotify
    sxiv
    texlive.combined.scheme-full
    thunderbird
    tor-browser-bundle-bin
    transmission_gtk
    trash-cli
    tree
    unclutter
    vlc
    w3m
    xclip
    xpdf
    youtube-dl
    zathura
    zotero
    zsh
  ];

}
