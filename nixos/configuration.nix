{ pkgs, config, ... }:

{

  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    firmwareLinuxNonfree
  ];

  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = "nixos";

  swapDevices = [ { device = "/dev/disk/by-uuid/13f26b63-cf59-49c8-bc44-44bd5fc4c9b2"; } ];

  boot.loader.grub.device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
  boot.loader.grub.configurationLimit = 50; # prevent overfilling /boot (NixOS/nixpkgs/issues/23926)

  boot.loader.grub.extraConfig = ''
    GRUB_GFXMODE=1920x1080
    GRUB_GFXPAYLOAD="keep"
  '';

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";
    }
  ];

  services.logind.lidSwitch = "hybrid-sleep";

  services.xserver.multitouch.enable = true;

  services.xserver.libinput = {
    enable = true;
    tapping = false;
    tappingDragLock = false;
  };

}
