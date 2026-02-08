{ config, ... }:

{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # KDE black screen problem
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    prime = {
      nvidiaBusId = "PCI:01:00.0";
    };
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
