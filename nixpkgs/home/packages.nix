{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    docker docker-machine
    zoom-us
    syncplay
    uvcdynctrl
    dbeaver
    flatpak
    scid-vs-pc stockfish
    poetry
    jrnl

    # Considering:
    # passExtensions.pass-audit   # pass: auditing
    # passExtensions.pass-update  # pass: updating
    # passExtensions.pass-otp     # pass: otp token managing
    # buku    # bookmark manager

    # Blocked:
    # bitwarden-cli # NixOS/nixpkgs: #51212 #53876
    # bitwarden     # NixOS/nixpkgs: #51212
    # jabref        # NixOS/nixpkgs: #47113
    # passExtensions.pass-tomb # mssun/passforios: #114

    # System requirements (TODO nixify)
    hicolor-icon-theme # icon theme
    librsvg # SVG renderer (TODO why?)

    # Userspace utilities
    acpi # power management
    coreutils # basic utilities
    curl wget youtube-dl # downloaders
    dos2unix  # line break converter
    file # file info
    inetutils iftop # network utilities
    lshw # hardware config info
    nox # nix tools
    pciutils # PCI bus utilities
    psmisc lsof htop # process utilities
    qrencode # QR code encoder
    trash-cli # trash can
    tree # depth-indented directory listing
    usbutils # USB device tools
    xdotool # input automation
    xxd # hexdumps
    zip unzip p7zip unrar # archive tools

    # Development (TODO nixify)
    #postman insomnia # API development
    gcc # C/C++ compiler
    geckodriver # Selenium driver
    google-cloud-sdk # Google Cloud Platform CLI
    jetbrains.idea-ultimate # Java IDE (UNFREE)
    jq # JSON processor
    nodePackages.node2nix
    postgresql_jdbc # Java driver for PostgreSQL
    python3 # python
    rstudioWrapper R # R tools
    universal-ctags # source code indexer (TODO Vim tagbar dependency)

    # Security
    gnupg # openpgp
    pass # password manager
    tomb # storage file encryption
    gksu # su frontend

    # Graphical applications
    calibre # ebook manager
    #logisim
    dia umlet # diagram editors
    #mathematica # wolfram mathematica
    #qgis # geographic information system
    #slack
    chromium # web browser
    digikam # photo manager
    emacs emacs-all-the-icons-fonts # text editor
    goldendict # dictionary client
    guvcview # video capturing
    hexchat # IRC client
    libreoffice # office suite
    lyx # LaTeX editor
    mendeley # reference manager
    qalculate-gtk # calculator
    qbittorrent # bittorrent client
    qtikz # TikZ diagram editor
    qutebrowser # vi-like web browser
    skype # video chat client (UNFREE)
    spotify # music client (UNFREE)
    thunderbird # mail client
    vlc # media player
    zim # desktop wiki
    zotero # reference management

    # KDE applications
    kdeApplications.ark # file compresion and archival
    kdeApplications.kcharselect # character selection
    kdeApplications.okular # pdf viewer

    # freedesktop.org
    xdg-user-dirs xdg_utils # xdg tools
    desktop-file-utils # desktop entry utilities
    xorg.xev # X event monitor
    xorg.xwininfo # X window info
    xbindkeys
    xsel

    # General:
    #diction # English linter
    audacity # sound editor
    byzanz vokoscreen spectacle # screen capture
    font-manager
    gparted # disk partitioner
    imagemagick # bitmap image editor
    libqalculate # Qalculate! CLI
    man-pages # linux man-pages
    mediainfo # multimedia info
    mkvtoolnix # matroska tools
    pandoc # markup converter
    ranger atool # file manager
    redshift # screen color temperature manager
    rxvt_unicode-with-plugins # terminal emulator
    scrcpy # Android remote control and display
    sshfs # remote filesystem mounter
    sxiv # image viewer
    texlive.combined.scheme-full # TeX Live
    xclip xsel # X clipboard console support
  ];
}
