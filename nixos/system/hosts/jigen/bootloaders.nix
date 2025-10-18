# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot = {
    initrd = {
        availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
        kernelModules = [ "kvm-intel" "nfs" "nfs4"];
        supportedFilesystems = [ "nfs" "nfs4" ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = ["i915.enable_dc=0"];
    loader = {
        systemd-boot = {
            enable = true;
        };
        efi = {
            canTouchEfiVariables = true;
        };
    };
  };
}
