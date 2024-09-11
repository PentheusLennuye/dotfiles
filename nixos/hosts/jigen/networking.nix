# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking = {
    defaultGateway = "192.168.68.1";
    domain = "cummings-online.local";
    hostName = "jigen";
    interfaces = {
      enp2s0.ipv4.addresses = [
        { address = "192.168.68.12"; prefixLength = 24; }
        { address = "192.168.68.13"; prefixLength = 24; }
        { address = "192.168.68.14"; prefixLength = 24; }
        { address = "192.168.68.15"; prefixLength = 24; }
        { address = "192.168.68.16"; prefixLength = 24; }
        { address = "192.168.68.17"; prefixLength = 24; }
        { address = "192.168.68.18"; prefixLength = 24; }
        { address = "192.168.68.129"; prefixLength = 24; }
      ];
    };
    nameservers = ["192.168.68.1"];

    # Wireguard ====================================================
    nat.enable = true;
    nat.externalInterface = "enp2s0";
    nat.internalInterfaces = [ "wg0" ];
    firewall = {
      allowedTCPPorts = [ 443 7373 ];
      allowedUDPPorts = [ 51820 ];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o enp2s0 -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o enps20 -j MASQUERADE
        '';
        privateKeyFile = "/home/gmc/services/wireguard/wireguard-keys/jigen.private";
        peers = [
          {
            publicKey = "SrAVp3affT5iRq0/lBZg+G4cm/qydDtXVGpzvR2qx3I=";  # Glaucus
            allowedIPs = [ "10.100.0.2/32" ];
          }
        ];
      };
    };
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };
  services.rpcbind.enable = true;
}
