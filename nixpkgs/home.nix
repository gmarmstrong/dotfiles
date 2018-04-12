{ pkgs, config, ... }:

# TODO create skeleton directory tree
# TODO clone password-store
# TODO install clustergit (use nixpkgs)

# FIXME show battery charging status

{

  nixpkgs.config.allowUnfree = true;

  systemd.user.startServices = true;

  services = {
    blueman-applet.enable = true;
    unclutter = {
      enable = true;
      threshold = 5;
    };
    xscreensaver.enable = false;

    polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3Support = true;
        i3 = pkgs.i3-gaps;
      };
      config = {
        "bar/topbar" = {
          width = "100%";
          height = "3%";
          radius = 0;
          modules-left = "i3";
          modules-center = "datetime";
          modules-right = "battery0 battery1";
          tray-position = "right";
          module-margin = 1;
          padding = 1;
          font-0 = "DejaVu Sans Mono:size=10";
          background = "\${colors.base00}";
          foreground = "\${colors.base05}";
        };
        "module/i3" = {
          type = "internal/i3";
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
          internal = 5;
          date = "%a %Y-%m-%d";
          time = "%I:%M %p";
          label = "%date%  %time%";
        };
        "module/battery0" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "AC";
          poll-interval = 5;
        };
        "module/battery1" = {
          type = "internal/battery";
          battery = "BAT1";
          adapter = "AC";
          poll-interval = 5;
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
      script = ""; # FIXME `polybar topbar &` omits i3 workspaces, maybe try ${pkgs.polybar}?
    };

  };

  programs = {

    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dotfiles/home-manager";
    };

    firefox = {
      enable = true;
      #enableAdobeFlash = true;
      #enableGoogleTalk = true;
      #enableIcedTea = true;
    };

    htop = {
      enable = true;
      fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];
      hideThreads = true;
      highlightBaseName = true;
    };

    git = {
      enable = true;
      userName = "gmarmstrong";
      userEmail = "guthrie.armstrong@gmail.com";
      signing.key = "100B37EAF2164C8B";
      extraConfig = {
        core = {
          excludesFile = "${config.home.homeDirectory}/dotfiles/git/ignore";
          attributesFile = "${config.home.homeDirectory}/dotfiles/git/attributes";
          editor = "${pkgs.neovim}/bin/nvim";
        };
        # FIXME diff.gpg.textconv = "gpg --no-tty --decrypt --quiet";
        commit.gpgsign = true;
        gpg.program = "${pkgs.gnupg}/bin/gpg";
        credential.helper = "cache";
      };
    };

    rofi = {
      enable = true;
      scrollbar = false;
      terminal = "${pkgs.rxvt_unicode_with-plugins}/bin/urxvt";
    };

  };

  xresources = {
    properties = {
      "URxvt.termName" = "rxvt-unicode-256color";
      "URxvt.iso14755" = false;
      "URxvt.internalBorder" = 30;
      "URxvt.scrollBar" = false;
      "URxvt.scrollTtyOutput" = false;
      "URxvt.scrollWithBuffer" = true;
      "URxvt.scrollTtyKeypress" = true;
      "URxvt.secondaryScreen" = 1;
      "URxvt.secondaryScroll" = 0;
      "URxvt.perl-ext" = "";
      "URxvt.perl-ext-common" = "font-size";
      "URxvt.font" = "xft:DejaVu Sans Mono:size=11";
      "URxvt.keysym.C-plus" = "font-size:increase";
      "URxvt.keysym.C-minus" = "font-size:decrease";
      "URxvt.keysym.C-equal" = "font-size:reset";
      "URxvt.keysym.C-slash" = "font-size:show";
      "Xft.autohint" = 1;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
    };
    extraConfig = builtins.readFile ( pkgs.fetchFromGitHub {
      owner = "chriskempson";
      repo = "base16-xresources";
      rev = "79e6e1de591f7444793fd8ed38b67ce7fce25ab6";
      sha256 = "1nnj5py5n0m8rkq3ic01wzyzkgl3g9a8q5dc5pcgj3qr47hhddbw";
    } + "/xresources/base16-gruvbox-light-soft.Xresources");
  };

  xsession = {
    enable = true;
    profileExtra = ''
      xrdb -load "$HOME/.config/X11/Xresources" &
      nm-applet &
      pasystray &
      nextcloud &
      . "$HOME/.fehbg" &
      xsetroot -cursor_name left_ptr &
    '';

    windowManager.i3 = {
      enable = true;
      config = {

        bars = [];

        startup = [
          {
            command = "polybar topbar";
            always = true;
            notification = false;
          }
        ];
        focus.followMouse = false;
        gaps = {
          inner = 10;
          outer = 10;
          smartBorders = "on";
          smartGaps = true;
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
          "Mod1+Shift+c" = "exec \"rofi-pass\"";
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

          # TODO bindsym Print exec "scrot --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ~/screenshots; mv $f ~/screenshots/'"
          # TODO bindsym Shift+Print exec "scrot --focuesd --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mkdir ~/screenshots; mv $f ~/resources/images/screenshots'"
          # TODO bindsym Ctrl+Print exec "sleep 0.2; scrot --select --quality 100 %Y-%m-%d_%H-%M-%S.png -e 'mv $f ~/resources/images/screenshots'"

        };

        colors = {
          focused = {
            border = "#504945";
            background = "#076678";
            text = "#f2e5bc";
            indicator = "#076678";
            childBorder = "#076678";
          };
          focusedInactive = {
            border = "#ebdbb2";
            background = "#ebdbb2";
            text = "#504945";
            indicator = "#bdae93";
            childBorder = "#ebdbb2";
          };
          unfocused = {
            border = "#ebdbb2";
            background = "#f2e5bc";
            text = "#504945";
            indicator = "#ebdbb2";
            childBorder = "#ebdbb2";
          };
          urgent = {
            border = "#9d0006";
            background = "#9d0006";
            text = "#f2e5bc";
            indicator = "9d0006";
            childBorder = "#9d0006";
          };
          placeholder = {
            border = "#f2e5bc";
            background = "#f2e5bc";
            text = "#504945";
            indicator = "#f2e5bc";
            childBorder = "#f2e5bc";
          };
          background = "#282828";
        };
      };
    };
  };

  home = {

    file = {
      nvim-ftplugin = {
        recursive = true;
        target = ".config/nvim/ftplugin/";
        source = "${config.home.homeDirectory}/dotfiles/nvim/ftplugin/";
      };
      nvim-gnupg = {
        target = ".config/nvim/gnupg.vim";
        source = "${config.home.homeDirectory}/dotfiles/nvim/gnupg.vim";
      };
      nvim-init = {
        target = ".config/nvim/init.vim";
        source = "${config.home.homeDirectory}/dotfiles/nvim/init.vim";
      };
      nvim-init-secure = {
        target = ".config/nvim/vimrc_secure";
        source = "${config.home.homeDirectory}/dotfiles/nvim/vimrc_secure";
      };
      ranger-commands = {
        target = ".config/ranger/commands.py";
        source = "${config.home.homeDirectory}/dotfiles/ranger/commands.py";
      };
      ranger-rc = {
        target = ".config/ranger/rc.conf";
        source = "${config.home.homeDirectory}/dotfiles/ranger/rc.conf";
      };
      ranger-rifle = {
        target = ".config/ranger/rifle.conf";
        source = "${config.home.homeDirectory}/dotfiles/ranger/rifle.conf";
      };
      ranger-scope = {
        target = ".config/ranger/scope.sh";
        source = "${config.home.homeDirectory}/dotfiles/ranger/scope.sh";
      };
      user-dirs = {
        target = ".config/user-dirs.dirs";
        source = "${config.home.homeDirectory}/dotfiles/xdg/user-dirs.dirs";
      };
      zshrc = {
        target = ".config/zsh/.zshrc";
        source = "${config.home.homeDirectory}/dotfiles/zsh/zshrc";
      };
      zaliases = {
        target = ".config/zsh/.zaliases";
        source = "${config.home.homeDirectory}/dotfiles/zsh/zaliases";
      };
      zshenv = {
        target = ".zshenv";
        source = "${config.home.homeDirectory}/dotfiles/zsh/zshenv";
      };
    };

    packages = with pkgs; [
      androidsdk
      ardour
      audacity
      byzanz
      calc
      calibre
      dict
      diction
      feh
      figlet
      firefox
      gnome3.gnome_keyring
      gnumake
      gnupg
      go
      gx
      gx-go
      hugo
      imagemagick
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      json_c
      libreoffice
      maven
      neovim
      nextcloud-client
      openssh
      pandoc
      pass
      postgresql
      python
      python3
      ranger
      rofi
      rofi-pass
      rsync
      rxvt_unicode_with-plugins
      scrot
      signal-desktop
      slack
      spotify
      sshfs
      sxiv
      texlive.combined.scheme-full
      transmission_gtk
      trash-cli
      tree
      unclutter
      vlc
      virtualbox
      w3m
      xclip
      youtube-dl
      zathura
      zotero
      zsh
    ];
  };

}
