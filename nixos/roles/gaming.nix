{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # emulationstation-de
    # retroarchFull
  ];
}
