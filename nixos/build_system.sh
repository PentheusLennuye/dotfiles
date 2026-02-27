#!/usr/bin/env bash

# =====================================================
#
# dotfiles/nixos/build_system.sh
#
# automated build/rebuild NixOS script from dotfiles
#
# =====================================================

DOTFILES_URL=https://github.com/PentheusLennuye/dotfiles.git


cat << EOM
George's NixOS installation automation
--------------------------------------

This script installs NixOS on a workstation, VM, server or laptop.

It installs just the bare-bones NixOS.
It installs a bare-bones NixOS in an opinionated way.

First, some prompts...

EOM

# -----------------------------------------------------------

ENCR_KEY=
HOSTNAME=
LAPTOP=
PLUGGED=n
WIFI_PASS=
WLD=
SYSTEM_DISK=

set_laptop() {
    DEFAULT_LAPTOP=n
    while [ "$LAPTOP" != "n" ] && [ "$LAPTOP" != "y" ]; do
        echo -n "Is this thing a laptop y/n [n]? "
        read LAPTOP
        echo
        [ "$LAPTOP" == "" ] && LAPTOP=$DEFAULT_LAPTOP
    done
}

set_system_disk() {
    echo "Setting the installation disk"
    echo "Available disks: "
    echo
    ls -1 /dev | grep -P 'nvme\dn\d\b|sd[a-z]|vd[a-z]\b'
    echo
    while [ "$SYSTEM_DISK" == "" ]; do
        echo -n "Define the system disk: "
        read SYSTEM_DISK
    done
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
        set 2 pv on
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
    echo ${SYSTEM_DISK} | grep nvme && delimeter=p
    echo $ENCR_KEY | cryptsetup -q --label=system luksFormat ${SYSTEM_DISK}${delimiter}2 || exit 1
    echo "...encrypted"

    "Opening the encrypted drives..."
    echo $ENCR_KEY | \
        cryptsetup open /dev/disk/by-label/system crypt_system || exit 1
}

# Set up nix (store), root, and swap
partition_lv2() {
    echo "Partitioning nix, root and swap drives"
    if [ "$LAPTOP" == "n" ]; then
      pvcreate /dev/mapper/crypt_system || exit 1
      vgcreate VG_root /dev/mapper/crypt_system -s 4M || exit 1
    else
      pvcreate ${SYSTEM_DISK}${delimiter}2 || exit 1
      vgcreate VG_root ${SYSTEM_DISK}${delimiter}2 -s 4M  || exit 1
    fi

    lvcreate -L 100G -n LV_nix VG_root || exit 1
    lvcreate -L 18G -n LV_swap VG_root || exit 1
    lvcreate -l 100%FREE -n LV_root VG_root || exit 1
}

# Format the installation drive, whether nvme or sda
format_system_drive() {
    echo "Formatting partitions..."
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimeter=p

    mkfs.vfat -n EFS ${SYSTEM_DISK}${delimiter}1 || exit 1
    mkfs.ext4 -L nix /dev/mapper/VG_root_LV_nix || exit 1
    mkswap -L swap  /dev/mapper/VG_root_LV_swap || exit 1
    mkfs.ext4 -L root /dev/mapper/VG_root_LV_root || exit 1
    echo "...formatted"
}

mount_drives() {
    mount /dev/disk/by-label/root /mnt || exit 1
    mkdir /mnt/boot
    mkdir /mnt/nix
    mount -o umask=0077 /dev/disk/by-label/EFS /mnt/boot || exit 1
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
    swapon /dev/disk/by-label/swap
    nixos-generate-config --root /mnt
    mkdir -p /mnt/etc/nixos/orig
    cp /mnt/etc/nixos/*.nix /mnt/etc/nixos/orig/

    C_HOSTNAME=networking.hostName
    C_NM=networking.networkmanager
    sed -i.bak \
        -e "s/^.*${C_HOSTNAME}.*/  ${C_HOSTNAME} = \"${HOSTNAME}\";/" \
        -e "s/^.*${C_NM}.*/  ${C_NM}.enable = true;/" \
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
set_system_disk
check_plugged
partition_disk
[ "$LAPTOP" == "y"] && set_encryption_password
[ "$LAPTOP" == "y"] && encrypt_system
partition_lv2
format_system_drive
mount_drives
clone_dotfiles
install_nixos
close_up

echo "Please type 'reboot' and remove the USB key."

