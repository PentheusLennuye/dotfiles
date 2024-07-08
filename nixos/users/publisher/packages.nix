{ config, osConfig, pkgs, lib, ... }:

let
  role = config.role;
in

with lib;
{

  imports = [
    ../../roles.nix
    ../../hosts/${osConfig.networking.hostName}/roles.nix
  ];

  home = mkIf role.workstation {
    packages = with pkgs; [
      texliveMedium
      pandoc
    ];
  };
}
