#!/usr/bin/env bash

# =====================================================
#
# dotfiles/nixos/build_system.sh
#
# automated build/rebuild NixOS script from dotfiles
#
# =====================================================

DOTFILES_URL=https://github.com/PentheusLennuye/dotfiles.git
DEFAULT_LAPTOP=n
DEFAULT_NEARLINE=n
DEFAULT_NL_PERCENT=25


cat << EOM
George's NixOS installation automation
--------------------------------------

This script installs NixOS on a workstation, VM, server or laptop.

It installs just the bare-bones NixOS.
It installs a bare-bones NixOS in an opinionated way.

First, some prompts...

EOM

# -----------------------------------------------------------

ANSWER=
ENCR_KEY=
HOSTNAME=
LAPTOP=
NEARLINE=
NL_PERCENT=
WIFI_PASS=
WLD=
SYSTEM_DISK=

set_laptop() {
  while [ "$LAPTOP" != "n" ] && [ "$LAPTOP" != "y" ]; do
    echo -n "Is this thing a laptop y/n [n]? "
    read LAPTOP
    echo
    [ "$LAPTOP" == "" ] && LAPTOP=$DEFAULT_LAPTOP
  done
}

set_nearline() {
  while [ "$NEARLINE" != "n" ] && [ "$NEARLINE" != "y" ]; do
    echo -n "Do you want a nearline (e.g. data backup or source) partition y/n [n]? "
    read NEARLINE
    echo
    [ "$NEARLINE" == "" ] && NEARLINE=$DEFAULT_NEARLINE
  done
  if [ "$NEARLINE" == "y" ]; then
    echo -n "Set the nearline storage size as a percent of the storage [${DEFAULT_NL_PERCENT}]: "
    read NL_PERCENT
    echo
    [ "$NL_PERCENT" == "" ] && NL_PERCENT=$DEFAULT_NL_PERCENT
  fi
}

set_system_disk() {
    echo "Setting the installation disk"
    echo "Available disks: "
    echo "──────────────── "
    ls -1 /dev | grep -P 'nvme\dn\d\b|sd[a-z]|vd[a-z]\b'
    echo
    while [ "$ANSWER" == "" ]; do
        echo -n "Identify the system disk: "
        read ANSWER
    done
    SYSTEM_DISK=/dev/${ANSWER}
}

check_plugged() {
    echo "Checking if plugged in to a physical ethernet network..."
    ip a | grep -P "inet.*(enp|eth\d)" && PLUGGED=y
}

partition_disk() {
    echo "Partitioning system ..."
    swap_size=$((2*$(free -m | grep Mem | awk '{print $2}')))
    root_offset=$((${swap_size} + 512))
    parted --script --align opt $SYSTEM_DISK \
        mklabel gpt \
        mkpart primary fat32 0% 1024MB \
        name 1 EFS \
        set 1 boot on \
        mkpart primary 1536MB 100% \
        set 2 lvm on
    if [ $? -ne 0 ]; then
        "...partitioning failed. FATAL. Stopping."
        exit 1
    fi
    echo "...partitioning done with the following configuration:"
    parted $SYSTEM_DISK print
}

set_encryption_password() {
    echo "Setting the encryption key."
    echo
    while [ "$ENCR_KEY" == "" ]; do
        echo -n "Encryption key: "
        read -s ENCR_KEY
        echo
        echo -n "Confirm encryption key: "
        read -s CONFIRM
        echo
        [ "$ENCR_KEY" == "$CONFIRM" ] || ENCR_KEY=
    done
}

encrypt_system_drive() {
    echo "Encrypting root partition..."
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimiter=p
    echo $ENCR_KEY | cryptsetup -q --label=system luksFormat ${SYSTEM_DISK}${delimiter}2 || exit 1
    echo "...encrypted"

    "Opening the encrypted drives..."
    echo $ENCR_KEY | \
        cryptsetup open /dev/disk/by-label/system crypt_system || exit 1
}

