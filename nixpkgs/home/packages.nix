{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    acpi
    ardour
    audacity
    byzanz
    calc
    calibre
    coreutils
    curl
    dict
    diction
    file
    firefox
    gnumake
    gnupg
    go
    golly
    gparted
    gx
    gx-go
    hsetroot
    hugo
    imagemagick
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    libreoffice
    musescore
    nextcloud-client
    p7zip
    pandoc
    pass
    pasystray
    psmisc
    pwgen
    python
    python3
    ranger
    rofi-pass
    rsync
    rxvt_unicode_with-plugins
    scrot
    signal-desktop
    spotify
    sshfs
    sxiv
    texlive.combined.scheme-full
    transmission_gtk
    trash-cli
    tree
    unclutter
    unzip
    virtualbox
    vlc
    w3m
    wget
    xclip
    xdg-user-dirs
    xdg_utils
    xorg.xbacklight
    xorg.xwininfo
    youtube-dl
    zathura
    zip
    zotero
  ];
}
