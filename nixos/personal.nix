{ pkgs, config, ... }:

{

  # "Whether to enable Plymouth boot splash screen."
  boot.plymouth.enable = true;

  imports = [ ./common.nix ];

  # "The configuration of the Nix Packages collection. (For details, see the
  # Nixpkgs documentation.) It allows you to set package configuration options.
  # Ignored when nixpkgs.pkgs is set."
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs : rec { i3Support = true; };
  };

  hardware = {

    pulseaudio = {

      # "Whether to enable the PulseAudio sound server."
      enable = true;

      # "The PulseAudio derivation to use. This can be used to enable features
      # (such as JACK support, Bluetooth) via the pulseaudioFull package."
      package = pkgs.pulseaudioFull;

    };

    # "Whether to enable support for Bluetooth."
    blueototh.enable = true;
  };

  users = {

    # "This option defines the default shell assigned to user accounts. This
    # can be either a full system path or a shell package. This must not be a
    # store path, since the path is used outside the store (in particular in
    # `/etc/passwd`)."
    defaultUserShell = pkgs.zsh;

    # "Additional user accounts ot be created automatically by the system. This
    # can also be used to set options for root."
    users = {

      guthrie = {

        # "Indicates whether this is an account for a "real" user. This
        # automatically sets `group` to users, `createHome` to true, `home` to
        # `/home/username`, `useDefaultShell` to true, and `isSystemUser` to
        # false."
        isNormalUser = true;

        # "The user's home directory."
        home = "/home/guthrie";

        # "A short description of the user account, typically the user's full
        # name. This is actually the "GECOS" or "comment" field in
        # `/etc/passwd`."
        description = "Guthrie McAfee Armstrong";

        # "The user's auxiliary groups."
        extraGroups = [ "wheel" "networkmanager" "audio" "adbusers" "vboxusers" ];
      };
    };
  };

  # "The time zone used when displaying times and dates. See
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones for a
  # comprehensive list of possible values for this setting. If null, the
  # timezone will default to UTC and can be set imperatively using
  # timedatectl."
  time.timeZone = "US/Eastern";

  # "Install and setup the Java development kit."
  programs.java.enable = true;

  services = {

    # "Packages whose D-Bus configuration files should be included in the
    # configuration of the D-Bus system-wide or session-wide message bus.
    # Specifically, files in the following directories will be included into
    # their respective DBus configuration paths: pkg/etc/dbus-1/system.d
    # pkg/share/dbus-1/system-services pkg/etc/ dbus-1/session.d
    # pkg/share/dbus-1/services"
    dbus.packages = [ pkgs.blueman ];

    # "Whether to enable GNOME Keyring daemon, a service designed to take care
    # of the user's security credentials, such as user names and passwords."
    gnome3.gnome-keyring.enable = true;

    printing = {

      # "Whether to enable printing support through the CUPS daemon."
      enable = true;

      # "CUPS drivers to use. Drivers provided by CUPS, cups-filters,
      # Ghostscript and Samba are added unconditionally. If this list contains
      # Gutenprint (i.e. a derivation with meta.isGutenprint = true) the PPD
      # files in /var/lib/cups/ppd will be updated automatically to avoid
      # errors due to incompatible versions."
      drivers = [ pkgs.hplip pkgs.foo2zjs ];

      # "Specifies whether shared printers are advertised."
      browsing = true;

      # "Specifies whether local printers are shared by default."
      defaultShared = true;
    };

    physlock = {

      # "Whether to enable the physlock screen locking mechanism. Enable this
      # and then run systemctl start physlock to securely lock the screen. This
      # will switch to a new virtual terminal, turn off console switching and
      # disable SysRq mechanism (when services.physlock.disableSysRq is set)
      # until the root or user password is given."
      enable = true;

      # "Whether to allow any user to lock the screen. This will install a
      # setuid wrapper to allow any user to start physlock as root, which is a
      # minor security risk. Call the physlock binary to use this instead of
      # using the systemd service. Note that you might need to relog to have
      # the correct binary in your PATH upon changing this option."
      allowAnyUser = true;
    };

    xserver = {

      # "Whether to start the X server automatically."
      autorun = true;

      # "Whether to enable the X server."
      enable = true;

      # "Whether to symlink the X server configuration under /etc/X11/xorg.conf."
      exportConfiguration = true;

      displayManager.lightdm = {

        # "Whether to enable lightdm as the display manager."
        enable = true;

        # "The background image or color to use."
        background = "black";

        # "If set to false, run lightdm in greeterless mode. This only works if autologin is enabled and autoLogin.timeout is zero."
        greeter.enable = false;

        # "Configuration for automatic login."
        autoLogin = {

          # "Automatically log in as th especified `autoLogin.user`."
          enable = true;

          # "User to be used for the automatic login."
          user = "guthrie";

          # "Show the greeter for this many seconds before automatic login occurs."
          timeout = 0;
        };
      };
    };
  };

  environment = {

    # "The set of packages that appear in /run/current-system/sw. These
    # packages are automatically available to all users, and are automatically
    # updated every time you rebuild the system configuration. (The latter is
    # the main difference with installing them in the default profile,
    # /nix/var/nix/profiles/default."
    systemPackages = with pkgs; [
      alsaLib
      alsaTools
      alsaUtils
      home-manager
      networkmanager_openvpn
      networkmanagerapplet
      pavucontrol
    ];
  };

}
