{ config, pkgs, ...  }:

# TODO Create skeleton directory tree
# TODO Configure git (home-manager)
# TODO Fetch passwords
# TODO Install clustergit
# TODO Install vim-plug
# TODO Install vim plugins

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Include results of hardware scan
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Declare startup devices and boot loaders
  boot = {
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";
        preLVM = true;
      }
    ];
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
  };

  # Declare hardware, including Bluetooth and PulseAudio
  hardware = {
    bluetooth = {
      enable = true;
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  # Environment variables
  environment.variables.EDITOR = "nvim";

  # Define users (each must set their password with `passwd`)
  users.extraUsers.guthrie = {
    isNormalUser = true;
    home = "/home/guthrie";
    description = "Guthrie McAfee Armstrong";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.zsh;
  };

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Set your time zone
  time.timeZone = "US/Eastern";

  # GnuPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Zsh shell
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableCompletion = true;

  ## Enable CUPS to print documents
  #services.printing.enable = true;

  # Security
  security.sudo.enable = true;

  ## Physlock (redundant alongside SLiM)
  #services.physlock.enable = true; # TODO Allow all users (not available in 17.09)

  # X11 window system
  services.xserver = {
    autorun = true;
    serverFlagsSection = # Block tty access from lock screen
    ''
      Option "DontVTSwitch" "True"
    '';
    displayManager.sessionCommands =
    ''
      xrdb -load "$HOME/.config/X11/Xresources" &
      nm-applet &
      blueman-applet &
      pasystray &
      unclutter -root &
      . "$HOME/.fehbg" &
    '';
    enable = true;
    exportConfiguration = true;
    libinput = {
      enable = true;
      accelProfile = "flat";
      tapping = false;
      tappingDragLock = false;
    };
    windowManager.i3.enable = true;
  };

  # NixOS release version
  system.stateVersion = "17.09";

  # Packages
  environment.systemPackages = with pkgs; [
    acpi
    alsaLib
    alsaTools
    alsaUtils
    ardour
    autoconf
    automake
    blueman
    byzanz
    calc
    calibre
    coreutils
    curl
    dict
    diction
    dmenu
    feh
    figlet
    file
    firefox
    firmwareLinuxNonfree
    ghc
    git
    gnome3.gnome_keyring
    gnumake
    gnupg
    gparted
    htop
    jekyll
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    json_c
    maven
    neovim
    networkmanager.out
    networkmanager_openvpn
    networkmanagerapplet
    openjdk
    openssh
    p7zip
    pandoc
    pass
    pasystray
    pavucontrol
    postgresql
    powerstat
    powertop
    psmisc
    python
    python3
    ranger
    rsync
    rxvt_unicode_with-plugins
    scrot
    spotify
    sshfs
    stack
    sxiv
    texlive.combined.scheme-full
    tor-browser-bundle-bin
    transmission
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
    xpdf
    youtube-dl
    zathura
    zip
    zsh
    zsh-completions
  ];

}
