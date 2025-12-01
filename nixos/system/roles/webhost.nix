{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     nginx
  ];
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
