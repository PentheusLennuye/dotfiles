{ config, ... }:

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
          locations."/".proxyPass = "http://127.0.0.1:5000/";
        };
      };
    };
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/secrets/cache-priv-key.pem";
    };
  };
}
