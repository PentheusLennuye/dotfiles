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

It installs just the bare-bones NixOS but it also pulls the dotfiles
and sets the machine for a full installation with "nixos-rebuild switch" and
"home-manager build switch" on reboot.

It is meant for single-OS, single-disk stations.

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
    ls -1 /dev | grep -P 'nvme\dn\d\b|sd[a-z]\b'
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

set_wifi() {
    DEFAULT_WLD=wlp3s0
    echo -n "WiFi device [$DEFAULT_WLD]: "
    read WLD
    [ "$WLD" == "" ] && WLD=$DEFAULT_WLD
    
    SSID=
    DEFAULT_SSID=Pentheus
    echo -n "Network SSID [$DEFAULT_SSID]: "
    read SSID
    [ "$SSID" == "" ] && SSID=$DEFAULT_SSID
    
    while [ "${WIFI_PASS}" == "" ]; do
        echo -n "WiFi Password: "
        read -s WIFI_PASS
        echo
        echo -n "Confirm WiFi Password: "
        read -s CONFIRM
        echo
        [ "$WIFI_PASS" == "$CONFIRM" ] || WIFI_PASS=
    done
    
    echo "Starting WiFi..."
    wpa_passphrase $SSID $WIFI_PASS > /etc/wpa_supplicant.conf
    wpa_supplicant -V -c /etc/wpa_supplicant.conf -i$WLD || (
        echo "Could not start WiFi"
        exit 1
    )
    echo "...WiFi started."
}

partition_system() {
    echo "Partitioning system ..."
    swap_size=$((2*$(free -m | grep Mem | awk '{print $2}')))
    root_offset=$((${swap_size} + 512))
    parted --script --align opt $SYSTEM_DISK \
        mklabel gpt \
        mkpart primary fat32 0% 512MB \
        name 1 NIXOS_BOOT \
        set 1 boot on \
        mkpart primary linux-swap 512MB ${root_offset}MB \
        name 2 NIXOS_SWAP \
        mkpart primary ext4 ${root_offset}MB 100% \
        name 3 NIXOS_ROOT
    if [ $? ne 0 ]; then
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
    echo "Encrypting root and swap partitions..."
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimeter=p
    echo $ENCR_KEY | cryptsetup -q -s 512 -h sha512 --use-random \
        --label=NIXOS_SWAP luksFormat --type luks2 \
        ${SYSTEM_DISK}${delimiter}2 || exit 1
    echo $ENCR_KEY | cryptsetup -q -s 512 -h sha512 --use-random \
        --label=NIXOS_ROOT luksFormat --type luks2 \
        ${SYSTEM_DISK}${delimiter}3 || exit 1
    echo "...encrypted"

    "Opening the encrypted drives..."
    echo $ENCR_KEY | \
        cryptsetup open /dev/disk/by-label/NIXOS_SWAP cryptswap || exit 1
    echo $ENCR_KEY | \
        cryptsetup open /dev/disk/by-label/NIXOS_SWAP cryptroot || exit 1
    "...opened"
}

# Format the installation drive, whether nvme or sda
format_system_drive() {
    echo "Formatting partitions..."
    delimiter=
    echo ${SYSTEM_DISK} | grep nvme && delimeter=p

    if [ "$LAPTOP" == "n" ]; then

        echo ${SYSTEM_DISK} | grep nvme && delimeter=p
        mkfs.vfat -n NIXOS_BOOT ${SYSTEM_DISK}${delimiter}1 || exit 1
        mkswap -L NIXOS_SWAP ${SYSTEM_DISK}${delimiter}2 || exit 1
        mkfs.ext4 -L NIXOS_ROOT ${SYSTEM_DISK}${delimiter}3 || exit 1
    else
        mkfs.vfat -n NIXOS_BOOT ${SYSTEM_DISK}${delimiter}1 || exit 1
        mkswap /dev/mapper/cryptswap || exit 1
        mkfs.ext4 /dev/mapper/cryptroot || exit 1
    fi
    echo "...formatted"
}

mount_drives() {
    if [ "$LAPTOP" == "n" ]; then
        mount /dev/disk/by-label/NIXOS_ROOT /mnt || exit 1
        mkdir /mnt/boot
    else
        mount /dev/mapper/cryptroot /mnt || exit 1
        mkdir /mnt/boot
    fi
    mount -o umask=0077 /dev/disk/by-label/NIXOS_BOOT /mnt/boot || exit 1
}

clone_dotfiles() {
    echo "Cloning dotfiles..."
    cd /mnt
    git clone ${DOTFILES_URL}
    echo "...cloned"
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
    if [ "$LAPTOP" == "n" ]; then
        swapon /dev/disk/by-label/NIXOS_SWAP
    else
        swapon /dev/mapper/cryptswap
    fi
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
    [ "$LAPTOP" == "y" ] && cryptsetup close cryptroot
    [ "$LAPTOP" == "y" ] && cryptsetup close cryptswap
}


# MAIN -------------------------------------------------------
set_laptop
set_system_disk
check_plugged
([ $PLUGGED ] || set_wifi) && echo "Networking running."
partition_system_drive
[ "$LAPTOP" == "y"] && set_encryption_password
[ "$LAPTOP" == "y"] && encrypt_system
format_system_drive
mount_drives
clone_dotfiles
install_nixos
close_up

echo "Please type 'reboot', remove the USB key, and reset the BIOS to Safe Boot."

