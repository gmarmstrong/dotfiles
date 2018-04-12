{ pkgs, config, ... }:

# TODO create skeleton directory tree
# TODO clone password-store
# TODO install clustergit (use nixpkgs)

{

  imports = [
    ./programs/git.nix
    ./programs/rofi.nix
    ./services/polybar.nix
    ./xresources.nix
    ./xsession/windowManager/i3.nix
    ./home/packages.nix
    ./home/file.nix
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

    firefox = {
      enable = true;
      #enableAdobeFlash = true;
      #enableGoogleTalk = true;
      #enableIcedTea = true;
    };

    htop = {
      enable = true;
      fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];
      hideThreads = true;
      highlightBaseName = true;
    };

  };

  xsession = {
    enable = true;
    profileExtra = ''
      xrdb -load "$HOME/.config/X11/Xresources" &
      xsetroot -solid \#f2e5bc
      nm-applet &
      pasystray &
      nextcloud &
    '';
  };

}
