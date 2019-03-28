{ pkgs, config, ... }:

{

  system.stateVersion = "18.03"; # NixOS release version

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs : rec { i3Support = true; };
  };

  fonts.fonts = with pkgs; [
    twemoji-color-font
    dejavu_fonts
  ];

  boot.earlyVconsoleSetup = true;

  hardware.opengl.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  users.extraUsers.guthrie = {
    isNormalUser = true;
    home = "/home/guthrie";
    description = "Guthrie McAfee Armstrong";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.bash;
  };

  networking = {
    hosts = {
      "172.31.98.1" = [ "aruba.odyssys.net" ];
    };
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  security = {
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

  powerManagement.enable = true;

  services = {
    colord.enable = true;
    dbus.packages = [ pkgs.blueman ];
    dictd.enable = true;
    locate.enable = true;
    udisks2.enable = true;
    upower.enable = true; # hibernate on critical battery

    gnome3 = {
      at-spi2-core.enable = true; # https://github.com/NixOS/nixpkgs/pull/15365#issuecomment-218451375
      gnome-keyring.enable = true;
      seahorse.enable = true;
    };

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

    xserver.enable = true;

    xserver.exportConfiguration = true;

    xserver.desktopManager.kodi.enable = true;
    xserver.displayManager.lightdm = {
      enable = true;
      background = "black";
      greeter.enable = false;
      autoLogin = {
        enable = true;
        user = "guthrie";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    alsaLib
    alsaTools
    alsaUtils
    gnome3.dconf # seahorse dependency
    exfat
    git
    home-manager
    neovim
    networkmanager.out
    networkmanager_openvpn
    nix-prefetch-scripts
    ntfs3g
    pavucontrol
  ];

}
