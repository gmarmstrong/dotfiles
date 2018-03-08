{ config, pkgs, ...  }:

{

  # Include results of hardware scan
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # GRUB 2
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  # PulseAudio
  hardware.pulseaudio.enable = true;

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
    hostName = "nixos"; # define hostname
    networkmanager.enable = true; # enable networkmanager
  };

  # Set your time zone
  time.timeZone = "US/Eastern";

  # GnuPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Zsh shell
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableCompletion = true;

  # Enable CUPS to print documents
  # services.printing.enable = true;

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
      . "$HOME/.fehbg" &
      nm-applet &
      unclutter &
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

  # Startup device
  # TODO Make system-agnostic
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }
  ];

  # TODO Install antigen
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
    htop
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
    sshfs
    stack
    sudo
    sxiv
    taskwarrior
    texlive.combined.scheme-full
    timewarrior
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
    xorg.xbacklight
    youtube-dl
    zathura
    zip
    zsh
    zsh-completions
  ];

}
