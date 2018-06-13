{ pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
    };
    script = "PATH=$PATH:${pkgs.i3}/bin polybar topbar & PATH=$PATH:${pkgs.i3}/bin polybar altbar &";

    config = {
      "bar/basebar" = {
        width = "100%";
        height = "5%";
        radius = 0;
        modules-left = "i3";
        modules-center = "datetime";
        module-margin = 1;
        modules-right = "vpn wireless-network wired-network battery0 battery1";
        padding = 4;
        font-0 = "Twitter Color Emoji:style=Regular:size=12";
        font-1 = "DejaVu Sans Mono:style=Regular:size=12";
        background = "\${colors.base00}";
        foreground = "\${colors.base05}";
      };

      "bar/topbar" = {
        "inherit" = "bar/basebar";
        tray-position = "right";
        monitor = "\${env:MONITOR:eDP1}";
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
        label-focused-padding = 6;
        label-unfocused = "%index%";
        label-unfocused-padding = 6;
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
        format-charging = "<label-charging> <ramp-capacity>";
        format-discharging = "<ramp-capacity>";
        format-full = "<ramp-capacity>";
        label-charging = "⚡";
        ramp-capacity-0 = "▰▱▱▱▱▱";
        ramp-capacity-1 = "▰▰▱▱▱▱";
        ramp-capacity-2 = "▰▰▰▱▱▱";
        ramp-capacity-3 = "▰▰▰▰▱▱";
        ramp-capacity-4 = "▰▰▰▰▰▱";
        ramp-capacity-5 = "▰▰▰▰▰▰";
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

      "module/networkbase" = {
        type = "internal/network";
        format-connected = "<label-connected>";
        format-connected-margin = 2;
        format-disconnected = "<label-disconnected>";
        format-disconnected-margin = 2;
      };

      "module/wired-network" = {
        "inherit" = "module/networkbase";
        interface = "enp0s25";
        label-connected = "Ethernet";
      };

      "module/wireless-network" = {
        "inherit" = "module/networkbase";
        interface = "wlp3s0";
        label-connected = "Wi-Fi";
      };

      "module/vpn" = {
        type = "custom/script";
        interval = 2;
        label = "%output%";
        exec = "/run/current-system/sw/bin/pgrep openvpn >/dev/null && printf '🔒' || printf '🔓'";
      };
    };

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
  };
}
