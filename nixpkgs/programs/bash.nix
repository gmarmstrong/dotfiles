{ pkgs, config, ... }:

{
  programs.bash = {

    # Whether to the Bash shell.
    enable = true;

    # How the history list is saved.
    historyControl = [ "ignorespace" ];

    # "Extra commands that should be run when initializing an interactive shell."
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

    # "Environment variables that will be set for the Bash session."
    sessionVariables = { PATH = "$HOME/.local/bin/scripts:$PATH"; };

    # "An attribute set that maps aliases (the top level attribute names in
    # this option) to command strings or directly to build outputs. The aliases
    # are added to all users' shells."
    shellAliases = {
      bup = "sudo rsync --verbose --delete-excluded -aAXv --exclude={\"/home/*/.cache/*\",\"/home/*/nextcloud\",\"/home/*/virtualbox\",\"/home/*/.local/share/Trash/*\",\"/home/*/.cache/mozilla/*/OfflineCache\",\"/home/*/.cache/mozilla/*/cache2\"} /home /run/media/$USER/ca3036f2-022d-4b6e-bb03-ed762403fd3b";
      l = "LC_COLLATE=C ls --group-directories-first -FHAlh -w 80";
      ll = "LC_COLLATE=C ls --group-directories-first -FHA -w 80";
      ls = "LC_COLLATE=C ls --group-directories-first -FH -w 80";
      vi = "nvim";
      vim = "nvim";
      space = "find -maxdepth 1 -exec du -sh '{}' \\; | sort -h";
      suspace = "sudo find -maxdepth 1 -exec du -sh '{}' --exclude='proc' \\; | sort -h";
    };

    # "Shell options to set."
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
  };
}
