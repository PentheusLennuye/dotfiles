{ config, pkgs, ... }:

{
    systemd.tmpfiles.rules = [
        "d /export 0755 nobody nogroup - "
        "d /srv 0755 nobody nogroup -"
        "d /srv/fleetwood 0755 nobody nogroup - "
        "d /srv/home 0755 nobody nogroup - "
    ];

    fileSystems."/export/fleetwood" = {
        device = "/srv/fleetwood";
        options = [ "bind" ];
    };

    fileSystems."/export/home" = {
        device = "/srv/home";
        options = [ "bind" ];
    };

    networking.firewall.allowedTCPPorts = [ 2049 ];

    services.nfs = {
        settings.nfsd = {
            udp = false;
            vers3 = false;
            vers4 = true;
            "vers4.0" = false;
            "vers4.1" = false;
            "vers4.2" = true;
        };
        server = {
            enable = true;
            exports = ''
                /export 172.16.73.0/24(rw,fsid=0,no_subtree_check) 192.168.68.0/24(rw,fsid=0,no_subtree_check) 192.168.73.0/24(rw,fsid=0,no_subtree_check) 10.0.0.0/24(rw,fsid=0,no_subtree_check) 10.11.0.0/16(rw,fsid=0,no_subtree_check)
                /export/fleetwood 172.16.73.0/24(rw,insecure,no_subtree_check)
            '';
        };
}
