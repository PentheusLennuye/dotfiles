# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.68.11 zantetsuken.cummings-online.local zantetsuken
    192.168.68.12 jigen.cummings-online.local jigen
    192.168.68.33 sisyphus.cummings-online.local sisyphus
    192.168.68.73 goemon.cummings-online.local goemon harbor.cummings-online.local harbor
  '';
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
}
