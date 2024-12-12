{ config, pkgs, lib, ... }:

with lib;
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.canon-cups-ufr2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
