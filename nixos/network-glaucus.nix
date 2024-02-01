{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    192.168.68.70 debian-common.cummings-online.local debian-common
    192.168.68.71 netboxdemo.cummings-online.local netboxdemo
  '';

  networking.hostName = "glaucus"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
