{ pkgs, config, lib, ... }:

let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
in {

  xdg.configFile.nixpkgs = {
    target = "nixpkgs/config.nix";
    text = ''
      { allowUnfree = true; }
    '';
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
      oraclejdk.accept_license = true;
    };
    overlays = [
      (self: super: {
        multimc = super.multimc.overrideAttrs (oldAttrs: {
          src = fetchFromGitHub {
            owner = "MultiMC";
            repo = "MultiMC5";
            rev = "0.6.7";
            sha256 = "1i160rmsdvrcnvlr6m2qjwkfx0lqnzrcifjkaklw96ina6z6cg2n";
            fetchSubmodules = true;
          };
        });
        flashplayer = super.flashplayer.overrideAttrs (oldAttrs: {
          name = "flashplayer-32.0.0.238";
          version = "32.0.0.238";
          src = builtins.fetchurl {
            url = "https://fpdownload.adobe.com/get/flashplayer/pdc/32.0.0.238/flash_player_npapi_linux.x86_64.tar.gz";
            sha256 = "05gvssjdz43pvgivdngrf8qr5b30p45hr2sr97cyl6b87581qw9s";
          };
        });
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

  fonts.fontconfig.enable = true;

  imports = [
    ./config/bash.nix
    ./config/fzf.nix
    ./config/git.nix
    ./config/htop.nix
    ./config/i3.nix
    ./config/neovim.nix
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
    COLORTHEME = "base16-gruvbox-light-hard";
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
  # FIXME Overwritten
  # xdg.configFile.gtkFileChooser = {
  #   target = "gtk-2.0/gtkfilechooser.ini";
  #   text = ''
  #     [Filechooser Settings]
  #     LocationMode=path-bar
  #     ShowHidden=false
  #     ShowSizeColumn=true
  #     GeometryX=570
  #     GeometryY=247
  #     GeometryWidth=780
  #     GeometryHeight=585
  #     SortColumn=name
  #     SortOrder=ascending
  #     StartupMode=cwd
  #   '';
  # };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    nextcloud-client.enable = true;
    pasystray.enable = true;
    dunst = {
      enable = true;
      settings = {
        global = {
          frame_color = "#504945";
          separator_color = "#504945";
          geometry = "300x5-30+50";
          font = "DejaVuSansMono Nerd Font Complete Mono:size=12";
        };
        base16_low = {
          msg_urgency = "low";
          background = "#ebdbb2";
          foreground = "#bdae93";
        };
        base16_normal = {
          msg_urgency = "normal";
          background = "#d5c4a1";
          foreground = "#504945";
        };
        base16_critical = {
          msg_urgency = "critical";
          background = "#9d0006";
          foreground = "#504945";
        };
      };
    };
    redshift = {
      enable = true;
      provider = "geoclue2";
    };
    unclutter = {
      enable = true;
      timeout = 5;
    };
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
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
    initExtra = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
      export SSH_AUTH_SOCK
      xset s off -dpms # disable screen saver
    '';
  };
}
