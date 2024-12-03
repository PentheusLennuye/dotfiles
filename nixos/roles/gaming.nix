{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libretro.scummvm
    libretro.fbneo
    retroarch
  ];
}
