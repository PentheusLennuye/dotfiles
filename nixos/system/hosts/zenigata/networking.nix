{ config, pkgs, lib, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "zenigata";
    interfaces = {
      enp2s0.ipv4.addresses = [
        { address = "172.16.73.4"; prefixLength = 24; }
      ];
      enp0s20f0u2.ipv4.addresses = [
        { address = "10.11.0.4"; prefixLength = 8; }
      ];
    };
    useDHCP = lib.mkDefault false;
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
}
