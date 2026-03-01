# George's NixOS configurations

<!-- markdownlint-disable MD030 -->
<!-- markdownlint-disable MD031 -->
<!-- markdownlint-disable MD032 -->

NixOS version 25.11

These are the files I use to configure my various bare metal NixOS systems to my
liking. See [NixOS Buildout](#a-nixos-build-out) on how to put them to use.

## Caveat Emptor

This is a live repository which is continually being updated as I find I need
some tools and remove others. **Modify the files to your needs!**. You might not
actually _need_ to use _zsh_...

## Credit

Much thanks to Tyler Kelley, "Best NixOS Config"
<https://gitlab.com/Zaney/zaneyos> for providing a guide. His YouTube video was
quite instructive; it is an excellent introduction to NixOS.

His _waybar_ and _starship_ configurations I stole without shame and modified (
statically; I'm not as interested in dynamic changes). Others took some
looking into.

An exceptionally good resource is Ryan Yin's "NixOS & Flakes Book" at
<https://nixos-and-flakes.thiscute.world>. NixOS's functional programming is
not easy, but with this text and programming experience using Python's
_pyproject.toml_ or Rust's Cargo helped.

## A. NixOS Build Out

### A.1 Install NixOS

The easy way uses a build script to partition a single SSD/HDD or NVME disk as follows:

```txt
┌─ partition 1 (EFI), 1GB fat32: /boot
└─ partition 2 (system), remaining LVM 2
    ├ swap, memory * 2
    ├ nix, x GB: /nix, where x is 100GB default, but adjustable at installation
    └ root, remaining: /
```

If you are on a laptop, the system partition will be encrypted.

**Caveat**: If installing NixOS on a virtual machine, ensure that the firmware is set to _UEFI_.

1. Download the NixOS minimal installer and install it to a USB key or CD/DVD.
2. Boot the new system into the media.
3. Either plug the system into a physical network or connect to WiFi. For WiFi:
   ```sh
   nmcli dev wifi list | awk '{print $3}' | sort -u  # List networks
   read -r -p "Choose network: " SSID
   nmcli dev wifi connect $SSID password --ask
   ```
   The WiFi connection will be saved in `/etc/NetworkManager/system-connections/<SSID>.nmconnection`,
   but it will not be saved in the nixos configuration.
4. Download [build_systems.sh](https://github.com/PentheusLennuye/dotfiles/blob/main/nixos/build_system.sh)
   ```sh
   sudo -i
   git clone https://github.com/PentheusLennuye/dotfiles.git
   ```
5. Execute: `bash dotfiles/nixos/build_system.sh`
6. When prompted, enter and confirm the root password.
7. Reboot.

### A.2 Customize

#### A.2.1 Pull the dotfiles

1. Log into the system as root
2. Either plug the system into a physical network or connect to WiFi. For WiFi:
   ```sh
   nmcli dev wifi list | awk '{print $3}' | sort -u  # List networks
   read -r -p "Choose network: " SSID
   nmcli dev wifi connect $SSID password --ask
   ```
3. Install `git`. If you do not want to use `nano`, install `vim` or `neovim`.
   ```sh
   nix-shell -p vim git
   ```
4. Pull the dotfiles
   ```sh
   git clone https://github.com/PentheusLennuye/dotfiles.git
   cd dotfiles/
   git checkout develop
   cd nixos/system
   ```

#### A.2.2 Create the host definition

1. Create the host directory for your new system
   ```sh
   H=hosts/$(hostname -s)
   cp -a hosts/template $H
   mv /etc/nixos/hardware-configuration.nix $H/rescue/
   cp $H/rescue/hardware-configuration.nix $H
   ```
2. Remove the default directory and link to the local configuration
   ```sh
   rm -rf /etc/nixos
   ln -s . /etc/nixos
   ```

#### A.2.3 Alter host definitions for a laptop or server

1. Change configurations
   - `$H/bootloaders.nix` with `$H/bootloaders_LAPTOP.nix` if using a laptop
   - `$H/networking.nix` with `$H/networking_BLUETOOTH.nix` if using bluetooth
   - `$H/networking.nix` with `$H/networking_SERVER.nix` it using static addresses, no bluetooth
2. If you are installing NixOS on a laptop, add the lid opening and closing definition
   ```sh
   sed -i '/\];/i\ \ \ \ ./laptop.nix' $H/default.nix
   ```

#### A.2.3 Edit and register the host definition

1. Alter `bootloader.nix` and change any kernel modules that do not belong.
2. Set your hostname
   ```sh
   sed -i "s/HOSTNAME/$(hostname -s)/" $H/networking.nix
   ```
3. If setting up a server, edit `networking.nix` with your static address, default route and dns
   servers
4. Alter `hardware-configuration.nix`
   1. Remove any `boot.initrd` that you do not need in the bootloader file
   2. Append **options[ "noatime" ]** to `filesystems."/nix"`
5. Register the host definition in `flake.nix` with just the basics.
   ```txt
   nixosConfigurations = {
     ...
     <HOSTNAME> = nixpkgs.lib.nixosSystem {
       inherit system;
       specialArgs = { inherit inputs; };
       modules = common_modules ++ [ ./hosts/<HOSTNAME> ];
     };
     ...
   };
   ```

### A.3 Let 'er rip

#### A.3.1 System

1. Exit the nix-shell from step three (you are still in there, right?) with
   a simple `exit`.
2. Fire!
   ```sh
   nixos-rebuild switch
   reboot
   ```

Enjoy your NixOS workstation.

#### A.3.2 User Setup

Log in as your user, and

1. Pull the dotfiles again to get a clean copy
   ```sh
   mkdir -p ~/spaces/tech/infra/
   git clone https://github.com/PentheusLennuye/dotfiles.git ~/spaces/tech/infra/
   cd  ~/spaces/tech/infra/dotfiles
   git checkout develop
   ```
2. Link the nixos and home-manager configurations to the dotfiles
   ```sh
   ln -s ~/spaces/tech/infra/dotfiles/nixos/home-manager/$USER ~/.config/home-manager
   ```
3. Install home manager
   ```sh
   HMURL=https://github.com/nix-community/home-manager
   RELEASE=release-$(nixos-version | awk -F. '{print $1"."$2}').tar.gz
   nix-channel --add ${HMURL}/archive/${RELEASE} home-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   ```
4. Set up the user

   ```sh
   home-manager build switch
   ```

### A.4 Set NixOS to use your dotfiles

1. Copy the system `flake.nix`, `flake.lock`, and host definition
   ```sh
   cp /etc/nixos/flake.* .
   cp -r /etc/nixos/hosts/$(hostname -s) system/nixos/hosts
   ```
2. Link the nixos configurations to the dotfiles
   ```sh
   sudo rm /etc/nixos
   sudo ln -s ~/spaces/tech/infra/dotfiles/nixos/system /etc/nixos
   ```
3. Clean the old configuration
   ```sh
   sudo rm -rf /root/dotfiles
   exit
   ```

You may now add roles to your host in `flake.nix`.

---

That's it! Enjoy your system
