{ pkgs, config, ... }:

{
  home.sessionVariables.INPUTRC = "${config.xdg.configHome}/readline/inputrc";
  xdg.configFile.readline = {
    target = "readline/inputrc";
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
}
