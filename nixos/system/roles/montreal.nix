{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "172.16.73.2" "172.16.73.3" ];
  services.timesyncd = {
    servers = [ "172.16.73.2" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
