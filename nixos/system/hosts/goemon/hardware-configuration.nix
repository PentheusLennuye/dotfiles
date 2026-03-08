# ┌─────────────────────────┐
# │ Hardware Configuraion   ├─────────────────────────────────────────────────────────────────┐
# └┬────────────────────────┘                                                                 │
#  │ Despite the filename, this file sets up disk partitions first and foremost.              │
#  │                                                                                          │
#  └──────────────────────────────────────────────────────────────────────────────────────────┘

{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ┌─────────────────────────┐
  # │ Hardware                ├─────────────────────────────────────────────────────────────────
  # └─────────────────────────┘

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opentabletdriver.enable = true;
  };

  # ┌─────────────────────────┐
  # │ Filesystems             ├─────────────────────────────────────────────────────────────────
  # └─────────────────────────┘

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFS";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # ┌─────────────────────────┐
  # │ Hibernate               ├─────────────────────────────────────────────────────────────────
  # └─────────────────────────┘

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
  boot.resumeDevice = "/dev/disk/by-label/swap";

  # ┌─────────────────────────┐
  # │ Nix Storage             ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ The Nix storage is in a seperate partition to permit specific efficiencies and to ensure │
  #  │ a full partition does not affect the integrity of the OS and user directories.           │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  fileSystems."/nix/store" = {
    device = "/dev/disk/by-label/nix_store";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  # ┌─────────────────────────┐
  # │ Nearline Storage        ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ Nearline means it is easily accessible, but not actively mounted. This section serves    │
  #  │ as documentation in case you forget what the nearline partition is called.               │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘
  #
  # sudo mount -t ext4 /dev/disk/by-label/nearline /mnt/nearline
  #

  # ┌─────────────────────────┐
  # │ Network  Storage        ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ NFS, CIFS, SSH-based mounts.                                                             │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  # fileSystems."/srv/<servername>" = {
  #   device = "<servername>.<domain>:/<path>";
  #   fsType = "nfs";
  #   options = [ "nfsvers=4.2" "x-systemd.automount" "noauto" ];
  # };

}
