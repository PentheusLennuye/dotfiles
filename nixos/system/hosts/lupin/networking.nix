# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "zenigata";
    interfaces = {
      enp2s0.ipv4.addresses = [
        { address = "172.16.73.4"; prefixLength = 24; }
      ];
      enp0s20f0u1.ipv2.addresses = [
        { address = "10.11.0.4"; prefixLength = 8; }
      ];
    };
    useDHCP = lib.mkDefault false;
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
  services.rpcbind.enable = true;
}
