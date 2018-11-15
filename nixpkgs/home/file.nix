{ pkgs, config, ... }:

{
  home.file = {
    scripts = {
      recursive = true;
      source = "${config.home.homeDirectory}/dotfiles/scripts";
      target = "${config.home.homeDirectory}/.local/bin/scripts";
    };

    bak = {
      executable = true;
      target = "${config.home.homeDirectory}/.local/bin/bak";
      text = ''
        #!/usr/bin/env bash

        DEVICE_UUID=1522b6f4-dd61-490c-884d-7e138f583404
        VOLUME_LABEL=456a5ccd-14eb-46be-82db-67ef54655476

        udisksctl unlock \
            --block-device /dev/disk/by-uuid/"$DEVICE_UUID" \
            --key-file <(pass drives/backup | head -n 1 | tr -d '\n')
        udisksctl mount --block-device /dev/mapper/luks-"$DEVICE_UUID"
        ${pkgs.rsync}/bin/rsync -AXa --delete-excluded --no-inc-recursive --info=progress2 \
            --exclude="${config.xdg.cacheHome}/*" \
            --exclude="${config.xdg.dataHome}/Trash/*" \
            "/home" "/run/media/${config.home.username}/$VOLUME_LABEL"
        udisksctl unmount --block-device /dev/mapper/luks-"$DEVICE_UUID"
        udisksctl lock --block-device /dev/disk/by-uuid/"$DEVICE_UUID"
        udisksctl power-off --block-device /dev/disk/by-uuid/"$DEVICE_UUID"
      '';
    };
  };
}
