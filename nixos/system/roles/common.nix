{ config, pkgs, ... }:

{
  imports = [
    ../modules/common_networking.nix
    ../modules/common_packages.nix
    ../modules/common_tls.nix
  ];
}
