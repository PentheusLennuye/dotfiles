{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    rpi-imager
  ];
}
