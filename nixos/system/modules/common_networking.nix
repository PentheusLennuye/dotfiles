{ config, lib, pkgs, ... }:

{    
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowPing = true;
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
}
