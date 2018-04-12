{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "gmarmstrong";
    userEmail = "guthrie.armstrong@gmail.com";
    signing.key = "100B37EAF2164C8B";
    extraConfig = {
      core = {
        excludesFile = "${config.home.homeDirectory}/dotfiles/git/ignore";
        attributesFile = "${config.home.homeDirectory}/dotfiles/git/attributes";
        editor = "${pkgs.neovim}/bin/nvim";
      };
      # FIXME diff.gpg.textconv = "gpg --no-tty --decrypt --quiet";
      commit.gpgsign = true;
      gpg.program = "${pkgs.gnupg}/bin/gpg";
      credential.helper = "cache";
    };
  };
}
