{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    liberation_ttf dina-font proggyfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;
}

