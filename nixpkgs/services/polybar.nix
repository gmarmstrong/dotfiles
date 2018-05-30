{ pkgs, config, ... }:

{
  services.polybar = {

    # "Whether to enable Polybar status bar."
    enable = true;

    # "Polybar package to install."
    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
    };

    # "Polybar configuration."
    config = {

      "bar/basebar" = {
        width = "100%";
        height = "3%";
        radius = 0;
        modules-left = "i3";
        modules-center = "datetime";
        module-margin = 1;
        padding = 1;
        font-0 = "DejaVu Sans Mono:size=10";
        background = "\${colors.base00}";
        foreground = "\${colors.base05}";
      };

      "bar/topbar" = {
        "inherit" = "bar/basebar";
        monitor = "\${env:MONITOR:eDP1}";
        modules-right = "battery0 battery1";
        tray-position = "right";
      };

      "bar/altbar" = {
        "inherit" = "bar/basebar";
        monitor = "\${env:MONITOR:HDMI1}";
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;
        enable-click = true;
        enable-scroll = false;
        wrapping-scroll = false;
        format = "<label-state> <label-mode>";
        label-focused = "%index%";
        label-focused-foreground = "\${colors.base05}";
        label-focused-background = "\${colors.base02}";
        label-focused-underline = "\${colors.base09}";
        label-focused-padding = 4;
        label-unfocused = "%index%";
        label-unfocused-padding = 4;
      };

      "module/datetime" = {
        type = "internal/date";
        interval = 1;
        date = "%a %Y-%m-%d";
        time = "%l:%M %p";
        label = "%date%  %time%";
      };

      "module/batterybase" = {
        type = "internal/battery";
        poll-interval = 5;
        full-at = 98;
        format-charging = "<label-charging>";
        format-discharging = "<label-discharging>";
        format-full = "<label-full>";
        label-charging = "%percentage%% CHR";
        label-discharging = "%percentage%% DIS";
        label-full = "FULL";
      };

      "module/battery0" = {
        "inherit" = "module/batterybase";
        battery = "BAT0";
        adapter = "AC";
      };

      "module/battery1" = {
        "inherit" = "module/batterybase";
        battery = "BAT1";
        adapter = "AC";
      };

    };

    # "Additional configuration to add."
    extraConfig = ''
      [colors]
      base00 = ''${xrdb:color0:#000000}
      base01 = ''${xrdb:color10:#000000}
      base02 = ''${xrdb:color11:#000000}
      base03 = ''${xrdb:color8:#000000}
      base04 = ''${xrdb:color12:#000000}
      base05 = ''${xrdb:color7:#000000}
      base06 = ''${xrdb:color13:#000000}
      base07 = ''${xrdb:color15:#000000}
      base08 = ''${xrdb:color1:#000000}
      base09 = ''${xrdb:color9:#000000}
      base0A = ''${xrdb:color3:#000000}
      base0B = ''${xrdb:color2:#000000}
      base0C = ''${xrdb:color6:#000000}
      base0D = ''${xrdb:color4:#000000}
      base0E = ''${xrdb:color5:#000000}
      base0F = ''${xrdb:color14:#000000}
    '';

    # "This script will be used to start the polybars. Set all necessary
    # environment variables here and start all bars. It can be assumed that
    # polybar executable is in the PATH. Note, this script must start all bars
    # in the background and then terminate.
    script = "PATH=$PATH:${pkgs.i3}/bin polybar topbar & PATH=$PATH:${pkgs.i3}/bin polybar altbar &";
  };
}
