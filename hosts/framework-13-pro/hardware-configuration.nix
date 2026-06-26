{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Bootstrap defaults only. Replace this file with:
  #   sudo nixos-generate-config --show-hardware-config > hosts/framework-13-pro/hardware-configuration.nix
  # from the installed Framework laptop once partitioning is final.
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "thunderbolt"
      "usb_storage"
      "xhci_pci"
    ];
    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = lib.mkDefault "/dev/disk/by-label/nixos";
    fsType = lib.mkDefault "ext4";
  };

  fileSystems."/boot" = {
    device = lib.mkDefault "/dev/disk/by-label/boot";
    fsType = lib.mkDefault "vfat";
  };

  swapDevices = [ ];
}
