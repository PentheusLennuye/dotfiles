{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "10.11.0.31" ];
  services.timesyncd = {
    servers = [ "10.11.0.2" ];
    extraConfig = ''
      FallbackNTP=${lib.concatStringsSep " " config.networking.timeServers}
    '';
  };
}
