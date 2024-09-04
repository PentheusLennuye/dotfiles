{ pkgs, ... }:

{
  home.packages = with pkgs; [
    emulationstation-de
    retroarchFull
  ];
}
