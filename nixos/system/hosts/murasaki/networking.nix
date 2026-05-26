# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  networking = {
    extraHosts = ''
      192.168.173.216 fafo.vm.cummings-online.local fafo
    '';
    hostName = "murasaki";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault false;
  };
  services = {
    blueman.enable = true;
    openssh = {
      enable = false;
    };
  };
  # ─── NFS Mounts ──────────────────────────────────────
  fileSystems."/mnt/lupin" = {
    device = "lupin:/private";
    fsType = "nfs";
    options = [
      "nfsvers=4"
      "sec=krb5i"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };
}
