{ pkgs, config, ... }:

{

  xsession.windowManager.i3 = {

    enable = true; # "Whether to enable i3 window manager."

    config = { # "i3 configuration options."
      window = { # "Window titlebar and border settings."
        hideEdgeBorders = "smart"; # "Hide window borders adjacent ot the screen edges."
        titlebar = false; # "Whether to show window titlebars."
        border = 2; # "Window border width."

        commands = [ # "List of commands that should be executed on specific windows.
          {
            command = "focus"; # "i3wm command to execute."
            criteria = { # "Criteria of the windows on which command should be executed."
              class = "^jetbrains-.+";
              window_type = "dialog";
            };
          }
        ];
      };

      floating = { # "Floating window settings."
        titlebar = false; # "Whether to show floating window titlebars."
        border = 2; # "Floating windows border width."

        # "List of criteria for windows that should be opened in a floating
        # mode."
        criteria = [ { title = "Network Connections"; } { class = "Pavucontrol"; } ];
      };

      # "Commands that should be executed at startup."
      startup = [
        {
          command = "xrdb -load \"${config.home.homeDirectory}/.Xresources\"";
          always = true;
          notification = false;
        }

        {
          command = "hsetroot -solid \"$base00\"";
          always = true;
          notification = false;
        }

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

      # "i3 bars settings blocks. Set to empty list to remove bars completely."
      bars = [];

      # "Whether focus should follow the mouse."
      focus.followMouse = false;

      # "An attribute set that assigns a key press to an action using a key
      # symbol."
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

        "Mod1+d" = "exec --no-startup-id \"rofi -show run\"";
        "Mod1+c" = "exec --no-startup-id \"rofi -show window\"";
        "Mod1+e" = "exec --no-startup-id \"rofi -modi 'emoji:${config.xdg.configHome}/rofi/rofiemoji.sh' -show emoji\"";
        "Mod1+Shift+d" = "exec --no-startup-id \"rofi -show ssh\"";
        "Mod1+Shift+c" = "exec --no-startup-id \"rofi-pass\"";
        "Mod1+Shift+q" = "kill";
        "Mod1+Return" = "exec --no-startup-id i3-sensible-terminal";

        "XF86MonBrightnessUp" = "exec --no-startup-id \"xbacklight -inc 10\"";
        "XF86MonBrightnessDown" = "exec --no-startup-id \"xbacklight -dec 10\"";
        "XF86AudioMute" = "exec --no-startup-id \"amixer sset Master toggle\"";
        "XF86AudioRaiseVolume" = "exec --no-startup-id \"amixer sset Master unmute && amixer sset Master 5%+\"";
        "XF86AudioLowerVolume" = "exec --no-startup-id \"amixer sset Master unmute && amixer sset Master 5%-\"";
        "Shift+XF86AudioRaiseVolume" = "exec --no-startup-id \"amixer sset Master unmute && amixer sset Master 2%+\"";
        "Shift+XF86AudioLowerVolume" = "exec --no-startup-id \"amixer sset Master unmute && amixer sset Master 2%-\"";
        "XF86Calculator" = "exec --no-startup-id \"urxvt -e calc\"";
        "Mod4+l" = "exec --no-startup-id \"physlock -m\"";
        "XF86HomePage" = "exec --no-startup-id \"firefox\"";
        "Mod1+XF86HomePage" = "exec --no-startup-id \"firefox -P other\"";
        "Mod4+e" = "exec --no-startup-id \"urxvt -e ranger\"";

        "Print" = "exec --no-startup-id \"scrot --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots/'\"";
        "Shift+Print" = "exec --no-startup-id \"scrot --focused --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots'\"";
        "Ctrl+Print" = "exec --no-startup-id \"sleep 0.2; scrot --select --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ${config.home.homeDirectory}/screenshots; mv $f ${config.home.homeDirectory}/screenshots'\"";

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

    # "Extra configuration lines to add to ~/.config/i3/config."
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
      exec --no-startup-id i3-msg workspace 1
    '';
  };
}
