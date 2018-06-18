{ config, pkgs, lib, ... }:

{

  boot.loader.grub.enable = false;
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''
    start_x=1
    gpu_mem=256
  '';
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "cma=32M"
    "console=ttyS0,115200n8"
  ];
  boot.kernelModules = [ "bcm2835-v4l2" ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "ext4";
    };
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.stdenv.mkDerivation {
      name = "broadcom-rpi3-extra";
      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/RPi-Distro/firmware-nonfree/54bab3d/brcm80211/brcm/brcmfmac43430-sdio.txt";
        sha256 = "19bmdd7w0xzybfassn7x4rb30l70vynnw3c80nlapna2k57xwbw7";
      };
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        cp $src $out/lib/firmware/brcm/brcmfmac43430-sdio.txt
      '';
    })
  ];
  networking.wireless.enable = true;

}
