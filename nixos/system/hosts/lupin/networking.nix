{ config, pkgs, lib, ... }:

{
  networking = {
    defaultGateway = "172.16.73.1";
    domain = "cummings-online.local";
    hostName = "lupin";
    useDHCP = lib.mkDefault false;

    interfaces = {
      eno1 = {
        ipv4 = {
          addresses = [{ address = "172.16.73.2"; prefixLength = 24; }];
        };
      };
      enp0s20f0u10 = {
        ipv4 = {
          addresses = [{ address = "10.11.0.2"; prefixLength = 16; }];
        };
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
