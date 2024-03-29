# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.hostName = "sisyphus";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  # services.blueman.enable = true;
}
