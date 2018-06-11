{ pkgs, config, ... }:

{
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
        sudo rsync -AXa --delete-excluded --no-inc-recursive --info=progress2 \
            --exclude="${config.xdg.cacheHome}/*" \
            --exclude="${config.xdg.dataHome}/Trash/*" \
            "/home" "/run/media/${config.home.username}/ca3036f2-022d-4b6e-bb03-ed762403fd3b"
      '';
    };
  };
}
