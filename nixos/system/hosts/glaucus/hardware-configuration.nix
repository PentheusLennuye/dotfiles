{ config, lib, pkgs, modulesPath, nixpkgs, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    extraModulePackages = [ ];
    initrd = {
        availableKernelModules = [ "dm-snapshot" "cryptd" "nfs" ];
        kernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
        luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUS";
        supportedFilesystems = [ "nfs" ];
        systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=0" ];
    resumeDevice = "/dev/disk/by-uuid/NIXOS_SWAP";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXOS_ROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };

  fileSystems."/srv/zantetsuken" = {
    device = "zantetsuken.cummings-online.local:/mnt/Primary";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "x-systemd.automount" "x-systemd.idle-timeout=99" "noauto" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-label/NIXOS_SWAP"; }
    ];

  networking.useDHCP = lib.mkDefault false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;
}
