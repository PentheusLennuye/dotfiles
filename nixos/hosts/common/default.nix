{ config, pkgs, ... }:

{
  imports = [
    ./hosts.nix
    ./oryx.nix
    ./sound.nix
    ./system-packages.nix
    ./tls.nix
  ];
}
