{ pkgs, config, ... }:

{
  home.file = {
    bin = {
      recursive = true;
      source = "${config.home.homeDirectory}/dotfiles/scripts";
      target = "${config.home.homeDirectory}/.local/bin/scripts";
    };
  };
}
