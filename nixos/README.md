# George's NixOS configurations

NixOS version 23.11

These are the files I use to configure my various bare metal NixOS systems to my
liking. See [NixOS Buildout](#nixos-buildout) on how to put them to use.

## Caveat Emptor

This is a live repository which is continually being updated as I find I need
some tools and remove others. __Modify the files to your needs!__. You might not
actually _need_ to use _zsh_...

Some folk use _flakes_. I do not for now, being just a minimalist.

## Credit

Much thanks to Tyler Kelley, "Best NixOS Config"
<https://gitlab.com/Zaney/zaneyos> for providing a guide. His YouTube video was
quite instructive; it is an excellent introduction to NixOS.

His waybar and starship configurations I stole without shame and modified (
statically; I'm not as interested in dynamic changes). Others took some
looking into.

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
2. Edit out dhcp. If you are using _NetworkManager_ because you are on a laptop
   or a workstation that does not serve anything, dhcp just interferes. This
   goes double if you are setting a static address.
   ```sh
   sudo vi /etc/nixos/hardware-configuration.nix  # Delete the DHCP portion
   ```
3. If running a static address over wifi, you will need the password hash for
   the _network.nix_ portion: `wpa_passphrase <Network> <pw in clear>`
4. If dual-booting Windows, the NixOS documents point out that EFI and
   _systemd_ detects Windows automatically. However, my system's Windows EFI
   partition is too small, so I need to use GRUB. If this is also your case you
   need to replace the Windows disk UUID in _configuration.nix_ with your own:
   ```sh
   sudo fdisk -l  # Find the disk with the MS EFI
   sudo fdisk -l /dev/sd<x> | grep EFI # get the partition with windows EFI
   ls -l /dev/disk/by-uuid | grep sd<x> | cut -d' ' -f9
   ```
5. Make changes to the _system-config/_ files as required.

### Step Five: Laptops

See [LAPTOP](LAPTOP.md)

### Step Six: Let the configurations rip!

#### System

1. Copy all the files in _system-config_ to _/etc/nixos/_. Rename the
   appropriate _network-XX.nix_ file to _network.nix_.
2. Exit the nix-shell from step three (you are still in there, right?) with
   a simple `exit`.
3. Fire!
   ```sh
   sudo nixos-rebuild switch
   sudo reboot
   ```

#### User

1. Set up home-manager
   ```sh
   HMVER=$(grep stateVersion /etc/nixos/configuration.nix | cut -d\" -f2)
   RELEASE=home-manager/archive/release-${HMVER}.tar.gz
   nix-channel --add https://github.com/nix-community/$RELEASE home-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   ```
2. Configure the files in _home-config/_ to your tastes.
   Pay especial attention to the following:
   - _home-manager/packages.nix_ will need the unstable branch for
     __joplin-desktop__ on nVidia systems to enable the --ignore-gpu switch
   - _hypr/hyprland.conf_ will need __--disable-gpu__ added to _joplin-desktop_
     and _cider_ on nVidia systems.
   - _hypr/hyprland.conf_ will also need its audio sink identifiers changed from
     51 depending on the output of _wpctl status_.
3. Copy the files to _$HOME/.config_.
   ```sh
   rm -rf $HOME/.config/home-manager
   mv dotfiles/nixos/home-config/* $HOME/.config/
   rm -rf dotfiles
   ```
4. Fire!
   ```sh
   home-manager build switch
   exit
   ```

Enjoy your NixOS workstation. Note that I do not use a display manager such as
SDDM, LightDM, GDM, or whatnot. I just go to console and when I need a GUI,
I'll execute: `Hyprland`.


