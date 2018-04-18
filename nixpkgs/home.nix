{ pkgs, config, ... }:

{

  imports = [
    ./programs/git.nix
    ./programs/rofi.nix
    ./programs/fzf.nix
    ./programs/htop.nix
    ./programs/zsh.nix
    ./services/compton.nix
    ./services/polybar.nix
    ./xdg.nix
    ./xresources.nix
    ./xsession/windowManager/i3.nix
    ./home/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  systemd.user.startServices = true;

  services = {
    blueman-applet.enable = true;
    unclutter = {
      enable = true;
      threshold = 5;
    };
    xscreensaver.enable = false;
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
      xrdb -load "${config.home.homeDirectory}/Xresources" &
      hsetroot -solid \#d8d8d8 &
      nm-applet &
      pasystray &
      nextcloud &
      xset s off &
    '';
  };

}
