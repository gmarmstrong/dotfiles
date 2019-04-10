{ pkgs, config, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];

    initExtra = ''
      # Shell prompt
      function git_slug {
          # test git repo
          if git status --porcelain &>/dev/null; then
              # abbreviated branch or tag name
              echo -n "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
              # asterisk if repo dirty
              if [ -z "$(git status --porcelain)" ]; then
                  echo "  "
              else
                  echo "* "
              fi
          fi
      }
      export PS1='\[\033[1;33m\]\w\[\033[0m\] $(git_slug)$ '
    '';

    shellAliases = {
      l = "LC_COLLATE=C ls --group-directories-first --color -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --group-directories-first --color -FHA -w 80";
      ls = "LC_COLLATE=C ls --group-directories-first --color -FH -w 80";
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
