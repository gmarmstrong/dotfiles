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
  #   sudo nixos-generate-config --show-hardware-config > hosts/your-hostname/hardware-configuration.nix
  # from the target machine once partitioning is final.
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "usb_storage"
      "xhci_pci"
    ];
    kernelModules = [ ];
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
