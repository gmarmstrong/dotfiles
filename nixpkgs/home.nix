{ pkgs, config, ... }:

{

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        blueman = super.blueman.overrideAttrs (oldAttrs: {
          # TODO: See https://github.com/NixOS/nixpkgs/issues/44548
          buildInputs = oldAttrs.buildInputs ++ [ self.gnome3.adwaita-icon-theme ];
        });
        ranger = super.ranger.overrideAttrs (oldAttrs: {
          paths = with pkgs; [ poppler_utils ];
        });
      } )
    ];
  };

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

  systemd.user.startServices = true;
  xdg.enable = true;

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/bin/scripts:$PATH";
    MANPAGER = "nvim -c 'set ft=man' -";
    EDITOR = "nvim";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    COLORTHEME = "base16-gruvbox-light-soft";
    LESSHISTFILE="/dev/null";
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans 9";
    };
    iconTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3.extraConfig = {
      gtk-recent-files-enabled = false;
      gtk-recent-files-max-age = 0;
      gtk-recent-files-limit = 0;
    };
  };
  xdg.configFile.gtkFileChooser = {
    target = "gtk-2.0/gtkfilechooser.ini";
    text = ''
      [Filechooser Settings]
      LocationMode=path-bar
      ShowHidden=false
      ShowSizeColumn=true
      GeometryX=570
      GeometryY=247
      GeometryWidth=780
      GeometryHeight=585
      SortColumn=name
      SortOrder=ascending
      StartupMode=cwd
    '';
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
    tmux = {
      enable = true;
      extraConfig = ''
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      '';
    };
  };

  xsession = {
    enable = true;
    profileExtra = ''
      nextcloud &
    '';
    initExtra = ''
      xset s off -dpms # disable screen saver
    '';
  };
}
