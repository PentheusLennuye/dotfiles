{ config, pkgs, ... }:

{
  imports = [
    ../modules/gmc-wants.nix
    ../modules/oryx.nix
    ../modules/printing.nix
    ../modules/sound.nix
  ];

  environment.systemPackages = with pkgs; [
    elegant-sddm
  ];

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

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "Elegant";
    displayManager.sddm.wayland.enable = true;
    xserver.enable = true;
  };
}

