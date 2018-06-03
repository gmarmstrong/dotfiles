{ pkgs, config, ... }:

{
  # "Attribute set of files to link into the user home."
  home.file = {
    scripts = {
      recursive = true;
      source = "${config.home.homeDirectory}/dotfiles/scripts";
      target = "${config.home.homeDirectory}/.local/bin/scripts";
    };

    inputrc = {
      target = "${config.home.homeDirectory}/.inputrc";
      text = ''
        set editing-mode vi
        set show-all-if-ambiguous on
        set show-all-if-unmodified on
        set menu-complete-display-prefix on
        $if mode=vi
          set keymap vi-command
          Control-l: clear-screen
          "k": history-search-backward
          "j": history-search-forward
          set keymap vi-insert
          Control-l: clear-screen
          "jk": vi-movement-mode
          "\t": menu-complete
          "\e[Z": menu-complete-backward
        $endif
      '';
    };
  };
}
