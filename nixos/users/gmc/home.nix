{ pkgs, ... }:

{
  imports = [
    ../audioengineer
    ../developer
    ../poweruser
    ../publisher
    ./hyprland.nix
    ./localbin.nix
    ./kde.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./vim.nix
    ./vscode.nix
    ./waybar.nix
    ./zsh.nix
  ];

  # Home =====================================================================
  home.homeDirectory = "/home/gmc";
  home.sessionPath = [ "/home/gmc/.local/bin" ];
  home.sessionVariables.NIXOS_OZONE_WL = "1";  # Wayland on Chromium etc
  home.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";  # Hyprland cursor
  home.stateVersion = "23.11";
  home.username = "gmc";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };


  # Programs =================================================================

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  programs.kitty.settings = {
    shell = "zsh";
    font_family = "JetBrains mono";
    font_size = "11.5";
    background_opacity = "0.7";
  };
}

