{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "nixoscache.cummings-online.local" = {
            locations."/".proxyPass =  "http://127.0.0.1:${toString config.services.nix-serve.port}";
        };
      };
    };
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/cache-priv-key.pem";
    };
  };
}

