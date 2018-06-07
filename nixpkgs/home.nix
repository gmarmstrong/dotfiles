{ pkgs, config, ... }:

{

  imports = [
    ./home/file.nix
    ./home/packages.nix
    ./programs/bash.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/rofi.nix
    ./programs/ssh.nix
    ./services/compton.nix
    ./services/polybar.nix
    ./services/redshift.nix
    ./xdg.nix
    ./xresources.nix
    ./xsession/windowManager/i3.nix
  ];

  # "The configuration of the Nix Packages collection. [...] Note, this option
  # will not apply outside your Home Manager configuration like when installing
  # manually through nix-env."
  nixpkgs.config.allowUnfree = true;

  # "Start all services that are wanted by active targets. Additionally, stop
  # obsolete services from the previous generation."
  systemd.user.startServices = true;

  services = {

    # Tray applet for managing Bluetooth
    blueman-applet.enable = true;

    # Remove idle cursor image from screen
    unclutter = {
      enable = true;
      timeout = 5;
    };

    # GNOME Keyring, a daemon that stores secrets, passwords, keys, and certificates
    gnome-keyring.enable = true;

    # GnuPG private key agent, a daemon for managing private keys.
    gpg-agent = {
      enable = true;
      enableSshSupport = true; # "Whether to use the GnuPG key agent for SSH keys."
    };
  };

  programs = {

    # Home Manager, a system to manage a user environment using Nix
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/resources/home-manager";
    };

    neovim.enable = true; # "Whether to enable Neovim."
    firefox.enable = true; # "Whether to enable Firefox."
  };

  # Xsession, a script run when an X Window System session is begun.
  xsession = {
    enable = true;

    # "Extra shell commands to run before session start."
    profileExtra = ''
      pasystray & # PulseAudio controller for the system tray
      nextcloud & # File synchronization desktop utility
    '';

    # "Extra shell commands to run during initialization."
    initExtra = ''
      xset s off # disable screen saver
    '';
  };
}
