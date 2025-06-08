{ config, pkgs, lib, ... }:

with lib;
{
  #hardware.printers = {
  #  ensurePrinters = [
  #    {
  #      name = "Brother_HL_2370DW";
  #      location = "Jean-Brillant";
  #      deviceUri = "ipp://brother/ipp/print";
  #     model = "everywhere";
  #      ppdOptions = {
  #        PageSize = "Letter";
  #      };
  #    }
  #    {
  #      name = "Canon_MF_229DW";
  #      location = "Knowlton";
  #      deviceUri = "ipp://canon/ipp/print";
  #      model = "everywhere";
  #      ppdOptions = {
  #        PageSize = "Letter";
  #      };
  #    }
  #  ];
  #  # ensureDefaultPrinter = "Brother_HL_2370DW";
  #};
  services.printing = {
    enable = true;
  };

  # Re-enable when Brother printers are no longer needed
  #services.avahi = {
  #  enable = true;
  #  nssmdns4 = true;
  #  openFirewall = true;
  #};
}
