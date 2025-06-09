{ config, pkgs, ... }:

{
    services.k3s = {
        enable = true;
        role = "server";
        token = "qnCsvCk93DcsNDWzpAw9Nfs7RGFNpXm9";
        extraFlags = toString [ "--disable=traefik" ];
    };

    networking.extraHosts = ''
      172.16.73.2 lupin.cummings-online.local lupin
      172.16.73.3 jigen.cummings-online.local jigen
      172.16.73.4 zenigata.cummings-online.local zenigata
    '';

    # High Availability etcd requires 2379 2380
    networking.firewall.allowedTCPPorts = [ 6443 2379 2380 ];

    # K3S Flannel multi-node networking requires 8472
    networking.firewall.allowedUDPPorts = [ 8472 ];
}
