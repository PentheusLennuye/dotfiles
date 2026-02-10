{ config, pkgs, ... }:

{
  imports = [
    ./bootloaders.nix
    ./hardware-configuration.nix
    ../../models/lenovo_thinkbook_14s_gen1.nix
    ./networking.nix
    ./hibernation.nix
  ];
}
