{
  # The hostname of this machine
  # On macOS, you can find this with: hostname
  hostname = "example-macos";

  # The username for this machine
  # This should match your macOS user account
  username = "your-username";

  # Whether this is a managed device (e.g., corporate laptop with MDM)
  # Set to true if the device is managed, which will:
  # - Skip installing 1Password (assumed to be managed by the organization)
  # - Adjust other settings as needed for managed environments
  managedDevice = false;

  # Whether nix-darwin should manage the Nix installation
  # Set to false if you're using alternative Nix installers like:
  # - DeterminateSystems/nix-installer
  # - NixOS/experimental-nix-installer
  # These installers manage their own daemon and conflict with nix-darwin's Nix management
  # Set to true for standard Nix installations
  manageNix = true;

  # Home Manager state version
  # Should match the release version you're using
  # See: https://nix-community.github.io/home-manager/release-notes.xhtml
  homeStateVersion = "25.05";

  # Git configuration
  gitName = "Your Name";
  gitEmail = "your.email@example.com";

  # Git signing key (SSH format recommended)
  # Generate with: ssh-keygen -t ed25519 -C "your.email@example.com"
  # Then get the public key: cat ~/.ssh/id_ed25519.pub
  gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExampleKeyDataHere";

  # Capabilities define which package sets to install
  # Available capabilities:
  #   - core: Essential CLI tools (jq, tree, wget, etc.)
  #   - container: Docker and container tools (colima on macOS)
  #   - ai: AI/ML tools (ollama)
  #   - golang: Go development tools
  #   - terraform: Terraform and related tools (tenv, tflint, terraform-docs)
  #   - aws: AWS CLI and related tools
  #   - gui: GUI applications (1Password GUI, etc. - only on non-managed devices)
  #
  # See modules/capabilities.nix for the complete list of packages per capability
  capabilities = [
    "core"
    "container"
    "golang"
  ];
}
