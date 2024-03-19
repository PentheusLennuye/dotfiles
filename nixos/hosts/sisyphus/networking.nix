# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.68.70 debian-common.cummings-online.local debian-common
    192.168.68.71 netboxdemo.cummings-online.local netboxdemo
  '';

  networking.hostName = "sisyphus";
  networking.networkmanager.enable = true;
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
