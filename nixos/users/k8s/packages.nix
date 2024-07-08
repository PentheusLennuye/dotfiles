{ config, lib, pkgs, ... }:


let
  role = config.role;
in

with lib;
{
  imports = [ ../roles.nix ];

  home = mkIf role.workstation {
    packages = with pkgs; [
      kubebuilder
      kubectl
      minikube
    ];
  };
}
