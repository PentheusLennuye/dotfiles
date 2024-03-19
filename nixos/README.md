# George's NixOS configurations

NixOS version 23.11

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
   cd dotfiles
   rm -rf .git  # to be safe
   mv pictures ~/
   ```
2. Comment out dhcp in _/etc/nginx/hardware-configuration.nix_
   ```sh
   sudo vi /etc/nixos/hardware-configuration.nix  # Delete the DHCP portion
   ```
3. NetworkManager already has a basic set up from Step Two. Adjust if needed.
   For example, for a workstation or server:
   ```sh
   nmcli c show
   nmcli c modify <ID> ipv4.address 192.168.68.33/24 ipv4.dns 192.168.68.1 \
                       ipv4.gateway 192.168.68.1 method manual
   nmcli c reload <ID>
   ```
4. If dual-booting Windows, the NixOS documents point out that EFI and
   _systemd_ detects Windows automatically. However, my system's Windows EFI
   partition is too small, so I need to use GRUB. If this is also your case you
   need to replace the Windows disk UUID in _configuration.nix_ with your own:
   ```sh
   sudo fdisk -l  # Find the disk with the MS EFI
   sudo fdisk -l /dev/sd<x> | grep EFI # get the partition with windows EFI
   ls -l /dev/disk/by-uuid | grep sd<x> | cut -d' ' -f9
   ```

### Step Five: Laptops

See [LAPTOP](LAPTOP.md)

### Step Six: Let the configurations rip!

#### System

1. Copy all the files to _/etc/nixos/_ 
   ```
   sudo rsync -avrt <path/to/this/directory> /etc/nixos
   ```
2. Exit the nix-shell from step three (you are still in there, right?) with
   a simple `exit`.
3. Fire!
   ```sh
   sudo nixos-rebuild switch  # First command installs flakes
   sudo nixos-rebuild switch  # Second command goes to work. Get coffee.
   sudo reboot
   ```

Enjoy your NixOS workstation.

