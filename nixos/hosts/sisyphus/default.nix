{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./bootloaders.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./opengl.nix
    ./runlevel5.nix
    ./variables.nix
  ];
}
