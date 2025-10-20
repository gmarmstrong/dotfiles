{
  hostname = "101206-F724N5WGX2";
  username = "guthrie";
  managedDevice = true;
  # Nix is managed by DeterminateSystems/nix-installer, not nix-darwin
  manageNix = false;
  homeStateVersion = "25.05";
  gitName = "Guthrie McAfee Armstrong";
  gitEmail = "guthrie.armstrong@coalitioninc.com";
  gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFExjJSzkWHd1Qi92WE/AENwHKVRwPFfYo/K83LsIkQ7";
  capabilities = [
    "core"
    "container"
    "ai"
    "golang"
    "terraform"
    "aws"
  ];
}
