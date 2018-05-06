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
    ./services/redshift.nix
    ./xdg.nix
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
      timeout = 5;
    };
    gpg-agent.enable = true;
  };

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/home-manager";
    };
    neovim.enable = true;
    firefox.enable = true;
    ssh = {
      enable = true;
      matchBlocks = {
        "nike" = {
          hostname = "nike.cs.uga.edu";
          user = "gma";
        };
        "nikex" = {
          hostname = "nike.cs.uga.edu";
          user = "gma";
          forwardX11 = true;
        };
      };
    };
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
