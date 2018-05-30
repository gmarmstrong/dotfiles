{ pkgs, config, ... }:

{
  programs.htop = {

    # "Whether to enable htop."
    enable = true;

    # "Active fields shown in the table."
    fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];

    # "Show program path."
    showProgramPath = false;

    # "Hide threads."
    hideThreads = true;

    # "Hide userland process threads."
    hideUserlandThreads = true;

    # "Highlight program 'basename'."
    highlightBaseName = true;
  };
}
