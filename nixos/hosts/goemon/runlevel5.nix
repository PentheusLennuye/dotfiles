{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    liberation_ttf dina-font proggyfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  security.polkit.enable = true;

  # HYPRLAND

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;

  # KDE 6

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.defaultSession = "plasma";
    xserver.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
  };
}
