{ pkgs, config, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/New_York";
  #time.timeZone = "Europe/Greece";
  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true; # Automatic Nix garbage collection

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    system76.enableAll = true;
    nvidia = {
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    opengl.driSupport32Bit = true;
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    pulseaudio.support32Bit = true;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
    polkit.extraConfig = ''
      // Allow wheel users to mount filesystems
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
            action.id == "org.freedesktop.udisks2.filesystem-mount") &&
            subject.isInGroup("wheel")) { return polkit.Result.YES; }
      });
    '';
  };

  users.users.guthrie = {
    isNormalUser = true;
    home = "/home/guthrie";
    description = "Guthrie McAfee Armstrong";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.bash;
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      twemoji-color-font
      noto-fonts-emoji
      dejavu_fonts
    ];
  };

  networking = {
    # hosts = { "172.31.98.1" = [ "aruba.odyssys.net" ]; }; # Starbucks Wi-Fi
    hostName = "oryx";
    networkmanager.enable = true;
    interfaces.enp40s0.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  environment.systemPackages = with pkgs; [
    adoptopenjdk-hotspot-bin-8
    adoptopenjdk-jre-hotspot-bin-8
    adoptopenjdk-hotspot-bin-11
    adoptopenjdk-jre-hotspot-bin-11
    alsaLib
    alsaTools
    alsaUtils
    exfat
    firmwareLinuxNonfree
    git
    gnome3.dconf
    home-manager
    mesa
    networkmanager.out
    networkmanager_openvpn
    nix-prefetch-scripts
    ntfs3g
    pavucontrol
    hunspell
    hunspellDicts.en-us-large
  ];

  environment.etc = with pkgs; {
    "adoptopenjdk-hotspot-bin-8".source = adoptopenjdk-hotspot-bin-8;
    "adoptopenjdk-hotspot-bin-11".source = adoptopenjdk-hotspot-bin-11;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    geoclue2.enable = true;
    locate.enable = true;
    upower.enable = true; # hibernate on critical battery
    flatpak.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [ hplip foo2zjs ];
      browsing = true;
      defaultShared = true;
    };

    logind.lidSwitch = "hybrid-sleep";

    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "guthrie";
        lightdm.enable = true;
        lightdm.greeter.enable = true;
      };
      extraConfig = ''
        Section "InputClass"
            Identifier "Logitech USB Receiver Mouse"
            Option "ButtonMapping" "1 2 3 4 5 0 0 8 9 10 11 12 13 14 15 16 17 18 19 20"
        EndSection
      ''; # Disable strange hidden buttons on mouse
      exportConfiguration = true;
      libinput = {
        enable = true;
        touchpad.tapping = false;
        touchpad.tappingDragLock = false;
      };
      xkbOptions = "caps:none";
      videoDrivers = [ "nvidia" ];
    };

  };

  system.stateVersion = "20.09"; # not to be changed
}
