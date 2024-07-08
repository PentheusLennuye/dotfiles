{ config, pkgs, lib, ... }:

let
  role = config.role;
in

with lib;
{
  home = mkIf role.workstation {
    packages = with pkgs; [
      texliveMedium
      pandoc
    ];
  };
}
