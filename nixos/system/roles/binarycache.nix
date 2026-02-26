{ config, ... }:

{
  networking.firewall.allowedTCPPorts = [
    config.services.nginx.defaultHTTPListenPort
    5000
  ];
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "default-server" = {
          default = true;
          serverName = "nixoscache";
          locations."/" = {
            proxyPass = "http://127.0.0.1:5000";
          };
        };
      };
    };
    nix-serve = {
      bindAddress = "0.0.0.0";
      enable = true;
      secretKeyFile = "/var/secrets/cache-priv-key.pem";
    };
  };
}
