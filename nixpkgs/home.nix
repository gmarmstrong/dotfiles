{ pkgs, config, ... }:

{

  imports = [
    ./home/file.nix
    ./home/packages.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/rofi.nix
    ./programs/ssh.nix
    ./programs/zsh.nix
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

    # "Whether to enable Blueman applet."
    blueman-applet.enable = true;

    # A tool to hide the mouse cursor when not used.
    unclutter = {
      enable = true; # "Whether to enable unclutter."
      timeout = 5; # "Number of seconds before the cursor is marked inactive."
    };

    # "Whether to enable GNOME Keyring."
    gnome-keyring.enable = true;

    # A daemon to manage private keys independently from any protocol.
    gpg-agent = {
      enable = true; # "Whether to enable GnuPG private key agent."
      enableSshSupport = true; # "Whether to use the GnuPG key agent for SSH keys."
    };
  };

  programs = {
    home-manager = {
      enable = true; # "Whether to enable Home Manager."
      path = "${config.home.homeDirectory}/dotfiles/home-manager"; # "The default path to use for Home Manager."
    };

    neovim.enable = true; # "Whether to enable Neovim."
    firefox.enable = true; # "Whether to enable Firefox."
  };

  xsession = {

    # "Whether to enable X Session."
    enable = true;

    # "Extra shell commands to run before session start."
    profileExtra = ''
      nm-applet &
      pasystray &
      nextcloud &
    '';

    # "Extra shell commands to run during initialization."
    initExtra = ''
      xset s off
    '';
  };
}
