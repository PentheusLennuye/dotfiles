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
      enp0s20f0u2 = {
        ipv4 = {
          addresses = [{ address = "10.11.0.3"; prefixLength = 16; }];
        };
      };
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
