{ pkgs, config, ... }:

{

  system.stateVersion = "18.03"; # compatible NixOS release

  time.timeZone = "America/New_York";

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

  hardware = {
    #enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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
    pam.services = [ { name = "gnomekeyring"; enableGnomeKeyring = true; } ];
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

  users = {
    users.guthrie = {
      isNormalUser = true;
      home = "/home/guthrie";
      description = "Guthrie McAfee Armstrong";
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      shell = pkgs.bash;
    };
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
    hosts = { "172.31.98.1" = [ "aruba.odyssys.net" ]; }; # Starbucks Wi-Fi
    networkmanager.enable = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    alsaLib
    alsaTools
    alsaUtils
    exfat
    firmwareLinuxNonfree
    git
    gnome3.dconf
    gnome3.gnome-keyring
    gnome3.seahorse
    home-manager
    mesa
    neovim
    networkmanager.out
    networkmanager_openvpn
    nix-prefetch-scripts
    ntfs3g
    pavucontrol
  ];

  networking.hostName = "nixos";

  swapDevices = [ { device = "/dev/disk/by-uuid/13f26b63-cf59-49c8-bc44-44bd5fc4c9b2"; } ];

  boot.earlyVconsoleSetup = true; # set font in initrd

  boot.loader.grub = {
    device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
    configurationLimit = 50; # prevent overfilling /boot (NixOS/nixpkgs/issues/23926)
    extraConfig = ''
      GRUB_GFXMODE=1920x1080
      GRUB_GFXPAYLOAD="keep"
    '';
  };

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";
    }
  ];

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    adb.enable = true;
    light.enable = true;
    seahorse.enable = true;
  };

  services = {
    blueman.enable = true;
    dbus = {
      packages = with pkgs; [ gnome3.gnome-keyring gnome3.gcr ];
      socketActivated = true;
    };
    geoclue2.enable = true;
    locate.enable = true;
    upower.enable = true; # hibernate on critical battery

    gnome3 = {
      at-spi2-core.enable = true; # https://github.com/NixOS/nixpkgs/pull/15365#issuecomment-218451375
      gnome-keyring.enable = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [ hplip foo2zjs ];
      browsing = true;
      defaultShared = true;
    };

    physlock = {
      enable = true;
      allowAnyUser = true;
    };

    logind.lidSwitch = "hybrid-sleep";

    xserver = {
      enable = true;
      exportConfiguration = true;
      multitouch.enable = true;
      libinput = {
        enable = true;
        tapping = false;
        tappingDragLock = false;
      };
      displayManager.lightdm = {
        enable = true;
        background = "black";
        greeter.enable = false;
        autoLogin = {
          enable = true;
          user = "guthrie";
        };
      };
      videoDrivers = [ "i915" "mesa" "intel" "modesetting" ];
    };

  };


}
