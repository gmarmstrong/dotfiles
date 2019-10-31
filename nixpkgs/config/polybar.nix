{ pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
      pulseSupport = true;
    };
    script = ''
      PATH=$PATH:${pkgs.i3}/bin
      polybar primary &
      polybar secondary &
    '';

    config = {
      "settings" = {
        screenchange-reload = true;
      };

      "bar/base" = {
        width = "100%";
        height = "5%";
        radius = 0;
        module-margin = 1;
        padding = 4;
        font-0 = "DejaVuSansMono Nerd Font Complete Mono:size=12";
        font-1 = "NotoEmoji Nerd Font Mono:size=12";
        background = "\${colors.base00}";
        foreground = "\${colors.base05}";
        screenchange-reload = "true";
      };

      "bar/primary" = {
        "inherit" = "bar/base";
        modules-left = "i3";
        modules-center = "datetime";
        modules-right = "backlight battery0 battery1";
        tray-position = "right";
        monitor = "\${env:MONITOR:eDP1}";
      };

      "bar/secondary" = {
        "inherit" = "bar/base";
        modules-left = "i3";
        modules-center = "datetime";
        monitor = "\${env:MONITOR:HDMI1}";
        monitor-fallback = "\${env:MONITOR:DP1}";
      };

      "module/i3" = {
        type = "internal/i3";
        strip-wsnumbers = true;
        pin-workspaces = true;
        index-sort = false;
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
        label-unfocused-padding = 4;

        label-visible = "(%index%)";
        label-visible-padding = 4;

        label-urgent = "%index%";
        label-urgent-padding = 4;
        label-urgent-foreground = "\${colors.base00}";
        label-urgent-background = "\${colors.base08}";
      };

      "module/datetime" = {
        type = "internal/date";
        interval = 1;
        date = "%a %Y-%m-%d";
        time = "%l:%M %p";
        label = "%date%  %time%";
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";
        enable-scroll = false;
        format = "<ramp> ";
        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-3 = "";
        ramp-4 = "";
      };

      "module/batterybase" = {
        type = "internal/battery";
        poll-interval = 5;
        full-at = 95;
        format-charging = "<ramp-capacity><label-charging>";
        format-discharging = "<ramp-capacity><label-discharging>";
        format-full = "<ramp-capacity>";
        label-discharging = " %percentage%%";
        label-charging = " %percentage%%";
        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-5 = "";
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

      "module/bluetooth" = {
        type = "custom/script";
        exec = "/run/current-system/sw/bin/systemctl is-active bluetooth.target >/dev/null && echo '' || printf ''";
        interval = "2";
      };

      "module/networkbase" = {
        type = "internal/network";
        format-connected = "<label-connected>";
      };

      "module/ethernet" = {
        "inherit" = "module/networkbase";
        interface = "enp0s25";
        label-connected = "";
      };

      "module/wifi" = {
        "inherit" = "module/networkbase";
        interface = "wlp3s0";
        label-connected = "直";
      };

      "module/vpn" = {
        type = "custom/script";
        interval = 2;
        label = "%output%";
        exec = "/run/current-system/sw/bin/pgrep openvpn >/dev/null && echo '' || echo ''";
      };

      "module/audio" = {
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        label-muted = "ﱝ";
        ramp-volume-0 = "奄";
        ramp-volume-1 = "奔";
        ramp-volume-2 = "墳";
      };
    };

    extraConfig = ''
      [colors]
      base00 = ''${xrdb:color0}
      base01 = ''${xrdb:color10}
      base02 = ''${xrdb:color11}
      base03 = ''${xrdb:color8}
      base04 = ''${xrdb:color12}
      base05 = ''${xrdb:color7}
      base06 = ''${xrdb:color13}
      base07 = ''${xrdb:color15}
      base08 = ''${xrdb:color1}
      base09 = ''${xrdb:color9}
      base0A = ''${xrdb:color3}
      base0B = ''${xrdb:color2}
      base0C = ''${xrdb:color6}
      base0D = ''${xrdb:color4}
      base0E = ''${xrdb:color5}
      base0F = ''${xrdb:color14}
    '';
  };
}
