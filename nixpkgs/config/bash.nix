{ pkgs, config, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];

    initExtra = ''
      # Shell prompt
      function git_slug {
          if $(test -d .git); then
              if $([ -z "$(git status --porcelain)" ]); then
                  echo "$(git rev-parse --abbrev-ref HEAD)  "
              else
                  echo "$(git rev-parse --abbrev-ref HEAD)* "
              fi
          fi
      }
      export PS1='\[\033[1;33m\]\w\[\033[0m\] $(git_slug)$ '
    '';

    shellAliases = {
      l = "LC_COLLATE=C ls --group-directories-first -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --group-directories-first -FHA -w 80";
      ls = "LC_COLLATE=C ls --group-directories-first -FH -w 80";
      vi = "${config.home.sessionVariables.EDITOR}";
      vim = "${config.home.sessionVariables.EDITOR}";
      space = "find -maxdepth 1 -exec du -sh '{}' \\; | sort -h";
      suspace = "sudo find -maxdepth 1 -exec du -sh '{}' --exclude='proc' \\; | sort -h";
    };

    shellOptions = [
      "cmdhist"
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
  };
}
