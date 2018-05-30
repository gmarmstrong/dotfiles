{ pkgs, config, ... }:

{
  # "Attribute set of files to link into the user home."
  home.file = {
    scripts = {
      recursive = true;
      source = "${config.home.homeDirectory}/dotfiles/scripts";
      target = "${config.home.homeDirectory}/.local/bin/scripts";
    };
  };
}
