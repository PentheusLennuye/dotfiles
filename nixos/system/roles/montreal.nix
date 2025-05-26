{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "192.168.68.1" ];
  services.timesyncd = {
    servers = [ "172.16.73.2" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
