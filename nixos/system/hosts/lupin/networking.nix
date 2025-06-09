{ config, pkgs, lib, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "lupin";
    useDHCP = lib.mkDefault false;

    # Virtual stuff
    bridges = {
      "br1" = {
        interfaces = [ "enp0s20f0u10" ];
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
      eno1.ipv4.addresses = [
        { address = "172.16.73.2"; prefixLength = 24; }
      ];
      vlan11 = {
        ipv4.addresses = [
          { address = "10.11.0.2"; prefixLength = 8; }
        ];
      };
    };
  };
  services.openssh = {
    enable = true;
    settings = {
        PasswordAuthentication = true;
    };
  };
}