# Set up nix (store), root, and swap
partition_lv2() {
    nl=""
    [ "$NEARLINE" == "y" ] && nl="nearline, "
    echo "Partitioning nix, root, ${nl}and swap logical volumes"
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimiter=p

    nix_size=100
    echo -n "Set your nix store size in GB [${nix_size}]: "
    read nix_answer
    if [ "${nix_answer}" != "" ]; then
      nix_size=$nix_answer
    fi
    echo "Nix store size is ${nix_size}GiB (i.e., 1kB = 1024B)"

    swap_size=$(( $(free -g | grep Mem | awk '{print $2}') + 2 ))
    echo "Swap size is RAM + 2GiB = ${swap_size}GiB"

    [ "$NEARLINE" == "y" ] && echo "Nearline size is ${NL_PERCENT}% of the system disk"

    echo "Root size is the remainder of the system disk. This is opinionated."

    sleep 3

    if [ "$LAPTOP" == "y" ]; then
      pvcreate /dev/mapper/crypt_system || exit 1
      vgcreate VG_root /dev/mapper/crypt_system -s 4M || exit 1
    else
      pvcreate ${SYSTEM_DISK}${delimiter}2 || exit 1
      vgcreate VG_root ${SYSTEM_DISK}${delimiter}2 -s 4M  || exit 1
    fi

    lvcreate -L ${nix_size}G -n LV_nix_store VG_root || exit 1
    lvcreate -L ${swap_size}G -n LV_swap VG_root || exit 1
    [ "$NEARLINE" == "y" ] && lvcreate -l ${NL_PERCENT}%FREE -n LV_nearline VG_root || exit 1
    lvcreate -l 100%FREE -n LV_root VG_root || exit 1
}

# Format the installation drive, whether nvme or sda
format_system_drive() {
    echo "Formatting partitions..."
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimiter=p

    mkfs.vfat -n EFS ${SYSTEM_DISK}${delimiter}1 || exit 1
    mkfs.ext4 -L nix_store /dev/mapper/VG_root-LV_nix_store || exit 1
    mkswap -L swap  /dev/mapper/VG_root-LV_swap || exit 1
    [ "$NEARLINE" == "y" ] && mkfs.ext4 -L nearline /dev/mapper/VG_root-LV_nearline || exit 1
    mkfs.ext4 -L root /dev/mapper/VG_root-LV_root || exit 1
    echo "...formatted. Now waiting 2s for mapper to stabilize."
    sleep 2
}

mount_drives() {
    mount /dev/disk/by-label/root /mnt || exit 1
    mkdir /mnt/boot
    mkdir /mnt/root
    mkdir -p /mnt/nix/store
    mkdir -p /mnt/nearline
    mkdir -p /mnt/offline
    mkdir -p /mnt/iso  # For loopback DVD, CD, BD, and bootable USB
    mount -o umask=0077 /dev/disk/by-label/EFS /mnt/boot || exit 1
    mount -o noatime /dev/disk/by-label/nix_store /mnt/nix/store || exit 1

    # Notice I am not mounting nearline. That's what nearline is: readily available but not
    # accessible until required!
}

copy_dotfiles() {

[ -d /root/dotfiles ] && cp -r /root/dotfiles /mnt/root/dotfiles

}

install_nixos() {
    echo "Installing NixOS..."
    while [ "$HOSTNAME" == "" ]; do
        echo -n "Set short hostname: "
        read HOSTNAME
        echo -n "Confirm short hostname: "
        read CONFIRM
        [ "$HOSTNAME" == "$CONFIRM" ] || HOSTNAME=
    done
    nixos-generate-config --root /mnt
    mkdir -p /mnt/etc/nixos/orig
    cp /mnt/etc/nixos/*.nix /mnt/etc/nixos/orig/

    C_HOSTNAME=networking.hostName
    C_NM=networking.networkmanager
    sed -i.bak \
        -e 's/\(boot.loader.grub.enable.*\)/#\1/' \
        -e "s/^.*${C_HOSTNAME}.*/  ${C_HOSTNAME} = \"${HOSTNAME}\";/" \
        -e "s/^.*${C_NM}.*/  ${C_NM}.enable = true;/" \
        -e "s/^.*\(boot.loader.efi.efiSysMountPoint\).*/  \1 = \"\/boot\";/" \
        -e "/boot.loader.efi.efiSysMountPoint/a  boot.loader.efi.canTouchEfiVariables = true;" \
        -e "/boot.loader.grub.device/a  boot.loader.systemd-boot.enable = true;" \
        /mnt/etc/nixos/configuration.nix

    cd /mnt
    nixos-install || exit 1
    cd /
    echo "...installed."
}

close_up() {
    swapoff -a
    umount -R /mnt
    [ "$LAPTOP" == "y" ] && cryptsetup close crypt_system
}


# MAIN -------------------------------------------------------
set_laptop
set_nearline
set_system_disk
echo "─────────────────────────────────────────────────────────────────"
partition_disk
echo "─────────────────────────────────────────────────────────────────"
[ "$LAPTOP" == "y" ] && set_encryption_password
[ "$LAPTOP" == "y" ] && encrypt_system
partition_lv2
echo "─────────────────────────────────────────────────────────────────"
format_system_drive
echo "─────────────────────────────────────────────────────────────────"
mount_drives
copy_dotfiles
install_nixos
echo "─────────────────────────────────────────────────────────────────"
close_up

echo "Please type 'reboot' and remove the USB key."

