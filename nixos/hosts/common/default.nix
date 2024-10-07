{ config, pkgs, ... }:

{
  imports = [
    ./hosts.nix
    ./networking.nix
    ./oryx.nix
    ./printing.nix
    ./sound.nix
    ./system-packages.nix
    ./tls.nix
  ];
}
