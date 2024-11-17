{ config, pkgs, ... }:

{    
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowPing = true;
  networking.extraHosts = ''
    192.168.68.11 zantetsuken.cummings-online.local zantetsuken
    192.168.68.12 jigen.cummings-online.local jigen

    192.168.68.13 docker.cummings-online.local docker
    192.168.68.14 portainer.cummings-online.local portainer

    192.168.68.21 ingress.cummings-online.local netbox.cummings-online.local netbox awx.cummings-online.local awx repoapi.cummings-online.local registryapi.cummings-online.local easysync-test.cummings-online.local
    192.168.68.31 rpi1.cummings-online.local time.cummings-online.local rpi1 time
    192.168.68.32 rpi2.cummings-online.local rpi2
    192.168.68.33 rpi3.cummings-online.local rpi3
    192.168.68.34 rpi4.cummings-online.local rpi4

    192.168.68.61 mtl-printer.cummings-online.local mtl-printer brother

    192.168.68.73 goemon.cummings-online.local goemon
    192.168.68.74 goliath.cummings-online.local goliath

  '';
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
}
