{ pkgs, config, ... }:

{
  # "The set of packages to appear in the user environment."
  home.packages = with pkgs; [
    acpi
    ardour
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
    exfat
    file
    firefox
    gnome3.adwaita-icon-theme
    gnumake
    gnupg
    golly
    gparted
    hsetroot
    hugo
    imagemagick
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
    qrencode
    ranger
    rofi-pass
    rsync
    rustc
    rxvt_unicode_with-plugins
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
    youtube-dl
    zathura
    zip
    zotero
  ];
}
