{
  hostname = "framework-13-pro";
  username = "guthrie";
  system = "x86_64-linux";

  # Framework Laptop 13 Pro uses Intel Core Ultra Series 3.
  cpuVendor = "intel";

  # Personal device: install personal tooling such as 1Password.
  managedDevice = false;

  homeStateVersion = "25.05";
  systemStateVersion = "25.05";

  gitName = "Guthrie McAfee Armstrong";

  # Replace with the exact personal Git email before first switch if needed.
  gitEmail = "guthrie@users.noreply.github.com";

  gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFExjJSzkWHd1Qi92WE/AENwHKVRwPFfYo/K83LsIkQ7";

  hardwareModules = [
    ./hardware-configuration.nix
  ];

  capabilities = [
    "core"
    "container"
    "gui"
    "golang"
  ];
}
