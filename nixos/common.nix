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
  boot.plymouth.enable = true;

  hardware.opengl.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  users.extraUsers.guthrie = {
    isNormalUser = true;
    home = "/home/guthrie";
    description = "Guthrie McAfee Armstrong";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.bash;
  };

  networking.networkmanager.enable = true;

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

    xserver.enable = true;

    xserver.exportConfiguration = true;

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
    exfat
    git
    home-manager
    neovim
    networkmanager.out
    networkmanager_openvpn
    nix-prefetch-scripts
    pavucontrol
  ];

}
