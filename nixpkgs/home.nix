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

  nixpkgs.config.allowUnfree = true;

  systemd.user.startServices = true;

  services = {
    blueman-applet.enable = true;
    unclutter = {
      enable = true;
      timeout = 5;
    };
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/home-manager";
    };
    neovim.enable = true;
    firefox.enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = ''
      nm-applet &
      pasystray &
      nextcloud &
    '';
    initExtra = ''
      xset s off
    '';
  };

}
