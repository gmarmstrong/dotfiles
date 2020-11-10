{ pkgs, config, ... }:

{

  system.stateVersion = "18.03"; # compatible NixOS release

  time.timeZone = "America/New_York";

  virtualisation.kvmgt.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      i3Support = true;
      nextcloud-client = pkgs.nextcloud-client.override {
        # https://discourse.nixos.org/t/nextcloud-and-keyrings/1339/3
        withGnomeKeyring = true;
        libgnome-keyring = pkgs.gnome3.libgnome-keyring;
      };
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiIntel libvdpau-va-gl vaapiVdpau libglvnd
      ];
      extraPackages = with pkgs; [
        vaapiIntel libvdpau-va-gl vaapiVdpau
      ];
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };

  security = {
    # pam.services.gnomekeyring.enableGnomeKeyring = true;
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
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
      twemoji-color-font
      dejavu_fonts
    ];
  };

  networking = {
    # hosts = { "172.31.98.1" = [ "aruba.odyssys.net" ]; }; # Starbucks Wi-Fi
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlp3s0.useDHCP = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];

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
    neovim
    networkmanager.out
    networkmanager_openvpn
    nix-prefetch-scripts
    ntfs3g
    pavucontrol
  ];

  environment.etc = with pkgs; {
    "adoptopenjdk-hotspot-bin-8".source = adoptopenjdk-hotspot-bin-8;
    "adoptopenjdk-hotspot-bin-11".source = adoptopenjdk-hotspot-bin-11;
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/13f26b63-cf59-49c8-bc44-44bd5fc4c9b2"; } ];

  boot.loader.grub = {
    device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
    configurationLimit = 50; # prevent overfilling /boot (NixOS/nixpkgs/issues/23926)
    extraConfig = ''
      GRUB_GFXMODE=1920x1080
      GRUB_GFXPAYLOAD="keep"
    '';
  };

  boot.initrd.luks.devices.root.device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";

  console.earlySetup = true; # set font in initrd

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    adb.enable = true;
    light.enable = true;
  };

  services = {
    dbus.socketActivated = true;
    geoclue2.enable = true;
    locate.enable = true;
    upower.enable = true; # hibernate on critical battery
    postgresql = {
      enable = true;
      ensureUsers = [ { name = "guthrie"; } ];
    };

    printing = {
      enable = true;
      drivers = with pkgs; [ hplip foo2zjs ];
      browsing = true;
      defaultShared = true;
    };

    logind.lidSwitch = "hybrid-sleep";

    xserver = {
      enable = true;
      extraConfig = ''
        Section "InputClass"
            Identifier "Logitech USB Receiver Mouse"
            Option "ButtonMapping" "1 2 3 4 5 0 0 8 9 10 11 12 13 14 15 16 17 18 19 20"
        EndSection
      ''; # Disable strange hidden buttons on mouse
      exportConfiguration = true;
      libinput = {
        enable = true;
        tapping = false;
        tappingDragLock = false;
      };
      desktopManager.plasma5.enable = true;
      displayManager.lightdm = {
        enable = true;
        #background = "black";
        greeter.enable = true;
        autoLogin = {
          enable = true;
          user = "guthrie";
        };
      };
      xkbOptions = "caps:none";
      videoDrivers = [ "i915" "mesa" "intel" "modesetting" ];
    };

  };
}
