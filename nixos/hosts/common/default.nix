{ config, pkgs, ... }:

{
  imports = [
    ./oryx.nix
    ./system-packages.nix
    ./tls.nix
  ];
}
