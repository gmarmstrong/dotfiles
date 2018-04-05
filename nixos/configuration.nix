{ config, pkgs, ...  }:

{

  nixpkgs.config.allowUnfree = true;

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

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
      device = "/dev/sda"; # TODO Specify device by uuid
    };
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  users.extraUsers.guthrie = {
    isNormalUser = true;
    home = "/home/guthrie";
    description = "Guthrie McAfee Armstrong";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.zsh;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "US/Eastern";

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      syntaxHighlighting.enable = true;
      enableCompletion = true;
    };
  };

  security.sudo.enable = true;

  services = {
    locate.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    physlock = {
      enable = true;
      allowAnyUser = true;
    };
    xserver = {
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
        nextcloud &
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
        scrollMethod = "edge";
      };
      multitouch.enable = true;
      windowManager.i3.enable = true;
    };
  };

  system.stateVersion = "18.03"; # NixOS release version

  environment = {
    variables.EDITOR = "nvim";
    systemPackages = with pkgs; [
      acpi
      alsaLib
      alsaTools
      alsaUtils
      blueman
      coreutils
      curl
      file
      firmwareLinuxNonfree
      git
      gparted
      home-manager
      htop
      networkmanager.out
      networkmanager_openvpn
      networkmanagerapplet
      p7zip
      pasystray
      pavucontrol
      powerstat
      powertop
      psmisc
      unzip
      wget
      xdg-user-dirs
      xdg_utils
      xorg.xbacklight
      zip
    ];
  };

}
