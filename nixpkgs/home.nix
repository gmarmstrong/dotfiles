{ pkgs, config, lib, ... }:

let
  inherit (import <nixpkgs> {}) fetchFromGitHub zlib xkeyboard_config;
in {

  xdg = {
    enable = true;
    configFile.nixpkgs = {
      target = "nixpkgs/config.nix";
      text = ''
        { allowUnfree = true; }
      '';
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.kde.okular.desktop" ];
        "application/epub+zip" = [ "org.kde.okular.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml+xml" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "image/*" = [ "org.kde.showfoto.desktop" ];
        "video/*" = [ "vlc.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "audio/*" = [ "vlc.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "x-scheme-handler/ftp" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      android_sdk.accept_license = true;
      oraclejdk.accept_license = true;
    };

    overlays = [
      (self: super: {
        flashplayer = super.flashplayer.overrideAttrs (oldAttrs: {
          name = "flashplayer-32.0.0.238";
          version = "32.0.0.238";
          src = builtins.fetchurl {
            url = "https://fpdownload.adobe.com/get/flashplayer/pdc/32.0.0.238/flash_player_npapi_linux.x86_64.tar.gz";
            sha256 = "05gvssjdz43pvgivdngrf8qr5b30p45hr2sr97cyl6b87581qw9s";
          };
        });

        ranger = super.ranger.overrideAttrs (oldAttrs: {
          paths = with pkgs; [ poppler_utils ];
        });
      } )
    ];
  };

  imports = [
    ./home/file.nix
    ./home/packages.nix
  ];

  systemd.user.startServices = true;

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/bin/scripts:$PATH";
    MANPAGER = "nvim -c 'set ft=man' -";
    EDITOR = "nvim";
    _JAVA_OPTIONS = ''
      -Dawt.useSystemAAFontSettings=lcd
      -Djavafx.cachedir="${config.xdg.cacheHome}"
    '';
    LESSHISTFILE="/dev/null";
    XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/share:$XDG_DATA_DIRS";

  };

  services = {
    #nextcloud-client.enable = true;
    unclutter = {
      enable = true;
      timeout = 5;
    };
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [
        "00BCDF1D66A2E53946D2B6A9EE8E924B633AB33A"
      ];
    };
    #gnome-keyring = {
    #  enable = true;
    #  components = [ "pkcs11" "secrets" "ssh" ];
    #};
  };

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/resources/home-manager";
    };
    fzf.enable = true;
    firefox.enable = true;
    tmux = {
      enable = true;
      extraConfig = ''
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      '';
    };
  };
}
