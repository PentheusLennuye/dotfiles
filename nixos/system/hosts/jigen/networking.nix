{ config, pkgs, lib, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "jigen";
    useDHCP = lib.mkDefault false;

    interfaces = {
      enp2s0 = {
        ipv4 = {
          addresses = [{ address = "172.16.73.3"; prefixLength = 24; }];
        };
      };
    };

    # Virtual stuff ----------------------------------------------------
    bridges = {
      "br1" = {interfaces = [ "enp0s20f0u2" ]; rstp = true;};
    };
    vlans = {
      vlan11 = {id = 11; interface = "br1";};
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };
  };
}
