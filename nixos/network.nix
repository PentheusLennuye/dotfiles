# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    1.2.3.4  thingy thingy1.domain1
    1.2.3.5  thingy thingy2.domain1
  '';
  networking.hostName = ""; # Define your hostname.
  networking.nameservers = [ "1.2.3.1" ];
  networking.search = [ "domain.A" "domain.B" ];
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks."SSID".pskRaw = "SSID generated";
  networking.interfaces.wifidev.ipv4.addresses = [{  # Replace wifidev with wlpxxxx
    address = "1.2.3.4";
    prefixLength = 24;
  }];
  networking.defaultGateway = {
    address = "1.2.3.1";
    interface = "wifidev"; # Replace wifidev with wlpxxxx
  };
}
