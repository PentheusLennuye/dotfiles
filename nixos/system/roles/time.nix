{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gpsd
  ];
  networking.firewall.allowedUDPPorts = [ 123 ];
  services = {
    chrony = {
        enable = true;
        extraConfig = ''
            allow 10.0.0.0/8
            allow 172.16.73.0/24
            allow 192.168.68.0/24
            allow 192.168.73.0/24
            refclock SHM 0 refid GPS offset 0.0703 precision 1e-3 poll 3 trust
        '';
    };
    gpsd = {
        enable = true;
        devices = [ "/dev/ttyACM0" ];
        nowait = true;
    };
    udev = {
        extraRules = ''
            KERNEL=="pps[0-9]*", MODE:="0666", OWNER="root", GROUP="root"
            KERNEL=="ttyACM[0-9]*", MODE:="0666", OWNER="root", GROUP="dialout"
        '';
    };
  };
}
