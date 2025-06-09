{ config, pkgs, ... }:

{
    services.k3s = {
        enable = true;
        role = "server";
        token = "qnCsvCk93DcsNDWzpAw9Nfs7RGFNpXm9";
        extraFlags = toString [ "--disable=traefik" ];
    };

    # High Availability etcd requires 2379 2380
    networking.firewall.allowedTCPPorts = [ 6443 2379 2380 ];

    # K3S Flannel multi-node networking requires 8472
    networking.firewall.allowedUDPPorts = [ 8472 ];
}
