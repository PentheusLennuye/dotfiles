{ config, pkgs, lib, ... }:

with lib;
{
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL_2370DW";
        location = "Jean-Brillant";
        deviceUri = "ipp://mtl-printer/ipp/print";
        model = "drv:///brlaser.drv/brl2375w.ppd";
        ppdOptions = {
          PageSize = "Letter";
        };
      }
    ];
    ensureDefaultPrinter = "Brother_HL_2370DW";
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.canon-cups-ufr2 ];
  };

  # Re-enable when Brother printers are no longer needed
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };

}
