{ pkgs, config, ... }:

let
  nextcloud-client = pkgs.nextcloud-client.override {
    withGnomeKeyring = true;
    libgnome-keyring = pkgs.gnome3.libgnome-keyring;
  };

in

{
  home.packages = with pkgs; [
    # cargo gnumake rustc
    acpi
    ardour
    audacity
    blueman
    byzanz
    calibre
    coreutils
    curl
    dict
    diction
    dos2unix
    file
    gnome3.adwaita-icon-theme
    gnupg
    golly
    gparted
    hexchat
    hicolor-icon-theme
    imagemagick
    inetutils
    jetbrains.idea-ultimate
    libqalculate
    libreoffice.libreoffice
    mediainfo
    mkvtoolnix
    musescore
    networkmanagerapplet
    nextcloud-client
    nixops
    p7zip
    pandoc
    pass
    psmisc
    python3 # TODO delete after resolving clustergit, vim-muse, and python-datamuse dependencies
    qalculate-gtk
    qrencode
    qutebrowser
    ranger
    rxvt_unicode-with-plugins
    scrot
    spotify
    sxiv
    texlive.combined.scheme-full
    transmission_gtk
    trash-cli
    tree
    unclutter
    unrar
    unzip
    usbutils
    vlc
    wget
    wireshark
    xclip
    xdg-user-dirs
    xdg_utils
    xiphos
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
