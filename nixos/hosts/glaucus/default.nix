{ config, pkgs, ... }:

{
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
    ./opengl.nix
    ./runlevel5.nix
  ];
}
