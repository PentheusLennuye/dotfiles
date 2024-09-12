{ config, osConfig, lib, pkgs, ... }:


let
  role = config.role;
in

with lib;
{

  home = mkIf role.k8s {
    packages = with pkgs; [
      kubernetes-helm
      kubectl
    ];
  };
}
