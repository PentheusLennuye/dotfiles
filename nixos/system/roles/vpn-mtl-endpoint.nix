{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      allowedUDPPorts = [ 51821 ];
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ "172.16.75.201/24" ];
          listenPort = 51821;
          privateKeyFile = "/usr/local/wireguard/mtl-access.server.key";
          peers = [
            {
              endpoint = "vlb.hopto.me:51821";
              allowedIPs = [ "192.168.73.0/24" ];
              persistentKeepalive = 25;
              publicKey = "PIbyx7f4FQtpzqBwmT04bQuGJCVIp/1kTwTvt6JweDE=";
            }
          ];
        };
      };
    };
  };
}
