{ config, pkgs, lib, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "jigen";

    # Virtual stuff
    bridges = {
      "br1" = {
        interfaces = [ "enp0s20f0u2" ];
        rstp = true;
      };
    };
    vlans = {
      vlan11 = {
        id = 11;
        interface = "br1";
      };
    };

    interfaces = {
      enp2s0.ipv4.addresses = [
        { address = "172.16.73.3"; prefixLength = 24; }
      ];
      vlan11.ipv4.addresses = [
        { address = "10.11.0.3"; prefixLength = 16; }
      ];
    };
    useDHCP = lib.mkDefault false;
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
}
