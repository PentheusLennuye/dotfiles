# Packages that drive hardware specific to the host
{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        streamdeck-ui
    ];
}
