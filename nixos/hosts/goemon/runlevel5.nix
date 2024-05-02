{ config, pkgs, ... }:

{
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

  services.desktopManager.plasma6.enable = true;

  # SDDM

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.videoDrivers = [ "amdgpu" ];

}
