{ pkgs, ... }:

# TODO create skeleton directory tree
# TODO clone password-store
# TODO install clustergit (use nixpkgs)
# TODO configure X11

{

  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    home-manager = {
      enable = true;
      path = "$HOME/dotfiles/home-manager";
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
