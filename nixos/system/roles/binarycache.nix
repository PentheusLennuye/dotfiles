{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    config.services.nginx.defaultHTTPListenPort
  ];
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
      openFirewall = true;
      port = 5000;
      secretKeyFile = "/var/secrets/cache-priv-key.pem";
    };
  };
}

