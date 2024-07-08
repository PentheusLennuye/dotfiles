{ config, osConfig, lib, pkgs, ... }:


let
  role = config.role;
in

with lib;
{
  imports = [../../roles.nix  ../../hosts/${osConfig.networking.hostName}/roles.nix];

  home = mkIf role.k8s {
    packages = with pkgs; [
      kubebuilder
      kubectl
      minikube
    ];
  };
}
