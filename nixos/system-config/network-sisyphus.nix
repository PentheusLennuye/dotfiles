# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.68.70 debian-common.cummings-online.local debian-common
    192.168.68.71 netboxdemo.cummings-online.local netboxdemo
  '';

  networking.hostName = "sisyphus"; # Define your hostname.
  networking.nameservers = [ "192.168.68.1" ];
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks.Pentheus.pskRaw = "PSKRAWHERE";
  networking.interfaces."wlp0s20f0u9".ipv4.addresses = [{
    address = "192.168.68.33";
    prefixLength = 24;
  }];
  networking.defaultGateway = {
    address = "192.168.68.1";
    interface = "wlp0s20f0u9";
  };
}
