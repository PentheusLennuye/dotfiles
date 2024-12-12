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
    hypridle
  ];

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
    liberation_ttf dina-font proggyfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock = {
     enable = true;
  };

  security.polkit.enable = true;
  security.pam.services.hyprlock = {};

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.theme = "Elegant";
    xserver.enable = true;
  };
}

