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
          ips = [ "10.0.0.2/24" ];
          listenPort = 51821;
          privateKeyFile = "/usr/local/wireguard/mtl-access.server.key";
          peers = [
            {
              # Knowlton S2S
              endpoint = "vlb.hopto.me:51821";
              allowedIPs = [ "192.168.73.0/24" "10.0.0.0/24" ];
              persistentKeepalive = 25;
              publicKey = "PIbyx7f4FQtpzqBwmT04bQuGJCVIp/1kTwTvt6JweDE=";
            }
            { # Glaucus Road Warrior
              allowedIPs = [ "10.0.0.254/32" ];
              persistentKeepalive = 25;
              publicKey = "4DUYe0fUEh222uCyO8VMCesTRbwUPwQr4KGnz4m8/FM=";
            }
            { # Bunkai Road Warrior
              allowedIPs = [ "10.0.0.253/32" ];
              persistentKeepalive = 25;
              publicKey = "22WG+k6hqPS3nPf0Tk4fJk6Pag9WUnoUMcihCYemaiw=";
            }
            { # Murasaki Road Warrior
              allowedIPs = [ "10.0.0.252/32" ];
              persistentKeepalive = 25;
              publicKey = "b+pr0zs+EcKon9GmEoKnPWM8/IzOTupe2ABXRD62/w4=";
            }
          ];
        };
      };
    };
  };
}
