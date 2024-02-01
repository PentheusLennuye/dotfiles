{ config, pkgs, ... }:

{
# Uncomment the following on nVidia systems
#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = false;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.production;
#     prime = {
#       nvidiaBusId = "PCI:01:00.0";
#     };
#   };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
