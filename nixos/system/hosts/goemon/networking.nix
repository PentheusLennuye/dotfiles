# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  networking = {
    #defaultGateway = "192.168.68.1";
    defaultGateway = "192.168.73.1";
    domain = "cummings-online.local";
    hostName = "goemon";
    interfaces = {
    #  enp6s0.ipv4 = {
    #    addresses = [
    #      { address = "192.168.68.73"; prefixLength = 24; }
    #    ];
    #    routes = [
    #      { address = "10.0.0.0"; prefixLength = 8; via = "192.168.68.254"; }
    #      { address = "172.16.73.0"; prefixLength = 24; via = "192.168.68.254"; }
    #    ];
    #  };
        enp6s0.ipv4 = {
            addresses = [
                { address = "192.168.73.73"; prefixLength = 24; }
            ];
            routes = [
                { address = "10.0.0.0"; prefixLength = 8; via = "192.168.73.43"; }
                { address = "172.16.73.0"; prefixLength = 24; via = "192.168.73.43"; }
            ];
        };
     };
    useDHCP = lib.mkDefault false;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };
    rpcbind = {
      enable = true;
    };
  };
}
