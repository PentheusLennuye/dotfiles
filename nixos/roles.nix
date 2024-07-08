{ config, lib, ... }:

with lib;
{
  options = {
    role.k8s = mkOption {
      default = false;
      type = types.bool;
      description = "Kubernetes host, default false";
    };
    role.nvidia = mkOption {
      default = false;
      type = types.bool;
      description = "nVidia cards are in the host, default false";
    };
    role.virtualhost = mkOption {
      default = false;
      type = types.bool;
      description = "The station is a VM host, default false.";
    };
    role.workstation = mkOption {
      default = false;
      type = types.bool;
      description = "Use X or Wayland, default false.";
    };
  };
}
