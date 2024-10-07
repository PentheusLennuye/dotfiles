{ config, pkgs, ... }:

{
  imports = [
    ./bootloaders.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];
}
