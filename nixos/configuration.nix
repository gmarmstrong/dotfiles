{ pkgs, config, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs : rec { i3Support = true; };
  };

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  swapDevices = [ { device = "/dev/disk/by-uuid/13f26b63-cf59-49c8-bc44-44bd5fc4c9b2"; } ];

  fonts.fonts = with pkgs; [
    twemoji-color-font
    dejavu_fonts
  ];

  boot = {
    earlyVconsoleSetup = true;
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";
      }
    ];
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
      gfxmodeBios = "1920x1080";
      gfxmodeEfi = "1920x1080";
    };
    plymouth.enable = true;
  };

  hardware = {

    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
    shell = pkgs.bash;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "US/Eastern";

  security = {
    apparmor.enable = true;
    sudo.enable = true;
    polkit.extraConfig = ''
      // Allow wheel users to mount filesystems
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
            action.id == "org.freedesktop.udisks2.filesystem-mount") &&
            subject.isInGroup("wheel")) { return polkit.Result.YES; }
      });
    '';
  };

  programs = {
    gnupg.agent.enable = true;
    adb.enable = true;
    bash.enableCompletion = true;
  };

  services = {
    dbus.packages = [ pkgs.blueman ];
    locate.enable = true;

    gnome3.gnome-keyring.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.hplip pkgs.foo2zjs ];
      browsing = true;
      defaultShared = true;
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

  virtualisation.virtualbox.host.enable = true;

  environment = {
    variables.EDITOR = "nvim"; # FIXME Install nvim system-wide
    systemPackages = with pkgs; [
      alsaLib
      alsaTools
      alsaUtils
      exfat
      firmwareLinuxNonfree
      git
      home-manager
      networkmanager.out
      networkmanager_openvpn
      networkmanagerapplet
      nix-prefetch-scripts
      pavucontrol
      vulnix
    ];
  };

}
