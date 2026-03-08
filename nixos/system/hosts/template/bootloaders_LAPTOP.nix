# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      kernelModules = [
        "kvm-intel"
        "nfs"
        "nfs4"
      ];
      kernelPackages = pkgs.linuxPackages_latest;
      luks = {
        devices = {
          "crypt_root" = {
            crypttabExtraOpts = [ "fido2-device=auto" ];
            device = "/dev/nvme0n1p2";
          };
        };
      };
      supportedFilesystems = [
        "nfs"
        "nfs4"
      ];
      systemd.enable = true;
    };
    kernelModules = [
      "kvm-intel"
      "nfs"
      "nfs4"
    ];
    kernelParams = [
      "mem_sleep_default=deep"
      "resume_offset=0"
      "intel_iommu=on"
    ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
      };
    };
  };
  hardware = {
    enableAllFirmware = true;
  };
}
