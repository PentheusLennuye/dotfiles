{ lib, ... }:
let
  hostName = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);
  lconfig = ".config/hypr";
in
{
  home.file."${lconfig}/hypridle.conf".source = hypr/hypridle.conf;
  home.file."${lconfig}/hyprland.conf".source = hypr/hyprland.conf;
  home.file."${lconfig}/profile.conf".source = hypr/${hostName}.conf;
  home.file."${lconfig}/hyprlock.conf".source = hypr/hyprlock.conf;
  home.file."${lconfig}/hyprpaper.conf".source = hypr/hyprpaper.conf;
  home.file."${lconfig}/bg.jpg".source = hypr/bg.jpg;
}
