{ pkgs, config, ... }:

{

  xsession.windowManager.i3 = {
    enable = true;
    config = {

      startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }

        {
          command = "xrandr --output HDMI1 --auto --above eDP1";
          always = true;
          notification = false;
        }
      ];

      bars = [];

      focus.followMouse = false;
      gaps = {
        inner = 15;
        outer = 30;
        smartBorders = "on";
        smartGaps = false;
      };

      keybindings = {
        "Mod1+Ctrl+Shift+r" = "restart";
        "Mod1+Shift+r" = "reload";
        "Mod1+a" = "focus parent"; # focus parent container
        "Mod1+space" = "focus mode_toggle"; # toggle tiling/floating focus
        "Mod1+s" = "layout stacking"; # stacking layout
        "Mod1+w" = "layout tabbed"; # tabbed layout
        "Mod1+t" = "layout toggle split"; # toggle split layout or direction
        "Mod1+x" = "splitv"; # "vertical" split (above/below)
        "Mod1+z" = "splith"; # "horizontal" split (left/right)
        "Mod1+f" = "fullscreen";
        "Mod1+Shift+space" = "floating toggle"; # toggle tiling/floating
        "Mod1+Shift+Escape" = "exit"; # exit i3

        "Mod1+1" = "workspace 1";
        "Mod1+2" = "workspace 2";
        "Mod1+3" = "workspace 3";
        "Mod1+4" = "workspace 4";
        "Mod1+5" = "workspace 5";
        "Mod1+6" = "workspace 6";
        "Mod1+7" = "workspace 7";
        "Mod1+8" = "workspace 8";
        "Mod1+9" = "workspace 9";
        "Mod1+0" = "workspace 10";

        "Mod1+Shift+1" = "move container to workspace 1";
        "Mod1+Shift+2" = "move container to workspace 2";
        "Mod1+Shift+3" = "move container to workspace 3";
        "Mod1+Shift+4" = "move container to workspace 4";
        "Mod1+Shift+5" = "move container to workspace 5";
        "Mod1+Shift+6" = "move container to workspace 6";
        "Mod1+Shift+7" = "move container to workspace 7";
        "Mod1+Shift+8" = "move container to workspace 8";
        "Mod1+Shift+9" = "move container to workspace 9";
        "Mod1+Shift+0" = "move container to workspace 10";

        "Mod1+Ctrl+h" = "resize grow left 5 px or 5 ppt";
        "Mod1+Ctrl+j" = "resize grow down 5 px or 5 ppt";
        "Mod1+Ctrl+k" = "resize grow up 5 px or 5 ppt";
        "Mod1+Ctrl+l" = "resize grow right 5 px or 5 ppt";
        "Mod1+Ctrl+Shift+h" = "resize shrink right 5 px or 5 ppt";
        "Mod1+Ctrl+Shift+j" = "resize shrink up 5 px or 5 ppt";
        "Mod1+Ctrl+Shift+k" = "resize shrink down 5 px or 5 ppt";
        "Mod1+Ctrl+Shift+l" = "resize shrink left 5 px or 5 ppt";

        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";
        "Mod1+Shift+h" = "move left 20";
        "Mod1+Shift+j" = "move down 20";
        "Mod1+Shift+k" = "move up 20";
        "Mod1+Shift+l" = "move right 20";

        "Mod1+d" = "exec \"rofi -show run\"";
        "Mod1+c" = "exec \"rofi -show window\"";
        "Mod1+Shift+d" = "exec \"rofi -show ssh\"";
        "Mod1+Shift+c" = "exec \"rofi-pass --root ${config.xdg.dataHome}/password-store\"";
        "Mod1+Shift+q" = "kill";
        "Mod1+Return" = "exec i3-sensible-terminal";

        "XF86MonBrightnessUp" = "exec \"xbacklight -inc 10\"";
        "XF86MonBrightnessDown" = "exec \"xbacklight -dec 10\"";
        "XF86AudioMute" = "exec \"amixer sset Master toggle\"";
        "XF86AudioRaiseVolume" = "exec \"amixer sset Master unmute && amixer sset Master 5%+\"";
        "XF86AudioLowerVolume" = "exec \"amixer sset Master unmute && amixer sset Master 5%-\"";
        "Shift+XF86AudioRaiseVolume" = "exec \"amixer sset Master unmute && amixer sset Master 2%+\"";
        "Shift+XF86AudioLowerVolume" = "exec \"amixer sset Master unmute && amixer sset Master 2%-\"";
        "Mod4+l" = "exec \"physlock\"";

        "Print" = "exec \"scrot --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots/'\"";
        "Shift+Print" = "exec \"scrot --focused --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots'\"";
        "Ctrl+Print" = "exec \"sleep 0.2; scrot --select --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots'\"";

      };

      colors = {
        focused = {
          border = "$base05";
          background = "$base0D";
          text = "$base00";
          indicator = "$base0D";
          childBorder = "$base0D";
        };
        focusedInactive = {
          border = "$base01";
          background = "$base01";
          text = "$base05";
          indicator = "$base03";
          childBorder = "$base01";
        };
        unfocused = {
          border = "$base01";
          background = "$base00";
          text = "$base05";
          indicator = "$base01";
          childBorder = "$base01";
        };
        urgent = {
          border = "$base08";
          background = "$base08";
          text = "$base00";
          indicator = "$base08";
          childBorder = "$base08";
        };
        placeholder = {
          border = "$base00";
          background = "$base00";
          text = "$base05";
          indicator = "$base00";
          childBorder = "$base00";
        };
        background = "$base07";
      };
    };

    extraConfig = ''
      # See https://i3wm.org/docs/userguide.html#xresources
      set_from_resource $base00 i3wm.color0
      set_from_resource $base01 i3wm.color10
      set_from_resource $base02 i3wm.color11
      set_from_resource $base03 i3wm.color8
      set_from_resource $base04 i3wm.color12
      set_from_resource $base05 i3wm.color7
      set_from_resource $base06 i3wm.color13
      set_from_resource $base07 i3wm.color15
      set_from_resource $base08 i3wm.color1
      set_from_resource $base09 i3wm.color09
      set_from_resource $base0A i3wm.color3
      set_from_resource $base0B i3wm.color2
      set_from_resource $base0C i3wm.color6
      set_from_resource $base0D i3wm.color4
      set_from_resource $base0E i3wm.color5
      set_from_resource $base0F i3wm.color14
    '';
  };
}
