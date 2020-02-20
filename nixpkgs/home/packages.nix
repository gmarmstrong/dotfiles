{ pkgs, config, ... }:

{
  home.packages = with pkgs; [

    # Considering:
    # passExtensions.pass-audit   # pass: auditing command
    # passExtensions.pass-update  # pass: updating command
    # weechat # IRC client (TODO replace hexchat)
    # sway    # window manager for Wayland, compatible with i3
    # xmonad  # tiling window manager for X, configured in Haskell
    # buku    # bookmark manager

    # Waiting for:
    # bitwarden-cli # NixOS/nixpkgs: #51212 #53876
    # bitwarden     # NixOS/nixpkgs: #51212
    # jabref        # NixOS/nixpkgs: #47113
    # passExtensions.pass-tomb # zeapo/Android-Password-Store: #329

    iftop
    mathematica
    umlet

    # System requirements (TODO nixify)
    blueman # bluetooth manager
    hicolor-icon-theme # icon theme
    librsvg # SVG renderer
    libnotify # dunst dependency
    networkmanagerapplet  # network manager

    # system info
    acpi # power management and info
    pciutils # PCI bus utilities
    lshw # hardware config info

    # Userspace utilities
    coreutils # basic utilities
    dos2unix  # line break converter
    file # file info
    inetutils # network utilities
    nox # nix tools
    psmisc lsof # process utilities
    qrencode # QR code encoder
    trash-cli # trash can
    tree # depth-indented directory listing
    usbutils # USB device tools
    curl wget youtube-dl # downloaders
    xdotool
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    zip unzip p7zip unrar # archive tools

    # Development
    jetbrains.idea-ultimate # Java IDE (UNFREE)
    geckodriver # Selenium driver
    jetbrains.clion # C++ IDE (UNFREE)
    gcc gdb gnumake valgrind # C++ utilities
    python3 # TODO nixify Python projects
    universal-ctags # source code indexer (TODO Vim tagbar dependency)
    coq # proof assistant
    tlaplusToolbox tlaps # TLA+ tools
    rstudioWrapper R # R tools
    postman # API development
    postgresql_jdbc
    jq # JSON processor
    # sqlite sqlite-jdbc
    # exercism # programming practice
    # rustc cargo
    # nixops

    # Security
    gnupg # openpgp
    pass # password manager
    tomb # storage file encryption
    gksu # su frontend

    # Textual applications
    diction # English linter
    libqalculate # calculator
    ranger atool # file manager
    hledger # accounting tool

    # Games
    multimc minecraft jre8
    scid-vs-pc stockfish
    runelite

    # Graphical applications
    calibre # ebook manager
    dia # structured diagram editor
    digikam # photo manager
    emacs emacs-all-the-icons-fonts # text editor
    goldendict # dictionary client
    hexchat # IRC client
    inkscape # vector graphics editor
    insomnia # REST API client
    libreoffice # office suite
    logisim
    lyx # LaTeX editor
    #nextcloud-client # cloud storage client
    qalculate-gtk # calculator
    qbittorrent # bittorrent client
    qgis
    qtikz # TikZ diagram editor
    qutebrowser # vi-like web browser
    signal-desktop # messaging client
    skype # video chat client (UNFREE)
    spotify # music client (UNFREE)
    thunderbird # mail client
    torbrowser # onion browser
    vlc # media player
    zathura # document viewer
    zim # desktop wiki
    zotero # reference management

    # General:
    audacity # sound editor
    byzanz scrot vokoscreen # screen capture
    font-manager
    gparted # disk partitioner
    imagemagick # bitmap image editor
    man-pages # linux man-pages
    mediainfo # multimedia info
    mkvtoolnix # matroska tools
    pandoc # markup converter
    redshift # screen color temperature manager
    rxvt_unicode-with-plugins # terminal emulator
    scrcpy # Android remote control and display
    sshfs # remote filesystem mounter
    sxiv # image viewer
    texlive.combined.scheme-full # TeX Live
    xclip xsel # X clipboard console support
    xdg-user-dirs
    xdg_utils
    xxd # create or reverse hexdumps
  ];
}
