{ pkgs, config, ... }:

{
  # "Attribute set of files to link into the user home."
  home.file = {
    scripts = {
      recursive = true;
      source = "${config.home.homeDirectory}/dotfiles/scripts";
      target = "${config.home.homeDirectory}/.local/bin/scripts";
    };

    bak = {
      executable = true;
      target = "${config.home.homeDirectory}/.local/bin/bak";
      text = ''
        #!/usr/bin/env bash
        sudo rsync -PAXa --delete-excluded \
            --exclude="${config.xdg.cacheHome}/*" \
            --exclude="${config.xdg.dataHome}/Trash/*" \
            "/home" "/run/media/${config.home.username}/ca3036f2-022d-4b6e-bb03-ed762403fd3b"
      '';
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
