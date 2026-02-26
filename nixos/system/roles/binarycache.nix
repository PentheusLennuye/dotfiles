{ ... }:

{
  networking.firewall.allowedTCPPorts = [
    5000
  ];
  services = {
    nix-serve = {
      bindAddress = "0.0.0.0";
      enable = true;
      secretKeyFile = "/var/secrets/cache-priv-key.pem";
    };
  };
}
