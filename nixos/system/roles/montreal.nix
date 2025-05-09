{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "172.16.73.2" "172.16.73.3" ];
  services.timesyncd = {
    servers = [ "time.cummings-online.local" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
