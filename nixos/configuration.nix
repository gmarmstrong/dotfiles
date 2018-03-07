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

  # Packages
  environment.systemPackages = [
    pkgs.acpi
    pkgs.alsaLib
    pkgs.alsaTools
    pkgs.alsaUtils
    pkgs.ardour
    pkgs.autoconf
    pkgs.automake
    pkgs.byzanz
    pkgs.calc
    pkgs.calibre
    pkgs.coreutils
    pkgs.curl
    pkgs.dict
    pkgs.diction
    pkgs.dmenu
    pkgs.feh
    pkgs.figlet
    pkgs.file
    pkgs.firefox
    pkgs.firmwareLinuxNonfree
    pkgs.ghc
    pkgs.git
    pkgs.gnome3.gnome_keyring
    pkgs.gnumake
    pkgs.gnupg
    pkgs.htop
    pkgs.jekyll
    pkgs.json_c
    pkgs.maven
    pkgs.neovim
    pkgs.networkmanager.out
    pkgs.networkmanager_openvpn
    pkgs.networkmanagerapplet
    pkgs.openjdk
    pkgs.openssh
    pkgs.p7zip
    pkgs.pandoc
    pkgs.pass
    pkgs.postgresql
    pkgs.powerstat
    pkgs.powertop
    pkgs.psmisc
    pkgs.python
    pkgs.python3
    pkgs.ranger
    pkgs.rsync
    pkgs.rxvt_unicode_with-plugins
    pkgs.scrot
    pkgs.sshfs
    pkgs.stack
    pkgs.sudo
    pkgs.sxiv
    pkgs.taskwarrior
    pkgs.texlive.combined.scheme-full
    pkgs.timewarrior
    pkgs.transmission
    pkgs.trash-cli
    pkgs.tree
    pkgs.unclutter
    pkgs.unzip
    pkgs.vim
    pkgs.vlc
    pkgs.wget
    pkgs.xclip
    pkgs.xdg-user-dirs
    pkgs.xdg_utils
    pkgs.xorg.xbacklight
    pkgs.youtube-dl
    pkgs.zathura
    pkgs.zip
    pkgs.zsh
  ];

}
