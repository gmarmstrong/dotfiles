{ pkgs, config, ...  }:

{

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs : rec {
    i3Support = true;
  };

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  boot = {
    earlyVconsoleSetup = true;
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
      device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
      gfxmodeBios = "1920x1080";
      gfxmodeEfi = "1920x1080";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    cpu.intel.updateMicrocode = true;
    opengl.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
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

  security.sudo.enable = true;

  programs = {
    gnupg.agent.enable = true;
    adb.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    dbus.packages = [ pkgs.blueman ];
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
      enable = true;
      exportConfiguration = true;
      displayManager.lightdm = {
        enable = true;
        background = "black";
        greeter.enable = false;
        autoLogin = {
          enable = true;
          user = "guthrie";
          timeout = 0;
        };
      };
      libinput = {
        enable = true;
        scrollMethod = "twofinger";
        tapping = false;
        tappingDragLock = false;
      };
      multitouch.enable = true;
    };
  };

  system.stateVersion = "18.03"; # NixOS release version

  environment = {
    variables.EDITOR = "nvim";
    pathsToLink = [ "/share/zsh" ]; # zsh completion for system packages
    systemPackages = with pkgs; [
      alsaLib
      alsaTools
      alsaUtils
      firmwareLinuxNonfree
      git
      home-manager
      networkmanager.out
      networkmanager_openvpn
      networkmanagerapplet
      nix-prefetch-scripts
      pavucontrol
    ];
  };

}
