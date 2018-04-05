{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    home-manager = {
      enable = true;
      path = "https://github.com/rycee/home-manager/archive/release-17.09.tar.gz";
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
    hugo
    imagemagick
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
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
    signal-desktop
    slack
    spotify
    sxiv
    texlive.combined.scheme-full
    thunderbird
    tor-browser-bundle-bin
    transmission_gtk
    trash-cli
    tree
    unclutter
    vlc
    w3m
    xclip
    xpdf
    youtube-dl
    zathura
    zotero
    zsh
  ];

}
