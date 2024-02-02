{ config, pkgs, ... }:

# Glaucus is a laptop. No need for static ip here.
{
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    192.168.68.70 debian-common.cummings-online.local debian-common
    192.168.68.71 netboxdemo.cummings-online.local netboxdemo
  '';

  networking.hostName = "glaucus";
}
