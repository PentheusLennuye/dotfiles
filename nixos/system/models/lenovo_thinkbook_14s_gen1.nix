{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./intel.nix ];
  config = {
    boot = {
      kernelParams = lib.mkIf (config.hardware.intelgpu.driver == "i915") [ "i915.enable_guc=3" ];
      kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.15") (
        lib.mkDefault pkgs.linuxPackages_latest
      );
    };
    hardware = {
      cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      intelgpu.vaapiDriver = "intel-media-driver";
      sensor.iio.enable = true;
    };
    services = {
      fprintd.enable = lib.mkDefault true;
      fstrim.enable = lib.mkDefault true;
      fwupd.enable = lib.mkDefault true;
      xserver.wacom.enable = lib.mkDefault config.services.xserver.enable;
    };
  };
}
