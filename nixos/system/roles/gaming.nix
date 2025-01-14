{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libretro.scummvm
    libretro.fbneo
    libretro.mame
    retroarch
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
