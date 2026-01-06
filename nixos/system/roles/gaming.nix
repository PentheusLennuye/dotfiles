{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    heroic
    libretro.scummvm
    libretro.fbneo
    libretro.mame
    lutris
    mangohud
    retroarch
    protonup-ng
  ];
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
