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
    domain = "cummings-online.local";
    hostName = "HOSTNAME";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault false;
  };
  services = {
    blueman.enable = true;
  };
}
