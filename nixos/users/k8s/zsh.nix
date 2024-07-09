{ config, osConfig, pkgs, lib, ... }:

let
  role = config.role;
in

with lib;
{
  imports =
  [
    ../../roles.nix
    ../../hosts/${osConfig.networking.hostName}/roles.nix
  ];

  programs = mkIf role.k8s {
    zsh = {
      initExtra = "source <(kubectl completion zsh)";
      shellAliases = {
        k="kubectl";
      };
    };
  };
}
