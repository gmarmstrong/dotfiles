{ pkgs, config, ... }:

{

  imports = [
    ./config/bash.nix
    ./config/fzf.nix
    ./config/git.nix
    ./config/htop.nix
    ./config/i3.nix
    ./config/neovim.nix
    ./config/nixpkgs.nix
    ./config/polybar.nix
    ./config/qutebrowser.nix
    ./config/ranger.nix
    ./config/readline.nix
    ./config/rofi.nix
    ./config/ssh.nix
    ./config/user-dirs.nix
    ./config/xresources.nix
    ./config/zathura.nix
    ./home/file.nix
    ./home/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  systemd.user.startServices = true;
  xdg.enable = true;

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/bin/scripts:$PATH";
    MANPAGER = "nvim -c 'set ft=man' -";
    EDITOR = "nvim";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    COLORTHEME = "base16-gruvbox-light-hard";
    LESSHISTFILE="/dev/null";
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans 9";
    };
    gtk2.extraConfig = ''
      [Filechooser Settings]
      StartupMode=cwd
    '';
    gtk3.extraConfig = {
      gtk-recent-files-enabled = false;
      gtk-recent-files-max-age = 0;
      gtk-recent-files-limit = 0;
    };
  };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    pasystray.enable = true;
    unclutter = {
      enable = true;
      timeout = 5;
    };
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/resources/home-manager";
    };
    firefox = {
      enable = true;
      enableAdobeFlash = true;
      enableGoogleTalk = true;
      enableIcedTea = true;
    };
  };

  xsession = {
    enable = true;
    profileExtra = ''
      nextcloud &
    '';
    initExtra = ''
      xset s off # disable screen saver
    '';
  };
}
