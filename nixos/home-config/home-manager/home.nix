{ pkgs, ... }:

{
  imports = [
    ./starship.nix
    ./packages.nix
    ./waybar.nix
    ./zsh.nix
  ];

  # Home =====================================================================
  home.homeDirectory = "/home/gmc";
  home.sessionVariables.NIXOS_OZONE_WL = "1";  # Wayland on Chromium etc
  home.stateVersion = "23.11";
  home.username = "gmc";


  # Programs =================================================================

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_family = "JetBrains mono";
    font_size = "11.5";
    background_opacity = "0.7";
  };
}

