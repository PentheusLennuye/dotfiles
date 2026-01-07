{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    clinfo
    blender-hip
  ];

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;

  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+ /opt/rocm/hip - - - - ${rocmEnv}"
    ];
}
