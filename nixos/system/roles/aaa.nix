{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    forwarders = [ "192.168.68.1" "8.8.8.8" ];
    listenOn = [ "any" ];
    listenOnIpv6 = [ "none" ];
    cacheNetworks = [
        "localhost"
        "10.11.0.0/16"
        "192.168.68.0/24"
        "192.168.73.0/24"
        "192.168.75.0/24"
        "172.16.73.0/24"
    ];
    extraOptions = ''
      allow-transfer { none; };
      dnssec-validation auto;
    '';
    zones = {
      "cummings-online.local" = {
        master = true;
        file = pkgs.writeText "db.cummings-online.local" ''
          $TTL 86400
          $ORIGIN cummings-online.local.
          @ IN SOA ns.cummings-online.local hostmaster.cummings-online.local. (
           2025060801 ; serial
           86400 ; refresh
           28800 ; retry
           604800 ; expire
           86400 ; negative cache ttl
          )
          
          ; Required nameserver records ----------------------------------------
          @           IN    NS    ns.cummings-online.local.
          ns          IN    A     172.16.73.2
          
          ; Hosts --------------------------------------------------------------
          gw-mtl      IN	A	192.168.68.1
          brother     IN	A	192.168.68.61
          goemon      IN	A	192.168.68.73
          goliath     IN	A	192.168.68.74
          rpi1	      IN 	A 	192.168.68.31
          rpi2 	      IN 	A 	192.168.68.32
          rpi3        IN 	A 	192.168.68.33
          rpi4        IN	A	192.168.68.34
          spectre     IN	A	192.168.68.254
          gw-knw      IN	A	192.168.73.1
          fujiko      IN	A	192.168.73.12
          knw-access  IN	A	192.168.73.43
          knw-ha      IN	A	192.168.73.41
          knw-jump    IN	A	192.168.73.42
          canon	      IN	A	192.168.73.61
          lupin       IN    A   172.16.73.2
          jigen       IN    A   172.16.73.3
          zenigata    IN    A   172.16.73.4
          ns3         IN	A	192.168.73.31
          
          time IN CNAME lupin.cummings-online.local.
       '';

      };
      "168.192.in-addr.arpa" = {
        master = true;
        file = pkgs.writeText "db.192.168.local" ''
           $TTL 86400
           @ IN SOA ns.cummings-online.local hostmaster.cummings-online.local. (
            2025052401 ; serial
            86400 ; refresh
            28800 ; retry
            604800 ; expire
            86400 ; negative cache ttl
           )
           
           ; Required nameserver records ----------------------------------------
           @           IN    NS    ns.cummings-online.local.
           ns          IN    A     172.16.73.2
           
           ; PTR --------------------------------------------------------------
           1.68    IN PTR gw-mtl.cummings-online.local.
           61.68   IN PTR brother.cummings-online.local.
           73.68   IN PTR goemon.cummings-online.local.
           74.68   IN PTR goliath.cummings-online.local.
           31.68   IN PTR rpi1.cummings-online.local.
           32.68   IN PTR rpi2.cummings-online.local.
           33.68   IN PTR rpi3.cummings-online.local.
           34.68   IN PTR rpi4.cummings-online.local.
           34.68   IN PTR rpi4.cummings-online.local.
           254.68  IN PTR spectre.cummings-online.local.
           1.73    IN PTR gw-knw.cummings-online.local.
           12.73   IN PTR fujiko.cummings-online.local.
           31.73   IN PTR ns3.cummings-online.local.
           41.73   IN PTR knw-ha.cummings-online.local.
           42.73   IN PTR knw-jump.cummings-online.local.
           43.73   IN PTR knw-access.cummings-online.local.
           61.73   IN PTR canon.cummings-online.local.
        '';
      };
      "16.73.172.in-addr.arpa" = {
        master = true;
        file = pkgs.writeText "db.172.16.73.local" ''
           $TTL 86400
           @ IN SOA ns.cummings-online.local hostmaster.cummings-online.local. (
            2025052401 ; serial
            86400 ; refresh
            28800 ; retry
            604800 ; expire
            86400 ; negative cache ttl
           )
           
           ; Required nameserver records ----------------------------------------
           @           IN    NS    ns.cummings-online.local.
           ns          IN    A     172.16.73.2
           
           ; PTR --------------------------------------------------------------
           2   IN PTR lupin.cummings-online.local.
           3   IN PTR jigen.cummings-online.local.
           4   IN PTR zenigata.cummings-online.local.
        '';
      };

    };
  };
  networking = {
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}
