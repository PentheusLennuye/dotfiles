# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "murasaki";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault false;
  };
  services.openssh = {
    enable = true;
    settings = {
        PasswordAuthentication = true;
    };
  };
}
