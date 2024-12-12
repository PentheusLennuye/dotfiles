# George's NixOS configurations

<!-- markdownlint-disable MD031 -->
<!-- markdownlint-disable MD032 -->

NixOS version 24.11

These are the files I use to configure my various bare metal NixOS systems to my
liking. See [NixOS Buildout](#nixos-buildout) on how to put them to use.

## Caveat Emptor

This is a live repository which is continually being updated as I find I need
some tools and remove others. __Modify the files to your needs!__. You might not
actually _need_ to use _zsh_...

## Credit

Much thanks to Tyler Kelley, "Best NixOS Config"
<https://gitlab.com/Zaney/zaneyos> for providing a guide. His YouTube video was
quite instructive; it is an excellent introduction to NixOS.

His waybar and starship configurations I stole without shame and modified (
statically; I'm not as interested in dynamic changes). Others took some
looking into.

An exceptionally good resource is Ryan Yin's "NixOS & Flakes Book" at
<https://nixos-and-flakes.thiscute.world>. NixOS's functional programming is
not easy, but with this text and programming experience using Python's
_pyproject.toml_ or Rust's Cargo helped.

## NixOS Buildout

### Step One: Install from CD/USB

When installing NixOS, ensure there is a swap partition made for hibernation,
especially when operating a laptop. After reboot, continue to ...

### Step Two: Connect to the Wifi

Unless your workstation is connected by wire:

```sh
nmcli dev wifi list
nmcli dev wifi connect --ask
```

### Step Three: Start a nix shell with vim and git

```sh
nix-shell -p vim git
```

### Step Four: Pull dotfiles and edit them

1. Pull these dotfiles
   ```sh
   git clone https://github.com/PentheusLennuye/dotfiles.git
   cd dotfiles/
   rm -rf .git  # to be safe
   cd nixos/system
   ```
2. Create the host directory for your new system
   ```sh
   cp -a hosts/template hosts/$(hostname -s)
   mv /etc/nixos/hardware-configuration.nix hosts/$(hostname -s)
   ```
3. Alter hardware-configuration
   ```sh
   sudo vi hosts/$(hostname -s)/hardware-configuration.nix
   ```
   1. Comment out dhcp in _/etc/nixos/hardware-configuration.nix_
   2. Alter boot parameters at need. See the other host directories for guidance
   3. Add the NFS filesystem as needed. See _hosts/glaucus_ for assistance.
4. Alter Network. If on a laptop, skip this step. If on a wired workstation or
   server, see _hosts/goemon/networking.nix_ for reference.

### Step Five: Laptops

See [LAPTOP](LAPTOP.md)

### Step Six: Let the configurations rip

#### System

1. Copy system files to _/etc/nixos_
   ```sh
   sudo rsync -avrt . /etc/nixos
   ```
2. Exit the nix-shell from step three (you are still in there, right?) with
   a simple `exit`.
3. Fire!
   ```sh
   sudo nixos-rebuild switch  # First command installs flakes
   sudo nixos-rebuild switch  # Second command goes to work. Get coffee.
   reboot
   ```

#### User

1. Copy the home-manager files from _dotfiles_
   ```sh
   [ -d ~/.config/home-manager ]] && rm -rf ~/.config/home-manager
   cp -a </path/to/dotfiles>/nixos/home-manager/<user> ~/.config/home-manager
   ```
2. Install home manager temporarily as USER (not root)
   ```sh
   RELEASE=$(nixos-version | awk -F. '{print $1"."$2}')
   nix-channel --add https://github.com/nix-community/${RELEASE} home-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   ```
3. Open fire
   ```sh
   home-manager build switch
   ```
4. Start neovim, and after reading all the errors, execute `:PlugInstall`

Enjoy your NixOS workstation.
