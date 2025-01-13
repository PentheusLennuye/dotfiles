# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot = {
    extraModulePackages = [ ];
    initrd = {
        availableKernelModules = [ "dm-snapshot" "cryptd" "nfs" ];
        kernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod"
                          "rtsx_pci_sdmmc" ];
        luks.devices = {
            "cryptroot" = {
                device = "/dev/disk/by-label/NIXOS_LUKS";
                preLVM = true;
            };
        };
        supportedFilesystems = [ "nfs" ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=0" ];
    loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };
        grub = {
            devices = [ "nodev" ];
            efiSupport = true;
            enable = false;
            enableCryptodisk = true;
        };
        systemd-boot = {
            enable = true;
        };
    };
    resumeDevice = "/dev/disk/by-uuid/NIXOS_SWAP";
  };
}
