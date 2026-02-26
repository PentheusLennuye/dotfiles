{ ... }:

{
  networking.firewall.allowedTCPPorts = [
    5000
  ];
  nix.sshServe = {
    enable = true;
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFXtgtsAG7w5Jkry0wScULHUo/O8SMQtipylA7ap3lDN ncu2025@cummings-online.ca"
    ];
  };
  users = {
    users.ncu = {
      description = "NixOS Cache Updater";
      isNormalUser = false;
      useDefaultShell = true;
    };
  };
  services = {
    nix-serve = {
      bindAddress = "0.0.0.0";
      enable = true;
      secretKeyFile = "/var/secrets/cache-priv-key.pem";
    };
  };
}
