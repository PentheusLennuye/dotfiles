{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "172.16.73.1" "172.16.73.2" ];
  services.timesyncd = {
    servers = [ "time.cummings-online.local" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
