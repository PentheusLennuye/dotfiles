# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.68.11 zantetsuken.cummings-online.local zantetsuken
    192.168.68.12 jigen.cummings-online.local jigen
    192.168.68.13 docker.cummings-online.local docker
    192.168.68.14 portainer.cummings-online.local portainer
    192.168.68.15 ipa.cummings-online.local ipa 
    192.168.68.16 vault.cummings-online.local vault
    192.168.68.17 awx.cummings-online.local awx

    192.168.68.73 goemon.cummings-online.local goemon
    192.168.68.74 goliath.cummings-online.local goliath

    192.168.68.111 i1.cummings-online.local i1
    192.168.68.112 i2.cummings-online.local i2
  '';
  networking.search = [ "cummings-online.local" "cummings-online.ca" ];
}
