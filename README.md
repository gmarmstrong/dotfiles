# dotfiles

This is my dotfiles repository. It uses [Nix](https://nixos.org/) with flakes
to manage my macOS system configuration. [There are many like
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

## Adding a New Host

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
