# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking = {
    defaultGateway = "192.168.68.1";
    domain = "cummings-online.local";
    hostName = "jigen";
    interfaces = {
      enp2s0.ipv4.addresses = [
        { address = "192.168.68.12"; prefixLength = 24; }
        { address = "192.168.68.13"; prefixLength = 24; }
        { address = "192.168.68.14"; prefixLength = 24; }
        { address = "192.168.68.15"; prefixLength = 24; }
        { address = "192.168.68.16"; prefixLength = 24; }
      ];
    };
    nameservers = ["192.168.68.1"];
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
  services.rpcbind.enable = true;
}
