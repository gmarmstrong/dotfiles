{ pkgs, config, ... }:

{

  imports = [ ../personal.nix ];

  # "The swap devices and swap files. These must have been initialised using
  # mkswap. Each element should be an attribute set specifying either the path
  # of the swap device or file (device) or the label of the swap device (label,
  # see mkswap -L). Using a label is recommended."
  swapDevices = [ { device = "/dev/disk/by-uuid/13f26b63-cf59-49c8-bc44-44bd5fc4c9b2"; } ];

  boot = {

    # "The encrypted disk that should be opened before the root filesystem is
    # mounted. Both LVM-over-LUKS and LUKS-over-LVM setups are supported. The
    # unencrypted devices can be accessed as /dev/mapper/name."
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/5c42abea-a365-4e2c-b2bd-584ee69cca55";
      }
    ];

    loader.grub = {

      # "Whether to enable the GNU GRUB boot loader."
      enable = true;

      # "The device on which the GRUB boot loader will be installed. The
      # special value nodev means that a GRUB boot menu will be generated, but
      # GRUB itself will not actually be installed. To install GRUB on multiple
      # devices, use boot.loader.grub.devices."
      device = "/dev/disk/by-id/wwn-0x500a075114dcdeb7";
    };
  };

  # "Update the CPU microcode for Intel processors."
  hardware.cpu.intel.updateMicrocode = true;

  # "The name of the machine. Leave it empty if you want to obtain it from a
  # DHCP server (if using DHCP)."
  networking.hostName = "nixos-thinkpad";

  # Whether to configure system to use Android Debug Bridge (adb). To grant
  # access to a user, it must be part of adbusers group:
  # users.extraUsers.alice.extraGroups = ["adbusers"];
  programs.adb.enable = true;

  xserver = {

    libinput = {

      # "Whether to enable libinput."
      enable = true;

      # Enables middle button emulation. When enabled, pressing the left and
      # right buttons simultaneously produces a middle mouse button click.
      middleEmulation = false;

      # "Specify the scrolling method: twofinger, edge, or none"
      scrollMethod = "twofinger";

      # "Enables or disables tap-to-click behavior."
      tapping = false;

      # "Enables or disables drag lock during tapping behavior. When enabled, a
      # finger up during tap- and-drag will not immediately release the button.
      # If the finger is set down again within the timeout, the draging process
      # continues."
      tappingDragLock = false;
    };

    # "Whether to enable multitouch touchpad support."
    multitouch.enable = true;
  };

  # "Whether to enable VirtualBox."
  virtualisation.virtualbox.host.enable = true;

}
