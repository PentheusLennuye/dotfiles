{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libretro.scummvm
    libretro.fbneo
    libretro.mame
    retroarch
  ];
}
