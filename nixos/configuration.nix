{ config, pkgs, ...  }:

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
        device = "/dev/sda3"; # TODO Make system-agnostic
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
    autorun = false;
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

  # TODO Install zotero
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
    gparted
    gnupg
    htop
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jekyll
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
    taskwarrior
    texlive.combined.scheme-full
    timewarrior
    tor-browser-bundle-bin
    transmission
    trash-cli
    tree
    unclutter
    unzip
    vlc
    wget
    xclip
    xdg-user-dirs
    xdg_utils
    xpdf
    xorg.xbacklight
    youtube-dl
    zathura
    zip
    zsh
    zsh-completions
  ];

}
