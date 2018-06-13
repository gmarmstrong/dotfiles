{ pkgs, config, ... }:

{

  imports = [
    ./config/bash.nix
    ./config/compton.nix
    ./config/fzf.nix
    ./config/git.nix
    ./config/htop.nix
    ./config/i3.nix
    ./config/neovim.nix
    ./config/nixpkgs.nix
    ./config/polybar.nix
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
    _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on";
  };

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
      path = "${config.home.homeDirectory}/dotfiles/resources/home-manager";
    };
    firefox.enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = ''
      ${pkgs.pasystray}/bin/pasystray &
      ${pkgs.nextcloud-client}/bin/nextcloud &
    '';
    initExtra = ''
      xset s off # disable screen saver
    '';
  };
}
