{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "192.168.68.31" "192.168.68.32" "8.8.8.8" ];
  services.timesyncd = {
    servers = [ "time.cummings-online.local" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
