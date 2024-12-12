# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking = {
    defaultGateway = "192.168.68.1";
    domain = "cummings-online.local";
    hostName = "<HOSTNAME>";
    interfaces = {
      <IF_NAME>.ipv4.addresses = [
        { address = "192.168.68.<HOSTPORTION>"; prefixLength = 24; }
      ];
    };
    nameservers = ["<NAMESERVER1>", "<NAMESERVER2>"];
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
  services.rpcbind.enable = true;
}
