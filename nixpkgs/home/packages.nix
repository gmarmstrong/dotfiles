{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    # cargo gnumake rustc
    acpi
    ardour
    atool
    audacity
    blueman
    byzanz
    calc
    calibre
    coreutils
    ctags
    curl
    dict
    diction
    file
    gnome3.adwaita-icon-theme
    gnupg
    golly
    gparted
    hexchat
    hicolor-icon-theme
    hugo
    imagemagick
    inetutils
    libqalculate
    libreoffice.libreoffice
    mediainfo
    musescore
    networkmanagerapplet
    nextcloud-client
    nixops
    openjdk8
    p7zip
    pandoc
    pass
    psmisc
    pwgen
    python
    python3
    qalculate-gtk
    qrencode
    qutebrowser
    ranger
    rofi-pass
    rsync
    rxvt_unicode-with-plugins
    scrot
    spotify
    sshfs
    sxiv
    texlive.combined.scheme-full
    tomb
    transmission_gtk
    trash-cli
    tree
    unclutter
    unrar
    unzip
    vlc
    w3m
    wget
    xclip
    xdg-user-dirs
    xdg_utils
    xorg.xbacklight
    xorg.xev
    xorg.xwininfo
    xsel
    xxd
    youtube-dl
    zathura
    zip
    zotero
  ];
}
