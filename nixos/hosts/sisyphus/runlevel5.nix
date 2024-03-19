{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    liberation_ttf dina-font proggyfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.hyprland = {
    enable = true;
    # enableNvidiaPatches = true;  # No effect in branch unstable
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;

  security.polkit.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
}
