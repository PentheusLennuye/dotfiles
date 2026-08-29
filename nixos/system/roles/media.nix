{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asunder
    handbrake
    libbluray-full
    playerctl
    spotify
    teams-for-linux
    vlc
  ];
}
