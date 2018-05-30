{ pkgs, config, ... }:

{
  programs.ssh = {

    # "Whether to enable SSH client configuration."
    enable = true;

    # "Specify per-host settings."
    matchBlocks = {

      "nike" = {

        # "Specifies the real host name to log into."
        hostname = "nike.cs.uga.edu";

        # "Specifies the user to log into as."
        user = "gma";

        # "Specifies whether X11 connections will be automatically redirected
        # over the secure channel and DISPLAY set.
        forwardX11 = true; };

    };
  };
}
