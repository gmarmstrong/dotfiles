{ pkgs, config, ... }:

{

  environment = {

    # "The set of packages that appear in `/run/current-syste/sw`. These
    # packages are automatically available to all users, and are automatically
    # updated every time you rebuild the system configuration. (The latter is
    # the main difference with installing them in the default profile,
    # `/nix/var/nix/profiles/default`."
    systemPackages = with pkgs; [
      firmwareLinuxNonfree
      git
      neovim
      networkmanager.out
      nix-prefetch-scripts
      vulnix
    ];

    # "A set of environment variables used in the global environment. These
    # variables will be set on shell initialisation (e.g., in `/etc/profile`).
    # The value of each variable can be either a string or a list of strings.
    # The latter is concatenated, interspersed with colon characters."
    variables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };

  imports = [ /etc/nixos/hardware-configuration.nix ];

  # "Whether to use NetworkManager to obtain an IP address and other
  # configuration for all network interfaces that are not manually configured.
  # If enabled, a group `networkmanager` will be created. Add all users that
  # should have permission to change network settings to this group."
  networking.networkmanager.enable = true;

  programs = {

    # "Enables GnuPG agent with socket-activation for every user session."
    gnupg.agent.enable = true;

    # "Enable Bash completion for all interactive bash shells."
    bash.enableCompletion = true;
  }

  security = {

    # "Enable the AppArmor Mandatory Access Control system."
    apparmor.enable = true;

    # "Whether to enable the sudo command, which allows non-root users to
    # execute commands as root."
    sudo.enable = true;

    # "Any polkit rules to be added to config (in JavaScript ;-). See:
    # http://www.freedesktop.org/software/polkit/docs/latest/polkit.8.html#polkit-rules"
    polkit.extraConfig = ''
      // Allow wheel users to mount filesystems
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
            action.id == "org.freedesktop.udisks2.filesystem-mount") &&
            subject.isInGroup("wheel")) { return polkit.Result.YES; }
      });
    '';
  };

  # "If enabled, NixOS will periodically update the database of files used by
  # the locate command."
  services.locate.enable = true;

  # NixOS release version with which to be compatible. NixOS will option
  # defaults corresponding to the specified release.
  system.stateVersion = "18.03";

}
