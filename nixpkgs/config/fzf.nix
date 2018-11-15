{ pkgs, config, ... }:

{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}
