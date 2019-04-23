{ pkgs, config, ... }:

{
  home.packages = with pkgs; [

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
    # jabref        # (GUI) NixOS/nixpkgs: #47113
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
    psmisc lsof # process utilities
    qrencode # QR code encoder
    trash-cli # trash can
    tree # depth-indented directory listing
    usbutils # USB device tools
    curl wget youtube-dl # downloaders
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    zip unzip p7zip unrar # archive tools

    # Development
    adoptopenjdk-hotspot-bin-11 # prebuilt openjdk binary
    jetbrains.idea-ultimate # IDE (GUI) (UNFREE)
    maven3 # java build tool
    python3 # TODO development dependency
    universal-ctags # source code indexer (TODO Vim tagbar dependency)
    coq # proof assistant (GUI) # TODO nixify projects
    # gnumake
    # rustc cargo # TODO nixify Rust projects
    # gnumake # TODO nixify projects
    # nixops # TODO nixify NixOps projects
    # jdk8 # TODO nixify Java projects

    # Security
    gnupg # openpgp
    pass # password manager
    tomb # storage file encryption
    gksu # su frontend (GUI)

    # Textual applications
    diction # english linter
    libqalculate # calculator
    ranger # file manager
    hledger

    # Graphical applications
    anki  # flashcards (GUI)
    calibre # e-book manager (GUI)
    firefox
    hexchat # IRC client (GUI)
    insomnia # REST API client (GUI)
    nextcloud-client
    qalculate-gtk # calculator (GUI)
    qbittorrent # bittorrent client (GUI)
    qutebrowser # vi-like web browser (GUI)
    signal-desktop # messaging client (GUI)
    skype # VoIP client (UNFREE) (GUI)
    slack # chat client (GUI) (UNFREE)
    spotify # music client (GUI) (UNFREE)
    vlc # media player (GUI)
    zathura # document viewer (GUI)
    zotero # reference management (GUI)

    # General:
    audacity
    byzanz scrot # screen capture
    gparted # disk partitioner (GUI)
    imagemagick # bitmap image editor
    man-pages # linux man-pages
    mediainfo # multimedia info
    mkvtoolnix # matroska tools (GUI)
    pandoc # markup converter
    rxvt_unicode-with-plugins # terminal emulator
    sshfs # remote filesystem mounter
    sxiv # image viewer
    texlive.combined.scheme-full # TeX Live
    xclip xsel # X clipboard console support
    xdg-user-dirs
    xdg_utils
    xxd # create or reverse hexdumps
  ];
}
