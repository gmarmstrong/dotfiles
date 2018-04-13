{ pkgs, config, ... }:

{
  programs.htop = {
    enable = true;
    fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];
    hideThreads = true;
    highlightBaseName = true;
  };
}
