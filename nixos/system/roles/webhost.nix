{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
