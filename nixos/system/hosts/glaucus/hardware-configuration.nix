{ config, lib, pkgs, modulesPath, nixpkgs, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems = {
    "/" = {
      device = "/dev/mapper/cryptroot";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
    "/srv/zantetsuken" = {
      device = "zantetsuken.cummings-online.local:/mnt/Primary";
      fsType = "nfs";
      options = [ "nfsvers=4.2" "x-systemd.automount" "x-systemd.idle-timeout=99" "noauto" ];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
  };

  swapDevices =
    [ { device = "/dev/mapper/cryptswap"; }
    ];

  networking.useDHCP = lib.mkDefault false;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
