# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "nfs" ];
  boot.initrd.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.resumeDevice = "/dev/disk/by-uuid/4b5c3525-e1bf-4d2f-941d-6a29512d31c5";
  boot.kernelParams = [ "mem_sleep_default=deep" "resume_offset=0" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/80790e81-2a5d-481a-9ff1-d70c5998525c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DB72-AA30";
      fsType = "vfat";
    };

  fileSystems."/srv/zantetsuken" = {
    device = "zantetsuken.cummings-online.local:/mnt/Primary";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "x-systemd.automount" "x-systemd.idle-timeout=99" "noauto" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4b5c3525-e1bf-4d2f-941d-6a29512d31c5"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault false;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwp0s20u4.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
