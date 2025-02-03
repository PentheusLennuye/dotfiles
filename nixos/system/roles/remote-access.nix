{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        pkgs.wayvnc
    ];
    networking.firewall.allowedTCPPorts = [ 5900 ];
}
