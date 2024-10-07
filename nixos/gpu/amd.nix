{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl = {
    enable = true;
    # OpenCL and Vulkan ----------------------
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd
    ];
    # Vulkan support -------------------------
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
