{
  # The hostname of this machine
  hostname = "example-nixos";

  # The username for this machine
  username = "your-username";

  # Most personal laptops and desktops are x86_64-linux.
  system = "x86_64-linux";

  # Set to "intel", "amd", or null to control CPU microcode helpers.
  cpuVendor = null;

  # Whether this is a managed device, such as a corporate laptop.
  # Set to true if organization-managed tools should replace personal tools.
  managedDevice = false;

  # Home Manager and NixOS state versions.
  # These should match the release version used for this host's initial install.
  homeStateVersion = "25.05";
  systemStateVersion = "25.05";

  # Git configuration
  gitName = "Your Name";
  gitEmail = "your.email@example.com";

  # Git signing key (SSH format recommended)
  gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExampleKeyDataHere";

  # Replace this file with the hardware config generated on the target machine.
  hardwareModules = [
    ./hardware-configuration.nix
  ];

  # Capabilities define which package sets to install
  # Available capabilities:
  #   - core: Essential CLI tools (jq, tree, wget, etc.)
  #   - container: Docker and container tools
  #   - ai: AI/ML tools (ollama)
  #   - golang: Go development tools
  #   - terraform: Terraform and related tools (tenv, tflint, terraform-docs)
  #   - aws: AWS CLI and related tools
  #   - gui: GUI applications and fonts
  #
  # See modules/capabilities.nix for the complete list of packages per capability
  capabilities = [
    "core"
    "gui"
  ];
}
