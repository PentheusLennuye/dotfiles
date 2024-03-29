# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.68.33 sisyphus.cummings-online.local sisyphus
    192.168.68.70 debian-common.cummings-online.local debian-common
    192.168.68.71 netboxdemo.cummings-online.local netboxdemo
  '';
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
}
