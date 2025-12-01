{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "nixoscache.cummings-online.local" = {
            locations."/".proxyPass =  "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
        };
      };
    };
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/cache-priv-key.pem";
    };
  };
}

