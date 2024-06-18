{ config, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./packages.nix
  ];
}
