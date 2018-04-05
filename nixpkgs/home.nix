{ pkgs, ... }:

# TODO create skeleton directory tree
# TODO clone password-store
# TODO install clustergit (use nixpkgs)
# TODO configure X11

{

  nixpkgs.config.allowUnfree = true;

  programs = {

    home-manager = {
      enable = true;
      path = "$HOME/dotfiles/home-manager";
    };

    firefox.enable = true;

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
    extraConfig = builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "chriskempson";
        repo = "base16-xresources";
        rev = "79e6e1de591f7444793fd8ed38b67ce7fce25ab6";
        sha256 = "1nnj5py5n0m8rkq3ic01wzyzkgl3g9a8q5dc5pcgj3qr47hhddbw";
      } + "/xresources/base16-gruvbox-light-hard-256.Xresources"
    );
  };

  home.packages = with pkgs; [
    androidsdk
    ardour
    byzanz
    calc
    calibre
    dict
    diction
    feh
    figlet
    firefox
    gnome3.gnome_keyring
    gnupg
    hugo
    imagemagick
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    json_c
    libreoffice
    maven
    neovim
    nextcloud-client
    openjdk
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
    w3m
    xclip
    youtube-dl
    zathura
    zotero
    zsh
  ];

}
