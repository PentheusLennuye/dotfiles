{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
    # Mesa
    enable = true;
    # Vulkan
    driSupport = true;
    driSupport32Bit = true;
  };
}
