{ config, pkgs, lib, ... }:

with lib;
{
  services.printing = mkIf (config.networking.hostName != "jigen")  {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.canon-cups-ufr2 ];
  };

  services.avahi = mkIf (config.networking.hostName != "jigen")  {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
