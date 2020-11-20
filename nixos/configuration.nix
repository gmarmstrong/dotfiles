{ pkgs, config, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{

  imports = [
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/New_York";
  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true; # Automatic Nix garbage collection

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    nvidia.prime = { # https://nixos.wiki/wiki/Nvidia#offload_mode
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

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
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
      twemoji-color-font
      dejavu_fonts
    ];
  };

  networking = {
    # hosts = { "172.31.98.1" = [ "aruba.odyssys.net" ]; }; # Starbucks Wi-Fi
    # hostName = "nixos";
    networkmanager.enable = true;
    interfaces.enp40s0.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  environment.systemPackages = with pkgs; [
    nvidia-offload # shell script for using Nvidia Optimus in offload mode
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
    dbus.socketActivated = true;
    geoclue2.enable = true;
    locate.enable = true;
    upower.enable = true; # hibernate on critical battery
    # postgresql = {
    #   enable = true;
    #   ensureUsers = [ { name = "guthrie"; } ];
    # };

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
        tapping = false;
        tappingDragLock = false;
      };
      xkbOptions = "caps:none";
      videoDrivers = [ "nvidia" ];
    };

  };

  system.stateVersion = "20.09"; # not to be changed
}
