# dotfiles

This is my dotfiles repository. It uses [Nix](https://nixos.org/) with flakes
to manage my system configurations. [There are many like
it](https://dotfiles.github.io/), but this one is mine. [**You won't want to
clone this whole
repository**](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#dotfiles-are-not-meant-to-be-forked),
but feel free to explore and borrow what you like!

## Installation on macOS

1. Install [Determinate Nix](https://determinate.systems/nix-installer/)
2. Clone these dotfiles to `~/dotfiles`
3. Run initial installation: `nix run nix-darwin -- switch --flake ~/dotfiles#`
4. Configure git hooks: `git config core.hooksPath .githooks`

Subsequent updates: use `system-update` (`--cleanup` optional)

## Installation on NixOS

Initial installation from the NixOS live environment:

These steps assume `hosts/<hostname>` exists and is exposed from `flake.nix`
as `nixosConfigurations.<hostname>`. For a new machine, add the host first
using the "Adding a New NixOS Host" section.

1. Partition and mount the target system under `/mnt`.

2. Generate hardware configuration:
   ```bash
   sudo nixos-generate-config --root /mnt
   ```

3. Clone these dotfiles somewhere under `/mnt`, for example:
   ```bash
   sudo mkdir -p /mnt/etc/nixos
   sudo git clone <repo-url> /mnt/etc/nixos/dotfiles
   ```

4. Replace the bootstrap hardware configuration with the generated one:
   ```bash
   sudo cp /mnt/etc/nixos/hardware-configuration.nix \
     /mnt/etc/nixos/dotfiles/hosts/<hostname>/hardware-configuration.nix
   ```

   The committed bootstrap file assumes root is labeled `nixos` and the EFI
   system partition is labeled `boot`. Replacing it with generated hardware
   config is preferred once disk layout is final.

5. Review `hosts/<hostname>/default.nix` and update:
   - `hostname`
   - `username`
   - `gitEmail`
   - `gitSigningKey`
   - any capability set changes

6. Install:
   ```bash
   sudo nixos-install --flake /mnt/etc/nixos/dotfiles#<hostname>
   ```

7. After first boot, clone these dotfiles to `~/dotfiles` and use
   `system-update` for subsequent updates:
   ```bash
   system-update
   ```

## Adding a New macOS Host

To configure a new macOS machine:

1. Copy the example host template:
   ```bash
   cp -r hosts/example-macos hosts/your-hostname
   ```

2. Edit `hosts/your-hostname/default.nix` and customize:
   - `hostname`: Your machine's hostname (find with `hostname`)
   - `username`: Your macOS username
   - `gitName` and `gitEmail`: Your Git identity
   - `gitSigningKey`: Your SSH signing key
   - `capabilities`: Select the package sets you want installed
   - `managedDevice`: Set to `true` if on a corporate/managed device
   - `manageNix`: Set to `false` if using Determinate Nix installer
   
   See `hosts/example-macos/default.nix` for an example with available options.

3. Add your host to `flake.nix` in three places:
   
   a. In the `let` block, import the host configuration:
   ```nix
   # Import host configurations
   yourHostConfig = import ./hosts/your-hostname;
   ```
   
   b. In the outputs, add to `darwinConfigurations`:
   ```nix
   darwinConfigurations.${yourHostConfig.hostname} = mkDarwinSystem yourHostConfig;
   ```
   
   c. In the `checks` section (within the `optionalAttrs` for darwin), add a validation check:
   ```nix
   your-hostname = self.darwinConfigurations.${yourHostConfig.hostname}.system;
   ```

4. Build and activate: `nix run nix-darwin -- switch --flake ~/dotfiles#`

## Adding a New NixOS Host

To configure a new NixOS machine:

1. Copy the example host template:
   ```bash
   cp -r hosts/example-nixos hosts/your-hostname
   ```

2. Edit `hosts/your-hostname/default.nix` and customize:
   - `hostname`: Your machine's hostname
   - `username`: Your Linux username
   - `system`: Usually `x86_64-linux`
   - `cpuVendor`: `intel`, `amd`, or `null`
   - `gitName`, `gitEmail`, and `gitSigningKey`
   - `capabilities`: Select package sets to install
   - `hardwareModules`: Include the generated hardware configuration

3. Add your host to `flake.nix`:
   - import the host config
   - expose it under `nixosConfigurations`
   - add a target-system check under `checks`

4. Build and activate:
   ```bash
   sudo nixos-rebuild switch --flake ~/dotfiles#your-hostname
   ```
