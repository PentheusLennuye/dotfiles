{ config, pkgs, ... }:

let
  ba = config.services.nix-serve.bindAddress;
  port = config.services.nix-serve.port;
in
{
  networking.firewall.allowedTCPPorts = [ 80 ];
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "binarycache.example.com" = {
            locations."/".proxyPass =  "http://${ba}:${toString port}";
        };
      };
    };
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/cache-priv-key.pem";
    };
  };
}
