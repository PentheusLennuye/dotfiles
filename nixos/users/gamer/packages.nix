{ pkgs, ... }:

{
  home.packages = with pkgs; [
    emulationstation
    libretro.mame
    libretro.mame2016
  ];
}
