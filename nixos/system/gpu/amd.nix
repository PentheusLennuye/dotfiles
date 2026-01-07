{ pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    clinfo
    blender-hip
    lact
  ];

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
  };

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

  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
    tmpfiles.rules =
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
  };

}
