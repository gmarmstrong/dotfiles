{ pkgs, config, ... }:

{
  programs.fzf = {

    # "Whether to enable fzf - a command-line fuzzy finder."
    enable = true;

    # "Whether to enable Zsh integration."
    enableZshIntegration = true;
  };
}
