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

        device_uuid=1522b6f4-dd61-490c-884d-7e138f583404
        volume_label=456a5ccd-14eb-46be-82db-67ef54655476

        ${pkgs.udisks}/bin/udisksctl unlock \
            --block-device /dev/disk/by-uuid/"$device_uuid" \
            --key-file <("${pkgs.pass}/bin/pass" "drives/backup" | head -n 1 | tr -d '\n') \
            || exit 1
        ${pkgs.udisks}/bin/udisksctl mount --block-device /dev/mapper/luks-"$device_uuid" \
            || exit 1
        # TODO exclude files with dot prefixes
        ${pkgs.rsync}/bin/rsync -AXa --delete-excluded --no-inc-recursive --info=progress2 \
            --exclude="${config.xdg.cacheHome}/*" \
            --exclude="${config.xdg.dataHome}/Trash/*" \
            --exclude="${config.xdg.dataHome}/android/*" \
            --exclude="${config.home.homeDirectory}/.android/*" \
            --exclude="${config.home.homeDirectory}/virtualbox/*" \
            --exclude="${config.home.homeDirectory}/media/*" \
            --exclude="${config.home.homeDirectory}/testing" \
            "/home" "/run/media/${config.home.username}/$volume_label" \
            || exit 1
        ${pkgs.udisks}/bin/udisksctl unmount --block-device /dev/mapper/luks-"$device_uuid" || exit 1
        ${pkgs.udisks}/bin/udisksctl lock --block-device /dev/disk/by-uuid/"$device_uuid" || exit 1
        ${pkgs.udisks}/bin/udisksctl power-off --block-device /dev/disk/by-uuid/"$device_uuid" || exit 1
      '';
    };
  };
}
