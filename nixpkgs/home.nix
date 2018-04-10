{ pkgs, ... }:

# TODO create skeleton directory tree
# TODO clone password-store
# TODO install clustergit (use nixpkgs)
# TODO configure X11

{

  nixpkgs.config.allowUnfree = true;

  systemd.user.startServices = true;

  services = {
    blueman-applet.enable = true;
    unclutter = {
      enable = true;
      threshold = 5;
    };
  };

  programs = {

    home-manager = {
      enable = true;
      path = "$HOME/dotfiles/home-manager";
    };

    command-not-found.enable = true;

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

    git = {
      enable = true;
      userName = "gmarmstrong";
      userEmail = "guthrie.armstrong@gmail.com";
      signing.key = "100B37EAF2164C8B";
      extraConfig = {
        core = {
          excludesFile = "$HOME/dotfiles/git/ignore";
          attributesFile = "$HOME/dotfiles/git/attributes";
          editor = "${pkgs.neovim}/bin/nvim";
        };
        # FIXME diff.gpg.textconv = "gpg --no-tty --decrypt --quiet";
        commit.gpgsign = true;
        gpg.program = "${pkgs.gnupg}/bin/gpg";
        credential.helper = "cache";
      };
    };

    rofi = {
      enable = true;
      scrollbar = false;
      terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
    };

  };

  xresources = {
    properties = {
      "URxvt.termName" = "rxvt-unicode-256color";
      "URxvt.iso14755" = false;
      "URxvt.internalBorder" = 30;
      "URxvt.scrollBar" = false;
      "URxvt.scrollTtyOutput" = false;
      "URxvt.scrollWithBuffer" = true;
      "URxvt.scrollTtyKeypress" = true;
      "URxvt.secondaryScreen" = 1;
      "URxvt.secondaryScroll" = 0;
      "URxvt.perl-ext" = "";
      "URxvt.perl-ext-common" = "font-size";
      "URxvt.font" = "xft:DejaVu Sans Mono:size=11";
      "URxvt.keysym.C-plus" = "font-size:increase";
      "URxvt.keysym.C-minus" = "font-size:decrease";
      "URxvt.keysym.C-equal" = "font-size:reset";
      "URxvt.keysym.C-slash" = "font-size:show";
      "Xft.autohint" = 1;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };
    extraConfig = builtins.readFile ( pkgs.fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-xresources";
      rev = "79e6e1de591f7444793fd8ed38b67ce7fce25ab6";
      sha256 = "1nnj5py5n0m8rkq3ic01wzyzkgl3g9a8q5dc5pcgj3qr47hhddbw";
    } + "/xresources/base16-gruvbox-light-hard-256.Xresources");
  };

  home = {

    file = {
      i3 = {
        recursive = true;
        target = ".config/i3/";
        source = "/home/guthrie/dotfiles/i3/";
      };
      i3status = {
        recursive = true;
        target = ".config/i3status/";
        source = "/home/guthrie/dotfiles/i3status/";
      };
      nvim-ftplugin = {
        recursive = true;
        target = ".config/nvim/ftplugin/";
        source = "/home/guthrie/dotfiles/nvim/ftplugin/";
      };
      nvim-gnupg = {
        target = ".config/nvim/gnupg.vim";
        source = "/home/guthrie/dotfiles/nvim/gnupg.vim";
      };
      nvim-init = {
        target = ".config/nvim/init.vim";
        source = "/home/guthrie/dotfiles/nvim/init.vim";
      };
      nvim-init-secure = {
        target = ".config/nvim/vimrc_secure";
        source = "/home/guthrie/dotfiles/nvim/vimrc_secure";
      };
      zshrc = {
        target = ".config/zsh/.zshrc";
        source = "/home/guthrie/dotfiles/zsh/zshrc";
      };
      zaliases = {
        target = ".config/zsh/.zaliases";
        source = "/home/guthrie/dotfiles/zsh/zaliases";
      };
      zshenv = {
        target = ".zshenv";
        source = "/home/guthrie/dotfiles/zsh/zshenv";
      };
    };

    packages = with pkgs; [
      androidsdk
      ardour
      audacity
      byzanz
      calc
      calibre
      dict
      diction
      feh
      figlet
      firefox
      gnome3.gnome_keyring
      gnumake
      gnupg
      go
      gx
      gx-go
      hugo
      imagemagick
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      json_c
      libreoffice
      maven
      neovim
      nextcloud-client
      openssh
      pandoc
      pass
      polybar
      postgresql
      python
      python3
      ranger
      rofi
      rofi-pass
      rsync
      rxvt_unicode_with-plugins
      scrot
      signal-desktop
      slack
      spotify
      sshfs
      sxiv
      texlive.combined.scheme-full
      transmission_gtk
      trash-cli
      tree
      unclutter
      vlc
      virtualbox
      w3m
      xclip
      youtube-dl
      zathura
      zotero
      zsh
    ];
  };

}
