{ pkgs, config, ... }:

{
  home.file.".config/hypr/hypridle.conf".source = hypr/hypridle.conf;
  home.file.".config/hypr/hyprland.conf".source = hypr/hyprland.conf;
  home.file.".config/hypr/hyprlock.conf".source = hypr/hyprlock.conf;
  home.file.".config/hypr/hyprpaper.conf".source = hypr/hyprpaper.conf;
  home.file.".config/hypr/bg.jpg".source = hypr/bg.jpg;
}
