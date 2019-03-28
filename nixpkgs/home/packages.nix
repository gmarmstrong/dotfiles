{ pkgs, config, ... }:

{
  home.packages = with pkgs; [

    # Trying:
    qutebrowser # vi-like web browser (GUI)
    sqlitebrowser
    audacity
    firefox
    (lowPrio firefox-devedition-bin)
    wireshark
    gksu
    maven3
    gnumake

    # Considering:
    # passExtensions.pass-audit   # pass: auditing command
    # passExtensions.pass-update  # pass: updating command
    # weechat # IRC client (TODO replace hexchat)
    # sway    # window manager for Wayland, compatible with i3
    # xmonad  # tiling window manager for X, configured in Haskell
    # zim     # (GUI) desktop wiki
    # buku    # bookmark manager

    # Waiting for:
    # bitwarden-cli # NixOS/nixpkgs: #51212 #53876
    # bitwarden     # (GUI) # NixOS/nixpkgs: #51212
    # jabref-4      # (GUI) NixOS/nixpkgs: #47113
    # passExtensions.pass-tomb # zeapo/Android-Password-Store: #329

    # System requirements (TODO nixify)
    blueman # bluetooth manager (GUI)
    hicolor-icon-theme # icon theme
    librsvg # SVG renderer
    networkmanagerapplet  # network manager (GUI)
    xorg.xbacklight
    atool # (TODO ranger dependency)

    # Userspace utilities
    acpi      # battery status
    coreutils # basic utilities
    dos2unix  # line break converter
    file      # file info
    inetutils # network utilities
    p7zip # 7-Zip archive tools
    psmisc lsof # process utilities
    qrencode # QR code encoder
    trash-cli # trash can
    tree # depth-indented directory listing
    unrar # rar archive tools
    usbutils # USB device tools
    curl wget youtube-dl # downloaders
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    zip unzip # zip archive tools

    # Development
    adoptopenjdk-hotspot-bin-11
    jetbrains.idea-ultimate # IDE (GUI) (UNFREE)
    python3 # programming language (TODO development dependency)
    universal-ctags # source code indexer (TODO Vim tagbar dependency)
    # rustc cargo # TODO nixify Rust projects
    # gnumake # TODO nixify projects
    # nixops # TODO nixify NixOps projects
    # jdk8 # TODO nixify Java projects

    # Security
    coq # proof assistant (GUI) # TODO nixify projects
    gnupg # openpgp
    pass # password manager
    tomb # storage file encryption

    # Textual applications
    dict # dictionary client
    diction # english linter
    libqalculate # calculator
    ranger # file manager

    # Graphical applications
    anki  # flashcards (GUI)
    calibre # e-book manager (GUI)
    hexchat # IRC client (GUI)
    insomnia # REST API client (GUI)
    qalculate-gtk # calculator (GUI)
    qbittorrent # bittorrent client (GUI)
    signal-desktop # messaging client (GUI)
    skype # VoIP client (UNFREE) (GUI)
    slack # chat client (GUI) (UNFREE)
    spotify # music client (GUI) (UNFREE)
    vlc # media player (GUI)
    zathura # document viewer (GUI)
    zotero # reference management (GUI)

    # General:
    byzanz scrot # screen capture
    gparted # disk partitioner (GUI)
    imagemagick # bitmap image editor
    man-pages # linux man-pages
    mediainfo # multimedia info
    mkvtoolnix # matroska tools (GUI)
    nextcloud-client # cloud storage client (GUI)
    pandoc # markup converter
    rxvt_unicode-with-plugins # terminal emulator
    sshfs # remote filesystem mounter
    sxiv # image viewer
    texlive.combined.scheme-full # TeX Live
    xclip xsel # X clipboard console support
    xdg-user-dirs
    xdg_utils
    xxd
  ];
}
