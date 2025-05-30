# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
    };
    kernelModules = ["kvm-intel"];
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=0" ];
    loader = {
        efi = {
            canTouchEfiVariables = true;
        };
        systemd-boot = {
            enable = true;
        };
    };
  };
}
