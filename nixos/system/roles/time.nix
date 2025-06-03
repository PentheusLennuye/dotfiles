{ config, pkgs, ... }:

{
  config.services.chrony = {
    enable = true;
    extraConfig = ''
      allow 10.0.0.0/8
      allow 172.16.73.0/24
      allow 192.168.68.0/24
      allow 192.168.73.0/24
      refclock SHM 0 refid GPS offset 0.000 precision 1e-3 poll 3 trust
    '';
  };
  config.services.gpsd = {
    enable = true;
    devices = [ "/dev/ttyACM0" ];
  };
}
