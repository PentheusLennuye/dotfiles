{ config, pkgs, ... }:

{
  imports = [
    ./oryx.nix
    ./sound.nix
    ./system-packages.nix
    ./tls.nix
  ];
}
