{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    acpi
    ardour
    atool
    audacity
    blueman
    byzanz
    calc
    calibre
    cargo
    coreutils
    ctags
    curl
    dict
    diction
    file
    gnome3.adwaita-icon-theme
    gnumake
    gnupg
    golly
    gparted
    hexchat
    hicolor-icon-theme
    hsetroot
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
    nox
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
    ranger
    rofi-pass
    rsync
    rustc
    rxvt_unicode-with-plugins
    scrot
    spotify
    sshfs
    sxiv
    texlive.combined.scheme-full
    thunderbird
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
