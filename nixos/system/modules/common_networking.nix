{ config, lib, pkgs, ... }:

{    
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowPing = true;
  networking.nameservers = [ "192.168.68.31" "192.168.68.32" "8.8.8.8" ];
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
  services.timesyncd = {
    servers = [ "time.cummings-online.local" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
