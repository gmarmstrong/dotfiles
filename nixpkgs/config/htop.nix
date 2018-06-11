{ pkgs, config, ... }:

{
  programs.htop = {
    enable = true;
    fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];
    showProgramPath = false;
    hideThreads = true;
    hideUserlandThreads = true;
    highlightBaseName = true;
  };
}
