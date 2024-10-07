{ config, pkgs, ... }:

{
    services.k3s = {
        enable = true;
        role = "server";
        extraFlags = toString [ "--disable=traefik" ];
    };

    networking.firewall.allowedTCPPorts = [ 6443 ];
}
