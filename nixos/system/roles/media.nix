{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      asunder
      handbrake
      libbluray-full
      playerctl
      spotify
  ];
}
